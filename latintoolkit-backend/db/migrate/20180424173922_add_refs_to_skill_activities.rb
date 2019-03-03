class AddRefsToSkillActivities < ActiveRecord::Migration[5.1]
  def change
    add_reference :skill_activities, :user, foreign_key: true
    add_reference :skill_activities, :skill, foreign_key: true
  end
end
