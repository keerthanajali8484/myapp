class ChangeColumnInRecipes < ActiveRecord::Migration[7.1]
  def change
    rename_column :recipes,:email,:description
    change_column :recipes,:description,:text
  end
end
