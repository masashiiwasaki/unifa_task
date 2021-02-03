class OauthController < ApplicationController
  AUTHORIZE_URL = "https://arcane-ravine-29792.herokuapp.com/oauth/authorize"

  before_action :require_login

  def new
    redirect_to generate_url
  end

  def callback
  end

  private

  def url_param
    {
      client_id: ENV["CLIENT_ID"],
      response_type: "code",
      redirect_uri: "http://localhost:3000/oauth/callback"
    }
  end

  def generate_url
    uri = URI.parse(AUTHORIZE_URL)
    uri.query = URI.encode_www_form(url_param)

    uri.to_s
  end
end
