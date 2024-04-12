App.comments = App.cable.subcriptions.create "CommentsChannel"
received: (data) -> $("#messages").prepend(data)