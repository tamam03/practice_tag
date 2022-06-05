class TagMap < ApplicationRecord
  belongs_to :post
  belongs_to :tag
  
  validates :post_id, presence: true
  validates :tag_id,presence: true
  
  # PostとTagの関係を構築する際二つの外部キーが存在することは絶対なのでバリデーションをかける
end
