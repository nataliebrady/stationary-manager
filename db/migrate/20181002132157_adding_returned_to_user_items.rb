class AddingReturnedToUserItems < ActiveRecord::Migration[5.2]
  def change
  	add_column :user_items, :returned, :boolean, default: false
  end
end
