class AddPasswordToChefs < ActiveRecord::Migration[7.1]
  def change
    add_column :chefs, :password_digest, :string
  end
end
