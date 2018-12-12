App.cable.subscriptions.create "AppearanceChannel",
  # Called when the subscription is ready for use on the server.
  connected: ->
    @perform("join")

  disconnected: ->
    location.reload()
    

  received: (data) ->
    username = data['username']
    status = data['status']
    if status == 'join'
      @appendUser username
    else if status == 'leave'
      @removeUser username

  appendUser: (username) ->
    return true if @isUserExists(username)
    html = @prepareUserHTML(username)
    $("div.users ul").append(html)

  removeUser: (username) ->
    return true if !@isUserExists(username)
    $("div.users li[id='#{username}']").remove()

  isUserExists: (username) ->
    listItem = $("div.users li[id='#{username}']")
    return listItem.length > 0

  prepareUserHTML: (username) ->
    "<li class='list-group-item' id='#{username}'>#{username}</li>"
    