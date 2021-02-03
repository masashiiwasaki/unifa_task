class OauthController < ApplicationController
  AUTHORIZE_URL = "https://arcane-ravine-29792.herokuapp.com/oauth/authorize"
  TOKEN_URL = "https://arcane-ravine-29792.herokuapp.com/oauth/token"

  before_action :require_login

  def new
    redirect_to generate_url
  end

  def callback
    session[:access_token] = access_token_request

    redirect_to "/"
  end

  private

  def authorise_url_param
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

  def generate_url
    uri = URI.parse(AUTHORIZE_URL)
    uri.query = URI.encode_www_form(authorise_url_param)

    uri.to_s
  end

  def access_token_request
    uri = URI.parse(TOKEN_URL)
    res = Net::HTTP.post_form(uri, access_token_params)
    results = JSON.parse(res.body.to_s)

    results["access_token"]
  end
end
