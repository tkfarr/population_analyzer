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
      msa = Msa.find_or_create_by(cbsa_id: cbsa.id, mdiv: mdiv, stcou: row[2], name: row[3].encode('UTF-8', invalid: :replace, undef: :replace), lsad: row[4])
      msa.pop_estimate_2010 = row[7] if msa.pop_estimate_2010 != row[7]
      msa.pop_estimate_2011 = row[8] if msa.pop_estimate_2011 != row[8]
      msa.pop_estimate_2012 = row[9] if msa.pop_estimate_2012 != row[9]
      msa.pop_estimate_2013 = row[10] if msa.pop_estimate_2013 != row[10]
      msa.pop_estimate_2014 = row[11] if msa.pop_estimate_2014 != row[11]
      msa.pop_estimate_2015 = row[12] if msa.pop_estimate_2015 != row[12]
      msa.pop_change_2010 = row[13] if msa.pop_change_2010 != row[13]
      msa.pop_change_2011 = row[14] if msa.pop_change_2011 != row[14]
      msa.pop_change_2012 = row[15] if msa.pop_change_2012 != row[15]
      msa.pop_change_2013 = row[16] if msa.pop_change_2013 != row[16]
      msa.pop_change_2014 = row[17] if msa.pop_change_2014 != row[17]
      msa.pop_change_2015 = row[18] if msa.pop_change_2015 != row[18]
      msa.births_2010 = row[19] if msa.births_2010 != row[19]
      msa.births_2011 = row[20] if msa.births_2011 != row[20]
      msa.births_2012 = row[21] if msa.births_2012 != row[21]
      msa.births_2013 = row[22] if msa.births_2013 != row[22]
      msa.births_2014 = row[23] if msa.births_2014 != row[23]
      msa.births_2015 = row[24] if msa.births_2015 != row[24]
      msa.deaths_2010 = row[25] if msa.deaths_2010 != row[25]
      msa.deaths_2011 = row[26] if msa.deaths_2011 != row[26]
      msa.deaths_2012 = row[27] if msa.deaths_2012 != row[27]
      msa.deaths_2013 = row[28] if msa.deaths_2013 != row[28]
      msa.deaths_2014 = row[29] if msa.deaths_2014 != row[29]
      msa.deaths_2015 = row[30] if msa.deaths_2015 != row[30]
      msa.natural_inc_2010 = row[31] if msa.natural_inc_2010 != row[31]
      msa.natural_inc_2011 = row[32] if msa.natural_inc_2011 != row[32]
      msa.natural_inc_2012 = row[33] if msa.natural_inc_2012 != row[33]
      msa.natural_inc_2013 = row[34] if msa.natural_inc_2013 != row[34]
      msa.natural_inc_2014 = row[35] if msa.natural_inc_2014 != row[35]
      msa.natural_inc_2015 = row[36] if msa.natural_inc_2015 != row[36]
      msa.save
    end
  end
end
