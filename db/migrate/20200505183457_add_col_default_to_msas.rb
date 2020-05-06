class AddColDefaultToMsas < ActiveRecord::Migration[6.0]
  def change
    change_column :msas, :pop_estimate_2010, :integer, default: 0
    change_column :msas, :pop_estimate_2011, :integer, default: 0
    change_column :msas, :pop_estimate_2012, :integer, default: 0
    change_column :msas, :pop_estimate_2013, :integer, default: 0
    change_column :msas, :pop_estimate_2014, :integer, default: 0
    change_column :msas, :pop_estimate_2015, :integer, default: 0
  end
end
