class AppearanceChannel < ApplicationCable::Channel
  def subscribed
  	puts "subscribed #{current_user.username}"
  	stream_from "chat_appearance"
  end

  def unsubscribed
    puts "unsubscribed #{current_user.username}"
    leave(current_user.username)
    current_user.destroy
  end

  def join
    ActionCable.server.broadcast("chat_appearance", {
    	username: current_user.username,
    	status: 'join'
    })
  end

  def leave(username)
    ActionCable.server.broadcast("chat_appearance", {
    	username: username,
    	status: 'leave'
    })
  end
end