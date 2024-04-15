class AddIngredientToRecipe < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :ingredient_id, :integer
  end
end
