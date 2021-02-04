class TweetsController < ApplicationController
  TWEET_URL = "https://arcane-ravine-29792.herokuapp.com/api/tweets"

  before_action :require_login

  def create
    picture = Picture.find_by(id: params[:picture_id])
    access_token = session[:access_token]
    params = tweet_params picture

    response = HttpService.access_token_request url: TWEET_URL,
      params: params

    if response
      flash.now[:success] = t('flash.upload_tweet')
    else
      flash.now[:error] = t('flash.error_tweet')
    end

    redirect_to "/"
  end

  private

  def tweet_params picture
    {
      text: picture.title,
      url: url_for(picture.image)
    }
  end
end
