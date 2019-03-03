class AddContentToLines < ActiveRecord::Migration[5.1]
  def change
    add_column :lines, :content, :string
  end
end
