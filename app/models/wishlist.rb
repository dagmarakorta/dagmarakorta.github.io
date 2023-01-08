class Wishlist < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :game, :user, presence: true
  validates :game_id, uniqueness: { scope: :user_id, message: "Game is already wishlisted" }
end
