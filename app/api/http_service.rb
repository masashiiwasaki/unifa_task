class HttpService
  class << self
    def generate_url url:, params:
      uri = URI.parse(url)
      uri.query = URI.encode_www_form(params)

      uri.to_s
    end

    def access_token_request url:, params:
      uri = URI.parse(url)
      res = Net::HTTP.post_form(uri, params)
      results = JSON.parse(res.body.to_s)

      results["access_token"]
    end

    def post url:, params:
      uri = URI.parse(url)
      request = Net::HTTP::Post.new(uri)
      request.body = params.to_json
      request.content_type = 'application/json'
      request['Accept'] = 'application/json'
      request['Authorization'] = "Bearer #{session[:access_token]}"

      response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.request(request)
      end

      return response.code == 201
    end
  end
end
