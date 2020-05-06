class ReportMailer < ApplicationMailer
  default template_path: "mailers/#{self.name.underscore}"

  def csv_reports(email, zip_code, reports)
    reports.each do |report_name|
      report = Report.public_send(report_name, zip_code) if Report.respond_to? report_name
      attachments["#{report_name}.csv"] = CsvExporter.report_to_csv(report) if report.present?
    end

    mail(to: email, subject: "Population Analyzer Reports")
  end
end
