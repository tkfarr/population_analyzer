class ReportsController < ApplicationController
  before_action :set_results, only: :index

  def index
  end

  def search_zip
    verify_zip
    set_zip
    set_results(Report.data_by_zip(@zip_code))
    redirect_to reports_path
  end

  private

  def reports_params
    params.permit(:zip)
  end

  def verify_zip
    begin
      ZipCodeService.new(reports_params[:zip]).verify
    rescue StandardError => error
      redirect_to reports_path, alert: error.message
    end
  end

  def set_zip
    begin
      @zip_code = ZipCode.find_by_code!(reports_params[:zip])
    rescue ActiveRecord::RecordNotFound => error
      redirect_to reports_path, alert: error.message
    end
  end

  def set_results(results=nil)
    unless results.blank?
      results ||= session[:results]
      session[:results] = results
    end

    @results = session[:results]
  end
end
