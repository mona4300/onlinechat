class ApplicationController < ActionController::Base
	protected
	def current_user
		User.find_by(username: session[:username])
	end
end
