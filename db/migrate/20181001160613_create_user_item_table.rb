class CreateUserItemTable < ActiveRecord::Migration[5.2]
  def change
    create_table :user_item_tables do |t|
    	t.references :user, foreign_key: true, index: true
    	t.references :item, foreign_key: true, index: true
    end
  end
end
