class Api::V1::MsasController < Api::V1::BaseApiV1Controller
  before_action :verify_zip, :set_zip_code

  def by_zip
    data = @zip_code.retrieve_matching_msa

    if data.present?
      data = data.attributes
      # Clean up json output
      data.delete('id')
      render json: { data: data, status: 200 }, status: 200
    else
      render json: { error: 'No MSA found by that Zip Code', status: 400 }, status: :bad_request
    end
  end

  private

  def msas_params
    params.permit(:zip)
  end

  def verify_zip
    ZipCodeService.new(msas_params[:zip]).verify
  rescue StandardError => e
    render json: { error: e.message, status: 400 }, status: :bad_request
  end

  def set_zip_code
    @zip_code = ZipCode.find_by_code!(msas_params[:zip])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'No Zip Code found', status: 400 }, status: :bad_request
  end
end
