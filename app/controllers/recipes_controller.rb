class RecipesController < ApplicationController
    
def index
    @recipes = Recipe.all # Or any other logic to fetch the recipes
end
  
    

end