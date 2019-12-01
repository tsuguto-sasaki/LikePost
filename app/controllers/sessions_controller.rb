class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'ログイン成功です^^'
      redirect_to @member
    else
      flash.now[:danger] = 'ログイン失敗です><'
      render :new
    end
  end

  def destroy
    session[:member_id] = nil
    flash[:success] = 'ログアウトしました〜〜〜'
    redirect_to root_url
  end
  
  private
  
  def login(email, password)
    @member = Member.find_by(email: email)
    if @member && @member.authenticate(password)
      session[:member_id] =@member.id
      return true
    else
      return false
    end
  end
end
