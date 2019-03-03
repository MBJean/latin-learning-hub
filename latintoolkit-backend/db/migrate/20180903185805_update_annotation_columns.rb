class UpdateAnnotationColumns < ActiveRecord::Migration[5.1]
  def change
    remove_reference(:books, :author, index: true)
    remove_reference(:sections, :author, index: true)
    remove_reference(:sections, :text, index: true)
    remove_reference(:lines, :author, index: true)
    remove_reference(:lines, :text, index: true)
    remove_reference(:lines, :book, index: true)
    remove_reference(:annotation_groups, :author, index: true)
    remove_reference(:annotation_groups, :text, index: true)
    remove_reference(:annotation_groups, :book, index: true)
    remove_reference(:annotations, :author, index: true)
    remove_reference(:annotations, :text, index: true)
    remove_reference(:annotations, :book, index: true)
  end
end
