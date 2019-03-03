class CreateDictionaries < ActiveRecord::Migration[5.1]
  def change
    create_table :dictionaries do |t|
      t.string :key
      t.string :entry_id
      t.text :description

      t.timestamps
    end
  end
end
