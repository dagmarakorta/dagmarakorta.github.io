class AddSortColumnToWishlists < ActiveRecord::Migration[7.0]
  def change
    add_column :wishlists, :sort, :integer, default: 0
  end
end
