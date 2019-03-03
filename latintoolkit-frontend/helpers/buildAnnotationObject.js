const buildAnnotationObject = (options) => {
  let output_object = {
    error: null,
    response: {}
  };
  let selected_text = (document.all) ?
    document.selection.createRange().text:
    document.getSelection();
  let selected_range = selected_text.getRangeAt(0);
  let coordinates = {
    start: {
      line: selected_range.startContainer.parentElement.dataset.line,
      line_id: selected_range.startContainer.parentElement.dataset.lid,
      word: selected_range.startContainer.parentElement.dataset.word
    },
    end: {
      line: selected_range.endContainer.parentElement.dataset.line,
      line_id: selected_range.endContainer.parentElement.dataset.lid,
      word: selected_range.endContainer.parentElement.dataset.word
    }
  };
  // check if any of the above is undefined, which would indicated that a mark element has been highlighted
  // also check if anything inside the range has undefined datasets for the above, excluding newline characters
  let done = false;
  let any_marks_inside = false;
  let current_node = selected_range.startContainer.parentNode;
  let end_node = selected_range.endContainer.parentNode;
  while(!done) {
    if (current_node.data === '\n') {
      current_node = current_node.nextSibling;
    } else if (current_node.dataset.word === undefined) {
      any_marks_inside = true;
      done = true;
    } else if (current_node === end_node) {
      done = true;
    } else {
      current_node = current_node.nextSibling;
    }
  }
  if (any_marks_inside || coordinates.start.word === undefined || coordinates.end.word === undefined) {
    selected_text.removeRange(selected_range);
    output_object = {
      error: "already highlighted",
      response: null
    };
  } else {
    // walk through nodes to find all relevant text to build lemma 2d array (with 2nd dimension indicating line breaks)
    done = false;
    current_node = selected_range.startContainer.parentNode;
    let lemma_arr = [];
    let temp_str = "";
    while(!done) {
      if (current_node.data === '\n') {
        lemma_arr.push(temp_str.trim());
        temp_str = "";
        current_node = current_node.nextSibling;
      } else if (current_node === end_node) {
        temp_str += current_node.innerText;
        lemma_arr.push(temp_str.trim());
        done = true;
      } else {
        temp_str += current_node.innerText;
        current_node = current_node.nextSibling;
      }
    }
    // build an object that conforms to middleware expectations
    output_object = {
      error: null,
      response: {
        author_id: options.author_id,
        text_id: options.text_id,
        book_id: options.book_id,
        section_id: options.section_id,
        line_id: coordinates.start.line_id,
        line: coordinates.start.line,
        start_index: coordinates.start.word,
        lemma: lemma_arr.join('\n')
      }
    };
  }
  return output_object;
}

export default buildAnnotationObject;
