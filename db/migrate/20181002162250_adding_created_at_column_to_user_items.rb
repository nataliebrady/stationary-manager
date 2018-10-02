class AddingCreatedAtColumnToUserItems < ActiveRecord::Migration[5.2]
  def change

  	  add_timestamps :user_items, null: true 

	  long_ago = DateTime.new(2018, 10, 02)
	  UserItem.update_all(created_at: long_ago, updated_at: long_ago)

  	  change_column_null :user_items, :created_at, false
      change_column_null :user_items, :updated_at, false
  end
end
