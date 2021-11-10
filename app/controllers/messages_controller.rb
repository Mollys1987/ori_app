class MessagesController < ApplicationController
  def sending
    @sender = current_user
    @receiver = User.find_by(id: params[:receiver_id])
    if params[:message][:room_id]
      @exist_room = Room.find_by(id: params[:message][:room_id])
      @message = @exist_room.messages.build(message_params)
      @message.sender_id = current_user.id
      if @message.sender_id == @exist_room.sender_id
        @message.receiver_id = @exist_room.receiver_id
      else
        @message.receiver_id = @exist_room.sender_id
      end
    else
      @exist_room = room_check(params[:message][:sender_id], params[:message][:receiver_id])
      if !@exist_room
        @room = Room.create(rooms_params)
      end
      @message = Message.new(message_params)
      @message.room_id = @room.id
    end
    if @message.save
      p @message
      p '1==='
      if current_user.id == @message.sender.id
        @mes_receiver =  @message.receiver
      else
        @mes_receiver =  @message.sender
      end
      @message.save_notification_message!(current_user.id, @mes_receiver.id, @message.id)
      p @message.save_notification_message.errors.full_messages
      flash[:notice] = "メッセージを送信しました！"
      if @exist_room
        redirect_to exist_room_path(@exist_room.id)
      else
        redirect_to exist_room_path(@room.id)
      end
    else
      flash[:alert] = "メッセージを送信できませんでした"
      render "rooms/chat"
    end
  end
    
  private
    def message_params
      params.require(:message).permit(:content, :sender_id, :receiver_id, :room_id)
    end
    
    def rooms_params
      params.require(:message).permit(:sender_id, :receiver_id)
    end
end