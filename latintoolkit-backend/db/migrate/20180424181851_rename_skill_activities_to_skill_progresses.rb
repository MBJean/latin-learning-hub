class RenameSkillActivitiesToSkillProgresses < ActiveRecord::Migration[5.1]
  def change
    rename_table :skill_activities, :skill_progresses
  end
end
