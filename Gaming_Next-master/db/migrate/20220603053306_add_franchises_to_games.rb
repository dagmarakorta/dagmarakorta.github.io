class AddFranchisesToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :franchises, :string, array: true, default: []
  end
end
