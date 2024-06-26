class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
    def create
        @message = Message.new(message_params)
    @message.chef = current_chef
    if @message.save
      redirect_to chat_path
    elsif @message.content != ""
      ActionCable.server.broadcast 'chatroom_channel', 
      message: render_message(@message), 
                chef: @message.chef.name
    else
      flash[:warning] = "Message is empty"
      redirect_to chat_path
    end
      
    end
    
    private
    
    def message_params
        params.require(:message).permit(:content)
    end
    def render_message(message)
      render(partial: 'message', locals: { message: message } )
    end
  
    
  end
  
  