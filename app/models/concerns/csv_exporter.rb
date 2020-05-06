require 'csv'

module CsvExporter
  def self.report_to_csv(report)
    csv_string = CSV.generate do |csv|
      csv << ['this_is_report']
      csv << ["another"]
    end
  end
end
