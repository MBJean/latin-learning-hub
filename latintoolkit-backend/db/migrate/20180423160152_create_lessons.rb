class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|
      t.string :name
      t.string :description
      t.string :badge

      t.timestamps
    end
  end
end
