

class WebsocketController < WebsocketRails::BaseController

  # メッセージが送信された時に呼ばれる
  def receive_message
    # クライアントからのメッセージの取得例
    name = message[:name]
    msg = message[:body]

    # websocket_chatイベントで接続しているクライアントにブロードキャスト
    broadcast_message :websocket_chat, message
  end

  # 新しいクライアントが接続してきた時に呼ばれる
  def login_client
    msg = { name: "", body: "[a new client logged in]" }
    broadcast_message :websocket_chat, msg
  end

  # クライアントがログアウトした時に呼ばれる
  def logout_client
    msg = { name: "", body: "[a client logged out]" }
    broadcast_message :websocket_chat, msg
  end

end
