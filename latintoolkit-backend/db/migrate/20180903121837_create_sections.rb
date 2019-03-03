class CreateSections < ActiveRecord::Migration[5.1]
  def change
    create_table :sections do |t|
      t.string :identifier
      t.references :author
      t.references :text
      t.references :book
      t.timestamps
    end
  end
end
