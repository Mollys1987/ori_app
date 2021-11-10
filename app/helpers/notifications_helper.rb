module NotificationsHelper
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
  
  def notification_form(notification)
    @comment = nil
    @reply = nil
    @message = nil
    visitor = link_to notification.visitor.nickname, notification.visitor, style:"font-weight: bold;"
    your_post = link_to 'あなたの投稿', notification.post, style:"font-weight: bold;"
    your_comment = link_to 'あなたのコメント', notification.post, style:"font-weight: bold;"
    message = link_to 'メッセージ', "/chat/#{notification.visited.id}/#{notification.visitor.id}"
    
    case notification.action
      when "follow" then
        "#{visitor}があなたをフォローしました"
      when "like" then
        "#{visitor}が#{your_post}にいいね！しました"
      when "comment" then
        @comment = Comment.find_by(id: notification.comment_id)&.content
        "#{visitor}が#{your_post}にコメントしました"
      when "reply" then
        @reply = Reply.find_by(id: notification.reply_id)&.re_comment
        "#{visitor}が#{your_comment}にコメントしました"
      when "message" then
        @message = Message.find_by(id: notification.message_id)&.content
        "#{visitor}から#{message}がありました"
    end
  end
end
