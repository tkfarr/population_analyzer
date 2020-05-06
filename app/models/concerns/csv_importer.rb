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
      # Avoid duplicates
      zip_code.cbsas << cbsa unless zip_code.cbsas.include?(cbsa)
    end
  end

  def self.import_cbsa_to_msa_csv(csv)
    csv.each do |row|
      next if row[0].blank?

      # Set values
      cbsa_code = row[0]
      mdiv = row[1]

      #  Look up the CBSA provided by MDIV first. Update to use CBSA id in Col for future lookups.
      if mdiv.present?
        original_cbsa = Cbsa.find_or_create_by(code: mdiv)
        new_cbsa = Cbsa.find_or_create_by(code: cbsa_code)
        # Update zip code to refer to new cbsa and msa
        if original_cbsa.present?
          original_cbsa.zip_codes.each do |zip_code|
            zip_code.cbsas.delete(original_cbsa)
            # Avoid duplicates
            zip_code.cbsas << new_cbsa unless zip_code.cbsas.include?(new_cbsa)
          end
        end
        cbsa = new_cbsa
      else
        cbsa = Cbsa.find_or_create_by(code: cbsa_code)
      end

      # if msa is present see if the population has been updated
      msa = Msa.find_or_create_by(
        cbsa_id: cbsa.id,
        mdiv: mdiv,
        stcou: row[2],
        name: row[3].encode('UTF-8', invalid: :replace, undef: :replace),
        lsad: row[4]
      )
      msa.update_msa_changes_from_csv(row)
      msa.save
    end
  end
end
