class AddIndexForCupboardsOnStationary < ActiveRecord::Migration[5.2]
  def change
  	add_reference :cupboards, :stationary, foreign_key: true, index: true
  end
end
