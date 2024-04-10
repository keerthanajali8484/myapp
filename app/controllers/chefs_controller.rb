class ChefsController < ApplicationController
  
    def new
      @chef = Chef.new
    end
    def create
      @chef = Chef.new(chef_params)
      if @chef.save
        flash[:success] = "Welcome #{@chef.name} to MyRecipes App!"
        redirect_to chef_path(@chef)
      else
        render 'new'
      end
    end
    def index
      @chefs = Chef.all
    end
    def edit
      @chef = Chef.find(params[:id])
    end
  
    def update
      @chef = Chef.find(params[:id])
      if @chef.update(chef_params)
        flash[:success] = "#{@chef.name}'s profile updated "
        redirect_to chef_path(@chef)
      else
        render :edit
      end
    end
    def show
      @chef = Chef.find(params[:id])
    end
  
    private
    
    def chef_params
      params.require(:chef).permit(:name, :email, 
                                      :password, :password_confirmation)
    end
  end