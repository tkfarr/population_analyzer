require 'csv'
require 'open-uri'

module CsvImporter
  def self.import_zip_to_cbsa
    csv = download_and_parse_csv('https://s3.amazonaws.com/peerstreet-static/engineering/zip_to_msa/zip_to_cbsa.csv')
    import_zip_to_cbsa_csv(csv)
  end

  def self.import_cbsa_to_msa
    csv = download_and_parse_csv('https://s3.amazonaws.com/peerstreet-static/engineering/zip_to_msa/cbsa_to_msa.csv')
    import_cbsa_to_msa_csv(csv)
  end

  def self.download_and_parse_csv(url)
    CSV.parse(open(url))
  end

  def self.import_zip_to_cbsa_csv(csv)
    csv.each do |row|
      zip_code = row[0]
      cbsa_code = row[1]
      cbsa = Cbsa.find_or_create_by(code: cbsa_code)
      zip_code = ZipCode.find_or_create_by(code: zip_code)
      zip_code.cbsas << cbsa if cbsa.present? && zip_code.present?
    end
  end

  def self.import_cbsa_to_msa_csv(csv)
    csv.each do |row|
      next if row[0].blank?

      # Set values
      cbsa_code = row[0]
      mdiv = row[1]

      #  Look up the CBSA provided by the Step 1 in Column 2 (MDIV). If present, then use the corresponding CBSA in Column 1 going forward. If not found, then continue to use that of Step 1.
      if mdiv.present?
        original_cbsa = Cbsa.find_or_create_by(code: mdiv)
        new_cbsa = Cbsa.find_or_create_by(code: cbsa_code)
        # Update zip code to refer to new cbsa and msa
        if original_cbsa.present?
          original_cbsa.zip_codes.each do |zip_code|
            zip_code.cbsas.delete(original_cbsa)
            zip_code.cbsas << new_cbsa
          end
        end

        cbsa = new_cbsa
      else
        cbsa = Cbsa.find_or_create_by(code: cbsa_code)
      end

      # if msa is present see if the population has been updated
      msa = Msa.find_or_create_by(cbsa_id: cbsa.id, mdiv: mdiv, stcou: row[2], name: row[3].encode('UTF-8', invalid: :replace, undef: :replace), lsad: row[4])
      msa.pop_estimate_2010 = row[7] if msa.pop_estimate_2010 != row[7]
      msa.pop_estimate_2011 = row[8] if msa.pop_estimate_2011 != row[8]
      msa.pop_estimate_2012 = row[9] if msa.pop_estimate_2012 != row[9]
      msa.pop_estimate_2013 = row[10] if msa.pop_estimate_2013 != row[10]
      msa.pop_estimate_2014 = row[11] if msa.pop_estimate_2014 != row[11]
      msa.pop_estimate_2015 = row[12] if msa.pop_estimate_2015 != row[12]
      msa.save
    end
  end
end
