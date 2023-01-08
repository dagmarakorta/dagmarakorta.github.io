class FavoritesController < ApplicationController
  def index
    @favorites = policy_scope(Favorite)
    @favorite = Favorite.new
    @games = []

    if params[:query].present?
      @games = Game.where('unaccent(name) ILIKE unaccent(?)', "%#{params[:query]}%").first(10)
    end

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "list", locals: { games: @games }, formats: [:html] }
    end
  end

  def create
    @favorite = Favorite.new
    @favorite.user = current_user
    @favorite.game_id = params[:game_id]
    authorize @favorite
    @favorite.save!
    # params[:query] = ''
    if params[:query]
      redirect_to favorites_path(query: params[:query])
    else
      redirect_back(fallback_location: favorites_path)
    end
  end

  def update
    @favorite = Favorite.find(params[:id])
    authorize @favorite
    if @favorite.update
      redirect_to favorite_path
    else
      render favorite_path
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    authorize @favorite
    @favorite.destroy
    # params[:query] = ''
    # redirect_to favorites_path(query: params[:query]), status: :see_other
    if params[:query]
      redirect_to favorites_path(query: params[:query]), status: :see_other
    else
      redirect_back(fallback_location: favorites_path, status: :see_other)
    end
  end

  private

  def favorite_params
    params.require(:favorite).permit(:user_id, :game_id)
  end
end
