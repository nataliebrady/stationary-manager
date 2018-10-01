class AddItemQuantityColumn < ActiveRecord::Migration[5.2]
  def change
  	add_column :items, :item_quantity, :integer
  end
end
