
class ChatSystem
  constructor: (url) ->
    @sock = null
    @connect url

    $("#send").click @sendMessage

    $("#url-changed").click => @connect $("#url").val()


  # 送信時の処理
  sendMessage: () =>
    # Notification の許可
    Notification.requestPermission()

    name = $("#name").val()
    msg = $("#comment").val()
    
    @sock.trigger "websocket_chat", { name: name, body: msg }

  # 受信時の処理
  receiveMessage: (msg) =>
    msg_li = $("<li>")
    msg_li.html "#{msg["name"]}: #{msg["body"]}"

    $("#chat_area").append msg_li

    # 通知
    notification = new Notification "#{msg.name}: #{msg.body}"

  # 接続処理
  connect: (url) =>
    if @sock?
      @disconnect()

    @sock = new WebSocketRails(url + ":3000/websocket")
    @sock.bind "websocket_chat", @receiveMessage
    @sock.trigger "login_client"

  # 接続解除処理
  disconnect: () =>
    @sock.trigger "logout_client"
    @sock.disconnect
    #@sock.unbind # https://github.com/websocket-rails/websocket-rails/issues/242
    @sock = null

$ ->
  window.chatSystem = new ChatSystem($("#url").val())
