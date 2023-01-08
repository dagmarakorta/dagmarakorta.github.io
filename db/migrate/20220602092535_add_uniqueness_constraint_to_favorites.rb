class AddUniquenessConstraintToFavorites < ActiveRecord::Migration[7.0]
  def change
    add_index :favorites, %i[user_id game_id], unique: true
  end
end
