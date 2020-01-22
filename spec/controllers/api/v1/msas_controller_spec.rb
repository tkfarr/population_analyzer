require 'rails_helper'

RSpec.describe Api::V1::MsasController do
  describe 'GET by_zip' do
    let!(:zip) { create :zip_code }
    let!(:cbsa) { create :cbsa }
    let!(:msa) { create :msa, cbsa: cbsa }
    let!(:cbsas_zip_code) { create :cbsas_zip_code, zip_code: zip, cbsa: cbsa }

    it 'returns http success' do
      get :by_zip, params: { zip: zip.code }
      expect(response).to have_http_status :success
    end

    it 'returns http bad_request for missing cbsa' do
      zip.cbsas.destroy_all
      get :by_zip, params: { zip: zip.code }
      expect(response).to have_http_status :bad_request
    end

    it 'returns http bad_request for missing msa' do
      zip.cbsas.first.msas.destroy_all
      get :by_zip, params: { zip: zip.code }
      expect(response).to have_http_status :bad_request
    end

    it 'returns http bad_request for blank zip' do
      get :by_zip, params: { zip: nil }
      expect(response).to have_http_status :bad_request
    end

    it 'returns http bad_request for non digit chars' do
      get :by_zip, params: { zip: 'asdfasd' }
      expect(response).to have_http_status :bad_request
    end

    it 'returns http bad_request for wrong char count' do
      get :by_zip, params: { zip: '123123123' }
      expect(response).to have_http_status :bad_request
      get :by_zip, params: { zip: '12' }
      expect(response).to have_http_status :bad_request
    end

    it 'returns http bad_request for missing zip code' do
      get :by_zip, params: { zip: '92302' }
      expect(response).to have_http_status :bad_request
    end
  end
end
