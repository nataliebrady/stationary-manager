class MakingReturnedBooleanTrue < ActiveRecord::Migration[5.2]
  def change
  	change_column :user_items, :returned, :boolean, default: true
  end
end
