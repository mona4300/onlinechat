class ChatController < ApplicationController

  before_action :check_user
  
  def room
     @names = User.pluck(:username)
  end

  private

  def check_user
    redirect_to root_url unless session[:username]
  end

end
