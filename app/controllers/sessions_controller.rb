class SessionsController < ApplicationController
  before_action :presence_check, only: [:create]
  before_action :set_user, only: [:create]

  def new
  end

  def create
    if @user.authenticate(session_params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash.now[:error] = t('flash.invalid_uid_pass')
      render 'new'
    end
  end

  def destroy
  end

  private

  def presence_check
    return unless session_params[:uid].blank? ||
      session_params[:password].blank?

    msg = []
    if session_params[:uid].blank?
      msg << t('flash.invalid_uid')
    end

    if session_params[:password].blank?
      msg << t('flash.invalid_pass')
    end

    flash.now[:error] = msg.join("<br>")
    render action: 'new'
  end

  def set_user
    @user = User.find_by!(uid: session_params[:uid])
  rescue
    flash.now[:error] = t('flash.invalid_uid_pass')
    render action: 'new'
  end

  def session_params
    params.require(:user).permit(:uid, :password)
  end
end
