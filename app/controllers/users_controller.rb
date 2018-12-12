class UsersController < ApplicationController

	def new
    redirect_to room_url if current_user
    @user = User.new
  end

	def create
    @user = User.new(user_params)
    @user.token = SecureRandom.urlsafe_base64(nil, false)
    if @user.save
      session[:username] = @user.username
      session[:token] = @user.token
      redirect_to room_url
    else
      render action: :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end
