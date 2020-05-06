class ExportReportsJob < ApplicationJob
  queue_as :default

  def perform(email:, zip_code:, reports: [])
    ReportMailer.csv_reports(email, zip_code, reports).deliver
  end
end
