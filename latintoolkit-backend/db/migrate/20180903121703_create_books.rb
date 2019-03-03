class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.integer :book_number
      t.references :author
      t.references :text
      t.timestamps
    end
  end
end
