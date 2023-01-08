class WishlistsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :share ]

  def index
    @wishlists = policy_scope(Wishlist).order(sort: :asc)
    @i = 0
  end

  def create
    @wishlist = Wishlist.new
    @wishlist.user = current_user
    @wishlist.game = Game.find(params[:game_id])
    authorize @wishlist
    @wishlist.save
    redirect_back(fallback_location: wishlists_path)
  end

  def order
    params[:list_items_attributes].split(",").each_with_index do |id, index|
      wishlist = Wishlist.find(id)
      wishlist.sort = index
      authorize wishlist
      wishlist.save!
    end
  end

  def share
    @user = User.find(params[:id])
    @wishlists = @user.wishlists
    authorize @wishlists
    @i = 0
  end

  def destroy
    @wishlist = Wishlist.find(params[:id])
    authorize @wishlist
    @wishlist.destroy
    # redirect_to wishlists_path, status: :see_other
    redirect_back fallback_location: wishlists_path, status: :see_other
  end
end
