class CreateLessonActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :lesson_activities do |t|
      t.decimal :completion
      t.datetime :last_attempted

      t.timestamps
    end
  end
end
