class AddThemesToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :themes, :string, array: true, default: []
  end
end
