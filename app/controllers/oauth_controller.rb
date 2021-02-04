class OauthController < ApplicationController
  AUTHORIZE_URL = "https://arcane-ravine-29792.herokuapp.com/oauth/authorize"
  TOKEN_URL = "https://arcane-ravine-29792.herokuapp.com/oauth/token"

  before_action :require_login

  def new
    url = HttpService.generate_url url: AUTHORIZE_URL,
      params: authorise_url_params
    redirect_to url
  end

  def callback
    access_token = HttpService.access_token_request url: TOKEN_URL,
      params: access_token_params
    session[:access_token] = access_token

    redirect_to "/"
  end

  private

  def authorise_url_params
    {
      client_id: ENV["CLIENT_ID"],
      response_type: "code",
      redirect_uri: "http://localhost:3000/oauth/callback"
    }
  end

  def access_token_params
    {
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV['CLIENT_SECRET'],
      redirect_uri: 'http://localhost:3000/oauth/callback',
      grant_type: 'authorization_code',
      code: params['code']
    }
  end
end
