class RelationshipsController < ApplicationController
  def create
    member = Member.find(params[:follow_id])
    current_member.follow(member)
    flash[:success] = 'メンバーをフォローしました^^'
    redirect_to member
  end

  def destroy
    member = Member.find(params[:follow_id])
    current_member.unfollow(member)
    flash[:success] = 'メンバーのフォローを解除しました><'
    redirect_to member
  end
end
