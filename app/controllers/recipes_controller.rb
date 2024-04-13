class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update] 
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  def index
   @recipes = Recipe.paginate(page: params[:page],per_page: 5)
    
    @recipes = Recipe.where("name LIKE ?", "%#{params[:search]}%").paginate(page: params[:page], per_page: 10)

  end
  def show
    @comment = Comment.new
    @comments = @recipe.comments.paginate(page: params[:page], per_page: 5)
    @recipe = Recipe.find(params[:id])
    @recipes = Recipe.all  
  end
  def new
      @recipe = Recipe.new
  end
  def create
      @recipe = Recipe.new(recipe_params)
      @recipe = current_chef.recipes.build(recipe_params)
      if @recipe.save
        redirect_to @recipe
        flash[:success] ="Recipe created successfully!"
      else
        render 'new'
      end
  end
  def edit
    @recipe = Recipe.find(params[:id])
    @recipes = Recipe.all
    
  end
  
  def update
    
    if @recipe.update(recipe_params)
      flash[:success] = "Recipe  updated successfully!"
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end
  def destroy
    Recipe.find(params[:id]).destroy
    flash[:success] = "Recipe deleted successfully"
    redirect_to recipes_path
  end
    
  private
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
    def recipe_params
      params.require(:recipe).permit(:name, :description, ingredient_ids: [])
    end
    def require_same_user
      if logged_in? & !current_chef.admin?
        flash[:warning] = "Only admin users can perform that action"
        redirect_to root_path
      end
    end
  

  

end