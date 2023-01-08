class AddUniquenessConstraintToWishlists < ActiveRecord::Migration[7.0]
  def change
    add_index :wishlists, %i[user_id game_id], unique: true
  end
end
