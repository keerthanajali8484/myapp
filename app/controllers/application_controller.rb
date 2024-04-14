class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :current_chef, :logged_in?
    add_flash_types :danger, :info, :warning, :success, :messages

    def current_chef
        if session[:chef_id]
          @current_chef ||= Chef.find_by(id: session[:chef_id])
        end
      end
      
      def logged_in?
        current_chef.present?
      end

    def require_user
        if !logged_in?
        flash[:danger] = "You must be logged in to perform that action"
        redirect_to root_path
        end
    end
end
