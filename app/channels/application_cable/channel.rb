module ApplicationCable
  class Channel < ActionCable::Channel::Base
  	protected
  	def conn_count
      puts "#{current_user.username}"
  		ActionCable.server.connections.select do |conn| 
        conn.current_user == current_user 
      end.length
  	end
  end
end
