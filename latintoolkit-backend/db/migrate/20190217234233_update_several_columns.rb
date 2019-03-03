class UpdateSeveralColumns < ActiveRecord::Migration[5.1]
  def change
    add_reference(:lines, :author, index: true)
    add_reference(:lines, :text, index: true)
    add_reference(:lines, :book, index: true)
  end
end
