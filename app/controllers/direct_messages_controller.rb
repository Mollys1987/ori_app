class DirectMessagesController < ApplicationController
    
  def index
    if current_user.id.to_i == params[:id].to_i
      @user = User.find_by(id: params[:id])
      @message_user_ids = DirectMessage.where(to_user_id: @user.id).or(DirectMessage.where(user_id: @user.id)).distinct.pluck(:user_id)
      @message_user_ids.delete(@user.id)
    else
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
  end
  
  def roomshow
    if current_user.id.to_i == params[:user_id].to_i
      @to_user_id = params[:to_user_id]
      @messages = DirectMessage.where(user_id: params[:user_id],to_user_id: @to_user_id).or(DirectMessage.where(user_id: params[:to_user_id],to_user_id: params[:user_id])).order(created_at: :asc)
      unread_messages = DirectMessage.where(to_user_opentime: nil,to_user_id: current_user.id)
      unread_messages.each do |unread_message|
        unread_message.to_user_opentime = Date.today.to_time
        unread_message.save
      end
    else
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
  end
  
  def create
    if current_user.id.to_i == params[:user_id].to_i
      message = DirectMessage.new(content: params[:content],user_id: params[:user_id],to_user_id: params[:to_user_id])
      if message.save
        flash[:notice] = "送信しました！"
        redirect_back(fallback_location: root_path)
      else
        redirect_to("/")
        flash[:alert] = "投稿できませんでした"
      end
    end
  end
  
        # unread_messages = DirectMessage.where(to_user_opentime: nil, to_user_id: current_user.id)
        # unread_messages.each do |unread_message|
        #   unread_message.to_user_opentime = Date.today.to_time
        #   unread_message.save
        # end
  
end