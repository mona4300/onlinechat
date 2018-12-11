class ChatChannel < ApplicationCable::Channel
  def subscribed
  	stream_from "chat_room"
  end

  def receive(data)
    ActionCable.server.broadcast("chat_room", {
    	sent_by: current_user.username,
    	body: data['body']
    })
  end
end