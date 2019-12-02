class TweetsController < ApplicationController
  before_action :require_member_logged_in
  before_action :correct_member, only: [:destroy]
  
  def create
    @tweet = current_member.tweets.build(tweet_params)
    if @tweet.save
      flash[:success] = 'Tweetしました！'
      redirect_to root_url
    else
      @tweets = current_member.feed_tweets.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'Tweet出来ません><'
      render 'toppages/index'
    end
  end

  def destroy
    @tweet.destroy
    flash[:success] = 'Tweetを削除しました'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def tweet_params
   params.require(:tweet).permit(:content)
  end
  
  def correct_member
    @tweet = current_member.tweets.find_by(id: params[:id])
    unless @tweet
     redirect_to root_url
    end
  end
end
