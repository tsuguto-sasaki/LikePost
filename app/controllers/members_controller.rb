class MembersController < ApplicationController
  before_action :require_member_logged_in, only: [:index, :show]
  
  def index
    @members = Member.order(id: :desc).page(params[:page]).per(10)
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
end

private

def member_params
  params.require(:member).permit(:name,:email,:password,:password_confirmation)
end