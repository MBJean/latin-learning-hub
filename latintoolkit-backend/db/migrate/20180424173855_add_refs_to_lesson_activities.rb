class AddRefsToLessonActivities < ActiveRecord::Migration[5.1]
  def change
    add_reference :lesson_activities, :user, foreign_key: true
    add_reference :lesson_activities, :lesson, foreign_key: true
  end
end
