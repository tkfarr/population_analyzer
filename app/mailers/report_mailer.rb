class ReportMailer < ApplicationMailer
  default template_path: "mailers/#{self.name.underscore}"

  def send_csv_reports(email, reports)
    attachments[reports.join(', ')] = {mime_type: 'text/csv', content: 'csv'}
    mail(to: email, subject: "Population Analyzer Reports")
  end
end
