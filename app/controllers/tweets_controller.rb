class TweetsController < ApplicationController
  TWEET_URL = "https://arcane-ravine-29792.herokuapp.com/api/tweets"

  before_action :require_login

  def create
    picture = Picture.find_by(id: params[:picture_id])
    access_token = session[:access_token]

    uri = URI.parse(TWEET_URL)
    request = Net::HTTP::Post.new(uri)
    request.body = {text: picture.title, url: url_for(picture.image)}.to_json
    request.content_type = 'application/json'
    request['Accept'] = 'application/json'
    request['Authorization'] = "Bearer #{session[:access_token]}"

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end

    if response == 201
      flash.now[:success] = t('flash.upload_tweet')
    else
      flash.now[:error] = t('flash.error_tweet')
    end

    redirect_to "/"
  end
end
