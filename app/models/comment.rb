class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many   :replies, class_name: 'Reply', foreign_key: :comment_id, dependent: :destroy
end
