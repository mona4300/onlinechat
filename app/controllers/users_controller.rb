class UsersController < ApplicationController

	def new
    redirect_to room_url if current_user
    @user = User.new
  end

	def create
    @user = User.new(user_params)
    if @user.save
      session[:username] = @user.username
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
