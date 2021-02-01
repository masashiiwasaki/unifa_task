class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def require_login
    if current_user.nil?
      redirect_to "/sessions/new"
    end
  end
end
