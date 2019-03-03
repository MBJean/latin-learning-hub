class UpdateColumnForAnnotations < ActiveRecord::Migration[5.1]
  def change
    rename_column :annotations, :user_name, :username
  end
end
