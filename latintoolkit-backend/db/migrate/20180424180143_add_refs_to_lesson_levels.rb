class AddRefsToLessonLevels < ActiveRecord::Migration[5.1]
  def change
    add_reference :lesson_levels, :lesson, foreign_key: true
    add_reference :lesson_levels, :skill, foreign_key: true
  end
end
