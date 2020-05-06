require 'csv'

module CsvExporter
  def self.report_to_csv(report)
    CSV.generate(headers: true) do |csv|
      report_data = report.attributes
      report_data.delete('id')
      csv << report_data.keys
      csv << report_data.values
    end
  end
end
