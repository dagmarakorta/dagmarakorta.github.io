class AddGenresToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :genres, :string, array: true, default: []
  end
end
