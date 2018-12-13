module ApplicationCable
  class Channel < ActionCable::Channel::Base
  	protected
  	def conn_count
      puts "#{current_user.username}"
      # Suitable if we have limited number of connections
      # Otherwise we may stop tracking tabs number 
      # and consider each tab as new user, without sessions
  		ActionCable.server.connections.select do |conn| 
        conn.current_user == current_user 
      end.length
  	end
  end
end
