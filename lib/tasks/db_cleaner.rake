namespace :db_cleaner do
  desc "Drop MSAs"
  task drop_data: [ :environment ] do
    ZipCode.delete_all
    Cbsa.delete_all
    Msa.delete_all
    CbsasZipCode.delete_all
  end

  desc "Import MSAs"
  task import_data: [ :environment ] do
    ZipCode.delete_all
    Cbsa.delete_all
    Msa.delete_all
    CbsasZipCode.delete_all

    zip_csv = CsvImporter.parse_csv_from_public_files('zip_to_cbsa.csv')
    CsvImporter.import_zip_to_cbsa_csv(zip_csv)

    msa_csv = CsvImporter.parse_csv_from_public_files('cbsa_to_msa.csv')
    CsvImporter.import_cbsa_to_msa_csv(msa_csv)
  end
end
