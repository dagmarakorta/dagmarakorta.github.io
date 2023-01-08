class AddGameToWishlists < ActiveRecord::Migration[7.0]
  def change
    add_reference :wishlists, :game, null: false, foreign_key: true
  end
end
