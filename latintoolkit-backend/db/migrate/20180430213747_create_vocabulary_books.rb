class CreateVocabularyBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :vocabulary_books do |t|

      t.timestamps
    end
  end
end
