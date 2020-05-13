class Msa < ApplicationRecord
  belongs_to :cbsa

  validates_presence_of :cbsa_id, :name, :lsad
  validates_uniqueness_of :name, scope: :cbsa_id

  def update_msa_changes_from_csv(csv_data)
    self.pop_estimate_2010 = csv_data[7] if self.pop_estimate_2010 != csv_data[7]
    self.pop_estimate_2011 = csv_data[8] if self.pop_estimate_2011 != csv_data[8]
    self.pop_estimate_2012 = csv_data[9] if self.pop_estimate_2012 != csv_data[9]
    self.pop_estimate_2013 = csv_data[10] if self.pop_estimate_2013 != csv_data[10]
    self.pop_estimate_2014 = csv_data[11] if self.pop_estimate_2014 != csv_data[11]
    self.pop_estimate_2015 = csv_data[12] if self.pop_estimate_2015 != csv_data[12]
    self.pop_change_2010 = csv_data[13] if self.pop_change_2010 != csv_data[13]
    self.pop_change_2011 = csv_data[14] if self.pop_change_2011 != csv_data[14]
    self.pop_change_2012 = csv_data[15] if self.pop_change_2012 != csv_data[15]
    self.pop_change_2013 = csv_data[16] if self.pop_change_2013 != csv_data[16]
    self.pop_change_2014 = csv_data[17] if self.pop_change_2014 != csv_data[17]
    self.pop_change_2015 = csv_data[18] if self.pop_change_2015 != csv_data[18]
    self.births_2010 = csv_data[19] if self.births_2010 != csv_data[19]
    self.births_2011 = csv_data[20] if self.births_2011 != csv_data[20]
    self.births_2012 = csv_data[21] if self.births_2012 != csv_data[21]
    self.births_2013 = csv_data[22] if self.births_2013 != csv_data[22]
    self.births_2014 = csv_data[23] if self.births_2014 != csv_data[23]
    self.births_2015 = csv_data[24] if self.births_2015 != csv_data[24]
    self.deaths_2010 = csv_data[25] if self.deaths_2010 != csv_data[25]
    self.deaths_2011 = csv_data[26] if self.deaths_2011 != csv_data[26]
    self.deaths_2012 = csv_data[27] if self.deaths_2012 != csv_data[27]
    self.deaths_2013 = csv_data[28] if self.deaths_2013 != csv_data[28]
    self.deaths_2014 = csv_data[29] if self.deaths_2014 != csv_data[29]
    self.deaths_2015 = csv_data[30] if self.deaths_2015 != csv_data[30]
    self.natural_inc_2010 = csv_data[31] if self.natural_inc_2010 != csv_data[31]
    self.natural_inc_2011 = csv_data[32] if self.natural_inc_2011 != csv_data[32]
    self.natural_inc_2012 = csv_data[33] if self.natural_inc_2012 != csv_data[33]
    self.natural_inc_2013 = csv_data[34] if self.natural_inc_2013 != csv_data[34]
    self.natural_inc_2014 = csv_data[35] if self.natural_inc_2014 != csv_data[35]
    self.natural_inc_2015 = csv_data[36] if self.natural_inc_2015 != csv_data[36]

    self.save
  end
end
