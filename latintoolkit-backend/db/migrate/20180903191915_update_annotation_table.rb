class UpdateAnnotationTable < ActiveRecord::Migration[5.1]
  def change
    remove_reference(:annotations, :annotation_group, index: true)
    drop_table(:annotation_groups)
  end
end
