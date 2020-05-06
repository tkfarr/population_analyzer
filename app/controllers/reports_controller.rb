class ReportsController < ApplicationController
  before_action :verify_zip, only: :search_zip
  before_action :set_zip_session

  def index
    @msa_avg_data = Report.msa_avgs_over_years(@zip_code) if @zip_code.present?
    @msa_natural_increase = Report.msa_natural_increase_in_county_vs_state(@zip_code) if @zip_code.present?

    respond_to do |format|
      format.html
      format.json { render json: @msa_natural_increase }
    end
  end

  def search_zip
    redirect_to reports_path
  end

  def export
    ExportReportsJob.perform_now(email: 'kekoa428@gmail.com', zip_code: @zip_code, reports: ['msa_avgs_over_years', 'msa_natural_increase_in_county_vs_state'])
    redirect_to reports_path, notice: 'Your data is being generated and will be emailed to you.'
  end

  private

  def reports_params
    params.permit(:zip_code, :authenticity_token, :commit)
  end

  def verify_zip
    ZipCodeService.new(reports_params[:zip_code]).verify
  rescue StandardError => e
    redirect_to reports_path, alert: e.message
  end

  def set_zip_session
    params[:zip_code] ||= session[:zip_code]
    session[:zip_code] = params[:zip_code]

    @zip_code = params[:zip_code]
  end
end
