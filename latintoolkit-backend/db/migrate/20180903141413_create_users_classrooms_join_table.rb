class CreateUsersClassroomsJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :classrooms do |t|
      t.index :user_id
      t.index :classroom_id
    end
  end
end
