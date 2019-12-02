class ToppagesController < ApplicationController
  def index
    if logged_in?
      @tweet = current_member.tweets.build
      @tweets = current_member.feed_tweets.order(id: :desc).page(params[:page])
    end
  end
end
