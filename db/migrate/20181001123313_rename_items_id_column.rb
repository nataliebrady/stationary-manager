class RenameItemsIdColumn < ActiveRecord::Migration[5.2]
  def change
  	rename_column :items, :cupboards_id, :cupboard_id
  end
end
