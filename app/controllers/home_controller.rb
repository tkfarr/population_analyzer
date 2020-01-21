class HomeController < ApplicationController
  def index
    if home_params[:zip]
      search_url = "/api/v1/msas/by_zip?zip=#{home_params[:zip]}"
      @result = ApiClient.new(search_url).get_url
    end
  end

  private

  def home_params
    params.permit(:zip)
  end
end
