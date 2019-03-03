class CreateLines < ActiveRecord::Migration[5.1]
  def change
    create_table :lines do |t|
      t.string :line_number
      t.references :author
      t.references :text
      t.references :book
      t.references :section
      t.timestamps
    end
  end
end
