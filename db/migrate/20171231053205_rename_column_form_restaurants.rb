class RenameColumnFormRestaurants < ActiveRecord::Migration[5.0]
  def change
    rename_column :restaurants, :favorite_count, :favorites_count
  end
end
