class Game < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :wishlists, dependent: :destroy
  taggable_array :tags

  def favorite?(user)
    user.favorites&.map(&:game)&.include? self
  end

  def wishlist?(user)
    user.wishlists&.map(&:game)&.include? self
  end
end
