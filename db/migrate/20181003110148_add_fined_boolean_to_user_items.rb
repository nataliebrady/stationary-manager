class AddFinedBooleanToUserItems < ActiveRecord::Migration[5.2]
  def change
  	add_column :user_items, :fined, :boolean, default: false
  end
end
