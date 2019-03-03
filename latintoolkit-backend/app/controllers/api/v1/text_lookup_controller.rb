class Api::V1::TextLookupController < Api::V1::BaseController
  # skip_before_action :authenticate_user!

  def index
    @authors = Author.all.sort
    render :json => @authors
  end

  def by_short_name
    author = find_author
    texts = author.try(:texts)
    if author
      render json: {
        author: author,
        texts: texts
      } if author
    else
      not_found
    end
  end

  def by_text
    author = find_author
    text = find_text(author)
    books = text.try(:books)
    if text
      if books
        render json: {
          author: author,
          text: text,
          books: books
        }
      else
        lines = text.try(:lines)
        if lines
          render json: {
            author: author,
            text: text,
            lines: lines.map { |line|
              {
                id: line.id,
                content: line.content,
                line_number: line.line_number
              }
            }
          }
        else
          not_found
        end
      end
    else
      not_found
    end
  end

  def by_book
    @author = Author.find_by short_name: params[:short_name].titleize
    @text = @author.texts.find_by title: params[:text].titleize
    @book = @text.books.find_by book_number: params[:book]
    @sections = @book.sections
    if @sections.length > 0
      render json: {
        author: @author,
        text: @texts,
        book: @book,
        section: @sections
      }
    else
      render json: {
        author: @author,
        text: @text,
        book: @book,
        lines: @book.lines.map { |line|
          {
            id: line.id,
            content: line.content,
            line_number: line.line_number
          }
        }
      }
    end
  end

  def by_section
    @author = Author.find_by short_name: params[:short_name].titleize
    @text = @author.texts.find_by title: params[:text].titleize
    @book = @text.books.find_by book_number: params[:book]
    @section = @book.try { |s| s.sections.find_by identifier: params[:section] }
    if @section == nil
      @line = @book.lines.find_by line_number: params[:section]
      render json: {
        author: @author,
        text: @text,
        book: @book,
        line: @line
      }
    else
      @lines = @section.lines
      render json: {
        author: @author,
        text: @text,
        book: @book,
        section: @section,
        lines: @section.lines.map { |line|
          {
            id: line.id,
            content: line.content,
            line_number: line.line_number
          }
        }
      }
    end
  end

  def by_line
    @author = Author.find_by short_name: params[:short_name].titleize
    @text = @author.texts.find_by title: params[:text].titleize
    @book = @text.books.find_by book_number: params[:book]
    @section = @book.sections.find_by identifier: params[:section]
    @line = @section.try { |s| s.lines.find_by line_number: params[:line] }
    if @line
      render json: {
        author: @author,
        text: @text,
        book: @book,
        section: @section,
        line: @line
      }
    else
      not_found
    end
  end

  private
  def find_author
    Author.try { |a| a.find_by short_name: params[:short_name].titleize }
  end

  def find_text(author)
    author.try { |a| a.texts.find_by title: params[:text].titleize }
  end

  def not_found
    render json: {
      error: 'not_found',
      response: 404
    }
  end
end
