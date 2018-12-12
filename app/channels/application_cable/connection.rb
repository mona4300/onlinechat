module ApplicationCable
  class Connection < ActionCable::Connection::Base
  	identified_by :current_user
 
    def connect
      self.current_user = find_verified_user
    end
 
    private
      def find_verified_user
        verified_user = User.find_by(
          username: request.session[:username],
          token: request.session[:token]
        )
        puts "User name:#{verified_user.try(:username)} token: #{verified_user.try(:token)}"
        reject_unauthorized_connection if verified_user.nil?
        verified_user
      end
  end
end
