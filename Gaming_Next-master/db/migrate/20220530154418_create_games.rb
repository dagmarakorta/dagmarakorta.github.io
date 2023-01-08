class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :name
      t.text :summary
      t.string :screenshots, array: true
      t.string :videos, array: true
      t.string :cover
      t.string :platforms, array: true
      t.string :tags, array: true
      t.float :rating

      t.timestamps
    end
  end
end
