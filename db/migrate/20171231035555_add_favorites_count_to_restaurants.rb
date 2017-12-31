class AddFavoritesCountToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :favorite_count, :integer
  end
end
