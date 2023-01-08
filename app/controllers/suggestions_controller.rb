class SuggestionsController < ApplicationController
  def index
    skip_policy_scope
    fav_games = current_user.favorites.map(&:game)
    @genres = fav_games.pluck(:genres).flatten
    @themes = fav_games.pluck(:themes).flatten
    @tags = fav_games.pluck(:tags).flatten
    @suggestions = Game.with_any_tags(@genres.map(&:downcase) + @themes.map(&:downcase)).where.not("franchises && ARRAY[?]::varchar[]", fav_games.pluck(:franchises).flatten).to_a
    fav_games.each { |game| @suggestions.delete(game) }
    @suggestions = @suggestions.sort_by { |game| -(game.tags & @tags).size.fdiv((game.tags + @tags).uniq.size) }.select { |game| game.rating > 80 }.first(20)
  end
end
