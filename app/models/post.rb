class Post < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :replies, class_name: 'Reply', foreign_key: :user_id, dependent: :destroy
    has_many :notifications, dependent: :destroy
    
    default_scope -> { order(created_at: :desc) }
    mount_uploader :picture1, PictureUploader
    mount_uploader :picture2, PictureUploader
    mount_uploader :picture3, PictureUploader
    mount_uploader :picture4, PictureUploader
    mount_uploader :picture5, PictureUploader
    mount_uploader :video, VideoUploader
    validates :title, presence: true, length: { maximum: 50 }
    validates :content, presence: true, length: { maximum: 255 }
    validates :key_word1, presence: { message: 'は１つは入力してください。' }
    validates :user_id, presence: true
    validate :picture_size1
    validate :picture_size2
    validate :picture_size3
    validate :picture_size4
    validate :picture_size5
    
  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
  
  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
    
    private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size1
      if picture1.size > 5.megabytes  
        errors.add(:picture1, "の容量が5MBを超えているため投稿できません。")
      end
    end
    
    def picture_size2
      if picture2.size > 5.megabytes  
        errors.add(:picture2, "の容量が5MBを超えているため投稿できません。")
      end
    end
    
    def picture_size3
      if picture3.size > 5.megabytes  
        errors.add(:picture3, "の容量が5MBを超えているため投稿できません。")
      end
    end
    
    def picture_size4
      if picture4.size > 5.megabytes  
        errors.add(:picture4, "の容量が5MBを超えているため投稿できません。")
      end
    end
    
    def picture_size5
      if picture5.size > 5.megabytes  
        errors.add(:picture5, "の容量が5MBを超えているため投稿できません。")
      end
    end
end
