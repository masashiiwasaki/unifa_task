class SessionsController < ApplicationController
  def new
  end

  def create
    @login_user = LoginUser.new(uid: session_params[:uid],
      password: session_params[:password])

    if @login_user.save
      @user = User.find_by(uid: session_params[:uid])
      session[:user_id] = @user.id
      redirect_to '/pictures/new'
    else
      @errors = @login_user.errors.full_messages
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    session[:access_token] = nil

    redirect_to "/sessions/new"
  end

  private

  def session_params
    params.require(:user).permit(:uid, :password)
  end
end
