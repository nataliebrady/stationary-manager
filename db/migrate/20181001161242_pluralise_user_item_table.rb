class PluraliseUserItemTable < ActiveRecord::Migration[5.2]
  def change
  	rename_table :user_item, :user_items
  end
end
