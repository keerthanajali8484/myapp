class CommentsController < ApplicationController
  before_action :require_user
  
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.build(comment_params)
    @comment.chef = current_chef
    # @comment.rating = :rating
    puts @comment
    puts @comment.rating
    if @comment.save
      redirect_to recipe_path(@recipe)
      flash[:success] = "Comment was created successfully"
    else
      flash[:danger] = "Comment was not created"
      redirect_to recipe_path(@recipe)
    end
  end
  def show
    @recipe = Recipe.find(params[:id])
    @comment = Comment.new
  end
  
  
  private
  
  def comment_params
    params.require(:comment).permit(:description, :rating)
  end
  
end