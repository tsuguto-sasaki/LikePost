class Tweet < ApplicationRecord
  belongs_to :member
  
  validates :content, presence: true, length: { maximum: 200}
  
  has_many :likes, foreign_key: 'tweet_id', dependent: :destroy
  has_many :members, through: :likes
end
