class AddRatingToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :rating, :integer
  end
end
