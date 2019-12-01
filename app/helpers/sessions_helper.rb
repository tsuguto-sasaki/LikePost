module SessionsHelper
  def current_member
    @current_member ||= Member.find_by(id: session[:member_id])
  end
  
  def logged_in?
    !!current_member
  end
end
