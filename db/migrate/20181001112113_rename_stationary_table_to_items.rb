class RenameStationaryTableToItems < ActiveRecord::Migration[5.2]
  def change
  	rename_table :stationaries, :items
  end
end
