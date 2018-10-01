class RenameUserItemTable < ActiveRecord::Migration[5.2]
  def change
  	rename_table :user_item_tables, :user_item
  end
end
