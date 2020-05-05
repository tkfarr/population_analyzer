module Report
  def self.data_by_zip(zip)
    zip_code = ZipCode.find_by_code(zip)
    zip_code.retrieve_matching_msa if zip_code
  end
end
