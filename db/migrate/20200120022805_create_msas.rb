class CreateMsas < ActiveRecord::Migration[6.0]
  def change
    create_table :msas do |t|
      t.integer :cbsa_id
      t.integer :mdiv
      t.integer :stcou
      t.string :name
      t.string :lsad
      t.integer :pop_estimate_2010
      t.integer :pop_estimate_2011
      t.integer :pop_estimate_2012
      t.integer :pop_estimate_2013
      t.integer :pop_estimate_2014
      t.integer :pop_estimate_2015

      t.timestamps null: false

      t.index :cbsa_id
      t.index :mdiv
    end
  end
end
