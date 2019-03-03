class CreateUsersWordsJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :words do |t|
      t.index :user_id
      t.index :word_id
    end
  end
end
