class ChangeColumnFromRestaurants < ActiveRecord::Migration[5.0]
  def change
    change_column :restaurants, :favorite_count, :integer, default: 0
  end
end
