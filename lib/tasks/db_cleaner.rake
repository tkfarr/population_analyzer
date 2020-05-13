namespace :db_cleaner do
  desc "Drop MSAs"
  task drop_data: [ :environment ] do
    ZipCode.destroy_all
    Cbsa.destroy_all
    Msa.destroy_all
  end

  desc "Import MSAs"
  task import_data: [ :environment ] do
    zip_csv = CsvImporter.parse_csv_from_public_files('zip_to_cbsa.csv')
    CsvImporter.import_zip_to_cbsa_csv(zip_csv)

    msa_csv = CsvImporter.parse_csv_from_public_files('cbsa_to_msa.csv')
    CsvImporter.import_cbsa_to_msa_csv(msa_csv)
  end
end
