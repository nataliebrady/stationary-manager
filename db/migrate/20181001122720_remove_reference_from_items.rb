class RemoveReferenceFromItems < ActiveRecord::Migration[5.2]
  def change
  	remove_reference :items, :cupboards, foreign_key: true, index: true
  end
end
