class HomeController < ApplicationController
  before_action :set_zip_session

  def index
    if home_params[:zip]
      search_url = "/api/v1/msas/by_zip?zip=#{home_params[:zip]}"
      response = ApiClient.new(search_url).get_url_to_json
      @error = response['error'] if response['error'].present?
      @result = response['data'] if @error.blank?
      @chart_data = @result.reject{ |key, value| key.exclude?('pop')} if @result.present?
    end
  rescue StandardError => e
    render json: { error: "API error occured: #{e}", status: 500 }, status: :internal_server_error
  end

  private

  def home_params
    params.permit(:zip)
  end

  def set_zip_session
    params[:zip] ||= session[:zip_code]
    session[:zip_code] = params[:zip]

    @zip_code = params[:zip]
  end
end
