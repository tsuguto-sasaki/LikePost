class Tweet < ApplicationRecord
  belongs_to :member
  
  validates :content, presence: true, length: { maximum: 200}
end
