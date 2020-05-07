require 'rails_helper'

RSpec.describe ExportReportsJob, type: :job do
  xit 'raises an error with bad email' do
    ActiveJob::Base.queue_adapter = :test
      expect {
        ExportReportsJob.perform_now(zip_code: '92804', email: 'asdfasd', reports: ['msa_avgs_over_years'])
      }.to raise_error(Net::SMTPFatalError)
    end
end
