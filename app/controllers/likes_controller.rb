class LikesController < ApplicationController
  before_action :require_member_logged_in
  def create
    tweet = Tweet.find(params[:tweet_id])
    current_member.good(tweet)
    flash[:success] = 'お気に入り登録しました^^'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    tweet = Tweet.find(params[:tweet_id])
    current_member.bad(tweet)
    flash[:success] = 'お気に入り解除しました><'
    redirect_back(fallback_location: root_path)
  end
end
