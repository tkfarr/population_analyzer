class ApiClient
  def initialize(url)
    @url = url
  end

  def get_url
    url = URI.parse(build_route)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    res = http.get(url.request_uri, { 'Content-Type' => 'application/json' })
    JSON.parse(res.body)
  end

  private

  def base_route
    Rails.env.production? ? 'https://population-analyzer.herokuapp.com/' : 'https://population-analyzer-staging.herokuapp.com/'
  end

  def build_route
    base_route + @url
  end
end
