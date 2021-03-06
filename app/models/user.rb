class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  # has_many :rooms, dependent: :destroy
  has_many :sender, class_name: "Room", foreign_key: "sender_id", dependent: :destroy
  has_many :receiver, class_name: "Room", foreign_key: "receiver_id", dependent: :destroy
  has_many :sender, class_name: "Message", foreign_key: "sender_id", dependent: :destroy
  has_many :receiver, class_name: "Message", foreign_key: "receiver_id", dependent: :destroy
  # has_many :messages, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :replies, class_name: 'Reply', foreign_key: :user_id, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  has_many :sender, class_name: "Consultation", foreign_key: "sender_id", dependent: :destroy
  has_many :receiver, class_name: "Consultation", foreign_key: "receiver_id", dependent: :destroy
  attr_accessor :remember_token
  
  validates :nickname, presence: true, length: { maximum: 30 },
                       uniqueness: true
  validates :age, presence: true
  validates :sex, presence: true
  validates :prefucture, presence: true
  validates :city, presence: true
  validates :classification, presence: true
  validates :nursing, presence: true
  validates :key_word1, presence: { message: '???????????????????????????????????????' }
  validates :answer_digest, presence: true
  
  mount_uploader :profile_image, ProfileImageUploader
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
  
  # ?????????????????????????????????
  def follow(other_user)
    following << other_user
  end

  # ???????????????????????????????????????
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # ????????????????????????????????????????????????true?????????
  def following?(other_user)
    following.include?(other_user)
  end

  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
  
  def save_notification_message!(current_user, message_id, receiver_id)
    # ??????????????????????????????????????????????????????????????????????????????????????????????????????
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
