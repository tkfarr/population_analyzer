class MsasController < ApplicationController
  before_action :verify_zip, :set_zip_code

  def by_zip
    result = @zip_code.retrieve_matching_msa

    if result.present?
      result = result.attributes
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
    begin
      ZipCodeService.new(msas_params[:zip]).verify
    rescue StandardError => error
      render json: { error: error.message }
    end
  end

  def set_zip_code
    begin
      @zip_code = ZipCode.find_by_code!(msas_params[:zip])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'No Zip Code found' }
    end
  end
end
