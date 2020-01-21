class Api::V1::MsasController < Api::V1::BaseApiV1Controller
  before_action :verify_zip, :set_zip_code

  def by_zip
    result = @zip_code.retrieve_matching_msa

    if result.present?
      result = result.attributes
      # Clean up json output
      result.delete('id')
    else
      result = { error: 'No MSA found by that Zip Code' }
    end

    render json: result
  end

  private

  def msas_params
    params.permit(:zip)
  end

  def verify_zip
    ZipCodeService.new(msas_params[:zip]).verify
  rescue StandardError => e
    render json: { error: e.message }
  end

  def set_zip_code
    @zip_code = ZipCode.find_by_code!(msas_params[:zip])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'No Zip Code found' }
  end
end
