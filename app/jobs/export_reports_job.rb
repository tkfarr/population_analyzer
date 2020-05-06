class ExportReportsJob < ApplicationJob
  queue_as :default

  def perform(email:, zip_code:, reports: [])
    csv_reports = reports.map do |report_name|
      report = Report.public_send(report_name, zip_code) if Report.respond_to? report_name
      CsvExporter.report_to_csv(report) if report.present?
    end

    ReportMailer.send_csv_reports(email, csv_reports).deliver
  end
end
