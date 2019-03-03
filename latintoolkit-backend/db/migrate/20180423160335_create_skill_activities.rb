class CreateSkillActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :skill_activities do |t|
      t.decimal :completion
      t.decimal :proficiency

      t.timestamps
    end
  end
end
