class ChefsController < ApplicationController
    before_action :set_chef, only: [:show, :edit, :update, :destroy]
    before_action :require_same_user, only: [:edit, :update,]
    
    # before_action :require_admin, only: [:destroy]
    
    def index
      @chefs = Chef.paginate(page: params[:page], per_page: 5)

    end
    
    def new
      @chef = Chef.new
    end
    
    def create
      @chef = Chef.new(chef_params)
      if @chef.save
        session[:chef_id] = @chef.id
        cookies.signed[:chef_id] = @chef.id
        flash[:success] = "Welcome #{@chef.name} to Cookbook!"
        redirect_to chef_path(@chef)
      else
        # render 'new'

        render :new, status: :unprocessable_entity
      end
    end
    
    def show
      @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 5)
      @chef = Chef.find(params[:id])
    @recipes = @chef.recipes
    end
    
    def edit
    end
    
    def update
      if @chef.update(chef_params)
        flash[:success] = "Your account was updated successfully"
        redirect_to @chef
      else
        render 'edit'
      end  
    end
    
    def destroy
       Chef.find(params[:id]).destroy
        # @chef.destroy
        flash[:danger] = "Chef and all associated recipes have been deleted!"
        if !current_chef&.admin?
          redirect_to logout_path
        else
          redirect_to chefs_path, status: 303
        end

        
    
      
    end
    
    private
    
    def chef_params
      params.require(:chef).permit(:name, :email, :password, :password_confirmation)
    end
    
    def set_chef
      @chef = Chef.find(params[:id])
    end
    
    def require_same_user
      if current_chef != @chef and !current_chef.admin?
        flash[:danger] = "You can only edit or delete your own account"
        redirect_to chefs_path
      end
    end
    
    def require_admin
      if logged_in? && !current_chef.admin?
        flash[:danger] = "Only admin users can perform that action"
        redirect_to root_path
      end
    end
    
  end
  
  