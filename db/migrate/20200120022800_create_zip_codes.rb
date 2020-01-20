class CreateZipCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :zip_codes do |t|
      t.integer :code
      t.integer :cbsa_id

      t.timestamps null: false

      t.index :code
      t.index :cbsa_id
    end
  end
end
