class AddStationary < ActiveRecord::Migration[5.2]
  def change
    create_table :stationary do |t|
      t.string :name

      t.timestamps
    end
  end
end
