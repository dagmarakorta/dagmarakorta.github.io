class AddColumnsToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :release_date, :date
    add_column :games, :developer, :string
    add_column :games, :franchise, :string
    add_column :games, :game_modes, :string, array: true
  end
end
