class RemoveReferenceFromCupboards < ActiveRecord::Migration[5.2]
  def change
  	remove_reference :cupboards, :stationary, foreign_key: true, index: true
  end
end
