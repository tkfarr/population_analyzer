class RemoveCbsaIdFromZipCodes < ActiveRecord::Migration[6.0]
  def change
    remove_column :zip_codes, :cbsa_id
  end
end
