class MembersController < ApplicationController
  before_action :require_member_logged_in, only: [:index, :show, :followings, :followers, :likes]
  
  def index
    @members = Member.order(id: :desc).page(params[:page]).per(5)
  end

  def show
    @member = Member.find(params[:id])
    @tweets = @member.tweets.order(id: :desc).page(params[:page])
    counts(@member)
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)
    
    if @member.save
      flash[:success] = 'メンバー登録完了です^^'
      redirect_to @member
    else
      flash[:danger] = 'メンバー登録、失敗です><'
      render :new
    end
  end
  
  def followings
    @member = Member.find(params[:id])
    @followings = @member.followings.page(params[:page])
    counts(@member)
  end
  
  def followers
    @member = Member.find(params[:id])
    @followers = @member.followers.page(params[:page])
    counts(@member)
  end
  
  def goods
    @member = Member.find(params[:id])
    @likeposts = @member.likeposts.page(params[:page])
    counts(@member)
  end
  
  def search
    if params[:member][:search] == nil || params[:member][:search] == ""
        flash[:danger] = "フォローメンバーを入力して下さい！"
        redirect_back(fallback_location: root_path)
      else
        @members = current_member.followings.where('name LIKE ?', "%#{params[:member][:search]}%")
      end
      @tweet = Tweet.where(member_id:  @members)
  end
  
  private

  def member_params
    params.require(:member).permit(:name,:email,:password,:password_confirmation,:search)
  end
end