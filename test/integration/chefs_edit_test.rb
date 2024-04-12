require "test_helper"

class ChefsEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(name: "mashrur", 
                       email: "mashrur@example.com",
                           password: "password", 
                           password_confirmation: "password")
   end
   
   test "reject an invalid edit" do
    sign_in_as(@chef, "password")
     get edit_chef_path(@chef)
     assert_template 'chefs/edit'
     patch chef_path(@chef), params: { chef: { name: " ", 
                               email: "mashrur@example.com" } }
     assert_template 'chefs/edit'
     assert_select 'h2.panel-title'
     assert_select 'div.panel-body'
   end
   
   test "accept valid signup" do
     sign_in_as(@chef, "password")
     get edit_chef_path(@chef)
     assert_template 'chefs/edit'
     patch chef_path(@chef), params: { chef: { name: "mashrur1", 
                                 email: "mashrur1@example.com" } }
     assert_redirected_to @chef
     assert_not flash.empty?
     @chef.reload
     assert_match "mashrur1", @chef.chefname
     assert_match "mashrur1@example.com", @chef.email
   end
 
 Update the chef.rb model file and allow for nil values for password:
 
 validates :password, presence: true, length: { minimum: 5 }, allow_nil: true
 
 Add the edit and update actions for the chefs_controller.rb file:
 
   def edit
     @chef = Chef.find(params[:id])
   end
   
   def update
     @chef = Chef.find(params[:id])
     if @chef.update(chef_params)
       flash[:success] = "Your account was updated successfully"
       redirect_to @chef
     else
       render 'edit'
     end  
   end
end
