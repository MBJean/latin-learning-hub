class CreateAnnotations < ActiveRecord::Migration[5.1]
  def change
    create_table :annotations do |t|
      t.string :content
      t.references :user
      t.references :author
      t.references :text
      t.references :book
      t.references :section
      t.references :line
      t.references :annotation_group
      t.timestamps
    end
  end
end
