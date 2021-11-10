class Message < ApplicationRecord
  has_many :notifications, dependent: :destroy
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"
  belongs_to :room
  
  def save_notification_message!(current_user, message_id, receiver_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      visitor_id: current_user.id,
      message_id: message_id,
      visited_id: receiver_id,
      action: 'message'
    )
    
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
