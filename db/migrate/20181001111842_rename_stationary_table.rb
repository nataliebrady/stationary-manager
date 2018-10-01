class RenameStationaryTable < ActiveRecord::Migration[5.2]
  def change
  	rename_table :stationary, :stationaries
  end
end
