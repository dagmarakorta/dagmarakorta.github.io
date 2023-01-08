class AddIndexToTags < ActiveRecord::Migration[7.0]
  def change
    add_index :games, :tags, using: "gin"
  end
end
