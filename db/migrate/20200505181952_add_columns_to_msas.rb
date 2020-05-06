class AddColumnsToMsas < ActiveRecord::Migration[6.0]
  def change
    add_column :msas, :pop_change_2010, :integer, default: 0
    add_column :msas, :pop_change_2011, :integer, default: 0
    add_column :msas, :pop_change_2012, :integer, default: 0
    add_column :msas, :pop_change_2013, :integer, default: 0
    add_column :msas, :pop_change_2014, :integer, default: 0
    add_column :msas, :pop_change_2015, :integer, default: 0
    add_column :msas, :births_2010, :integer, default: 0
    add_column :msas, :births_2011, :integer, default: 0
    add_column :msas, :births_2012, :integer, default: 0
    add_column :msas, :births_2013, :integer, default: 0
    add_column :msas, :births_2014, :integer, default: 0
    add_column :msas, :births_2015, :integer, default: 0
    add_column :msas, :deaths_2010, :integer, default: 0
    add_column :msas, :deaths_2011, :integer, default: 0
    add_column :msas, :deaths_2012, :integer, default: 0
    add_column :msas, :deaths_2013, :integer, default: 0
    add_column :msas, :deaths_2014, :integer, default: 0
    add_column :msas, :deaths_2015, :integer, default: 0
    add_column :msas, :natural_inc_2010, :integer, default: 0
    add_column :msas, :natural_inc_2011, :integer, default: 0
    add_column :msas, :natural_inc_2012, :integer, default: 0
    add_column :msas, :natural_inc_2013, :integer, default: 0
    add_column :msas, :natural_inc_2014, :integer, default: 0
    add_column :msas, :natural_inc_2015, :integer, default: 0
  end
end
