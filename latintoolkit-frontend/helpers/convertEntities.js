// description: takes a string (in this case, xml rendered as a string) and manually replaces the unusual HTML entities ibreve and ebreve with something more legible

const convertEntities = (str) => {
  let ad_hoc_repl_1 = new RegExp("&ibreve;", "g");
  let ad_hoc_repl_2 = new RegExp("&ebreve;", "g");
  let str_output = str.replace(ad_hoc_repl_1, "&breve;i");
  str_output = str_output.replace(ad_hoc_repl_2, "&breve;e");
  return str_output;
}

export default convertEntities;
