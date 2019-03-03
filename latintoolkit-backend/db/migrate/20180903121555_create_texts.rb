class CreateTexts < ActiveRecord::Migration[5.1]
  def change
    create_table :texts do |t|
      t.string :title
      t.string :genre
      t.string :style
      t.references :author
      t.timestamps
    end
  end
end
