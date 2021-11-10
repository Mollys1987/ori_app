class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many   :replies, class_name: 'Reply', foreign_key: :comment_id, dependent: :destroy
  has_many   :notifications, dependent: :destroy
  
  def create_notification_reply!(current_user, reply_id)
    temp_ids = Reply.select(:user_id).where(comment_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_reply!(current_user, reply_id, temp_id['user_id'])
    end
    save_notification_reply!(current_user, reply_id, user_id) if temp_ids.blank?
  end

  def save_notification_reply!(current_user, reply_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      comment_id: id,
      reply_id: reply_id,
      visited_id: visited_id,
      action: 'reply'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
