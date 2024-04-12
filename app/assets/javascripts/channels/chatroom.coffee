App.chatroom = App.cable.subcriptions.create "ChatroomChannel"

received: (data) ->
    $('#messages').append data['message']
    $('#message_content').val ''
    scrollToBottom()
  return

    jQuery(document).on 'turbolinks:load', ->
      scrollToBottom()
      return