class Recipe < ApplicationRecord
    validates :name,presence:true
    validates :description,presence:true, length:{minimum:5,maximum:500}
    belongs_to :chef
    # belongs_to :ingredient
    validates:chef_id,presence: true
    default_scope -> { order(updated_at: :desc) }
    belongs_to :ingredient
    # has_many :ingredients, through: :recipe_ingredients
    has_many :comments, dependent: :destroy
    has_many :recipe_ratings, dependent: :destroy

end