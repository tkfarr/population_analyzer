class ReportsController < ApplicationController
  before_action :set_zip_session
  before_action :verify_zip, only: :search_zip

  def index
    if @zip_code.present?
      @msa_avg_data = Report.msa_avgs_over_years(@zip_code)
      @msa_natural_increase = Report.msa_natural_increase_in_county_vs_state(@zip_code)
    end

    respond_to do |format|
      format.html
      format.json { render json: @msa_natural_increase }
    end
  end

  def search_zip
    redirect_to reports_path
  end

  def email
  end

  def export
    if reports_params[:email].present?
      ExportReportsJob.perform_now(email: reports_params[:email], zip_code: @zip_code, reports: ['msa_avgs_over_years', 'msa_natural_increase_in_county_vs_state'])
      redirect_to reports_path, notice: 'Your data is being generated and will be emailed to you.'
    else
      redirect_to email_reports_path, alert: 'Email address cannot be empty.'
    end
  rescue Net::SMTPFatalError => e
    redirect_to email_reports_path, alert: 'Please enter a valid email address.'
  end

  private

  def reports_params
    params.permit(:zip_code, :authenticity_token, :commit, :email)
  end

  def verify_zip
    ZipCodeService.new(@zip_code).verify
  rescue StandardError => e
    # remove bad zip from session
    session[:zip_code] = nil
    redirect_to reports_path, alert: e.message
  end

  def set_zip_session
    params[:zip_code] ||= session[:zip_code]
    session[:zip_code] = params[:zip_code]

    @zip_code = params[:zip_code]
  end
end
