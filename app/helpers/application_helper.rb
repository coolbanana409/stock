module ApplicationHelper
  def logged_in?
    !!current_user
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        session[:user_id] = user.id
        remember(user)
        @current_user = user
      end
    end
  end
end
