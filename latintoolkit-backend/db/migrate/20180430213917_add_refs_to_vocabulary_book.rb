class AddRefsToVocabularyBook < ActiveRecord::Migration[5.1]
  def change
    add_reference :vocabulary_books, :user, foreign_key: true
    add_reference :vocabulary_books, :word, foreign_key: true
  end
end
