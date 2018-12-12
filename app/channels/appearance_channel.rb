class AppearanceChannel < ApplicationCable::Channel

  def subscribed
  	puts "subscribed #{current_user.username}"
  	stream_from "chat_appearance"
  end

  def unsubscribed
    return unless current_user.persisted?
    puts "unsubscribed #{current_user.username}"
    puts "Conn Count: #{conn_count}"
    return if conn_count > 0
    puts "unsubscribed #{current_user.username} last available connection remove him"
    leave(current_user.username)
    current_user.destroy
    ActionCable.server.remote_connections.where(current_user: current_user).disconnect
  end

  def join
    ActionCable.server.broadcast("chat_appearance", {
    	username: current_user.username,
    	status: 'join'
    })
  end

  private
    def leave(username)
      ActionCable.server.broadcast("chat_appearance", {
      	username: username,
      	status: 'leave'
      })
    end
end