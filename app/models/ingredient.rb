class Ingredient < ApplicationRecord
    validates :name, presence: true, length: { minimum: 3, maximum: 25 }
    validates_uniqueness_of :name
    has_one :recipe
    # has_many :recipes, through: :recipe_ingredients
  end