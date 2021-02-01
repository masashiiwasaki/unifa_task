class ApplicationController < ActionController::Base
  before_action :check_current_user
  before_action :require_login

  private

  def check_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def require_login
    if @current_user.nil?
      redirect_to "/sessions/new"
    end
  end
end
