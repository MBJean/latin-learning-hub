class CreateLessonLevels < ActiveRecord::Migration[5.1]
  def change
    create_table :lesson_levels do |t|
      t.integer :level

      t.timestamps
    end
  end
end
