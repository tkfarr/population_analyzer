require 'rails_helper'

RSpec.describe ReportsController do
  describe 'POST export' do
    it 'redirects to reports_path' do
      post :export, params: { zip_code: '92804', email: 'kekoa428@gmail.com' }
      expect(response).to redirect_to(reports_path)
    end

    it 'raises an error with bad email' do
      expect {
        post :export, params: { zip_code: '92804', email: 'asdfasdf' }
      }.to raise_error(Net::SMTPFatalError)
      # post :export, params: { zip_code: '92804', email: 'asdfasdf' }
      # expect(response).to raise_error()
    end
  end
end
