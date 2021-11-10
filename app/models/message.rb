class Message < ApplicationRecord
  has_many :notifications, dependent: :destroy
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"
  belongs_to :room
  
  def save_notification_message!(sender_id, receiver_id, message_id)
    notification = sender.active_notifications.new(
      visitor_id: sender_id,
      visited_id: receiver_id,
      message_id: message_id,
      action: 'message'
    )
    
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
