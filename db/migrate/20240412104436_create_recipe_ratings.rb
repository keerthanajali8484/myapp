class CreateRecipeRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :recipe_ratings do |t|
      t.integer :recipe_id
      t.integer :rating
      

      t.timestamps
    end
  end
end
