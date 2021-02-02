class ApplicationController < ActionController::Base

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  private

  def require_login
    if current_user.nil?
      redirect_to "/sessions/new"
    end
  end
end
