class AddReferenceToItems < ActiveRecord::Migration[5.2]
  def change
  	add_reference :items, :cupboards, foreign_key: true, index: true
  end
end
