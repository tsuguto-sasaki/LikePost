class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  private
  
  def require_member_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(member)
    @count_tweets = member.tweets.count
    @count_followings = member.followings.count
    @count_followers = member.followers.count
    @count_likes = member.likes.count
  end
end
