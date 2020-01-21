class ZipCode < ApplicationRecord
  has_and_belongs_to_many :cbsas

  validates_presence_of :code
  validates_uniqueness_of :code

  def retrieve_matching_msa
    Msa.find_by_sql("
      SELECT
        #{self.code} AS zip,
        msas.name AS msa,
        cbsas.code AS cbsa,
        msas.pop_estimate_2015 AS pop2015,
        msas.pop_estimate_2014 AS pop2014
      FROM msas
      JOIN cbsas ON cbsas.id = msas.cbsa_id
      WHERE msas.lsad = 'Metropolitan Statistical Area'
      AND cbsa_id IN (
        SELECT
          cbsa_id
        FROM cbsas_zip_codes
        WHERE zip_code_id = #{self.id}
      )
    ").first
  end
end
