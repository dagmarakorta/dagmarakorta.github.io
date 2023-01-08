class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    authorize @game
  end
  

end
