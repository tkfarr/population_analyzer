class CreateCbsasZipCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :cbsas_zip_codes do |t|
      t.integer :cbsa_id
      t.integer :zip_code_id

      t.timestamps null: false

      t.index :cbsa_id
      t.index :zip_code_id
    end
  end
end
