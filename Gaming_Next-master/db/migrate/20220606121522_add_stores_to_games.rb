class AddStoresToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :stores, :string, array: true
  end
end
