class CreateCbsas < ActiveRecord::Migration[6.0]
  def change
    create_table :cbsas do |t|
      t.integer :code

      t.timestamps null: false

      t.index :code
    end
  end
end
