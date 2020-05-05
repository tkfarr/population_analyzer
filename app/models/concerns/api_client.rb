class ApiClient
  def initialize(url)
    @url = url
  end

  def get_url_to_json
    url = URI.parse(build_route)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = Rails.env.production?
    res = http.get(url.request_uri, 'Content-Type' => 'application/json')
    JSON.parse(res.body)
  end

  private

  def base_route
    if Rails.env.development?
      'http://localhost:3000/'
    elsif Rails.env.production?
      'https://population-analyzer.herokuapp.com/'
    else
      'https://population-analyzer-staging.herokuapp.com/'
    end
  end

  def build_route
    base_route + @url
  end
end
