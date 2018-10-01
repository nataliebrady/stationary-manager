class AddBorrowableColumnToItems < ActiveRecord::Migration[5.2]
  def change
  	add_column :items, :borrowable, :boolean, default: false
  end
end
