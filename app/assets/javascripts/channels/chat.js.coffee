App.chatChannel = App.cable.subscriptions.create { channel: "ChatChannel" },
  received: (data) ->
    @appendMessage(data)
    @clearTextBox()

  appendMessage: (data) ->
    html = @prepareMsgHTML(data)
    $("div.messages-container ul").append(html)

  prepareMsgHTML: (data) ->
    """
    <li class="list-group-item">
      <b>#{data['sent_by']}:</b> #{data['body']}
    </li>
    """

  clearTextBox: ->
    $('textarea#inputMessage').val("");
    $('textarea#inputMessage').change();


$('document').ready ->
  $('form#sendMessageForm').on 'submit', ->
    message =  $('textarea#inputMessage').val()
    if message != null && message != ''
      App.chatChannel.send({ body: $('textarea#inputMessage').val() })
    return false

  $('textarea#inputMessage').on 'change keyup paste', ->
    button = $('form#sendMessageForm button')
    message =  $('textarea#inputMessage').val()
    if message != null && message != ''
      button.removeClass('disabled')
    else
      button.addClass('disabled')