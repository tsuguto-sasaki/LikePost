class Member < ApplicationRecord
  before_save { self.email.downcase!}
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :tweets
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :member
  has_many :likes
  has_many :likeposts, through: :likes, source: :tweet
  
  def follow(other_member)
    unless self == other_member
     self.relationships.find_or_create_by(follow_id: other_member.id)
    end
  end
  
  def unfollow(other_member)
    relationship = self.relationships.find_by(follow_id: other_member.id)
    relationship.destroy if relationship
  end
  
  def following?(other_member)
    self.followings.include?(other_member)
  end
  
  def feed_tweets
    Tweet.where(member_id: self.following_ids + [self.id])
  end
  
  def good(tweet)
    likes.find_or_create_by(tweet_id: tweet.id)
  end
  
  def bad(tweet)
    like = likes.find_by(tweet_id: tweet.id)
    like.destroy if like
  end
  
  def likepost?(tweet)
    self.likeposts.include?(tweet)
  end
end
