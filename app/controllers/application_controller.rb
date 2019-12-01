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
  end
end
