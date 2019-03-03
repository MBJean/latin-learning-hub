class CreateAnnotationGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :annotation_groups do |t|
      t.integer :start_index
      t.string :lemma
      t.references :author
      t.references :text
      t.references :book
      t.references :section
      t.references :line
      t.timestamps
    end
  end
end
