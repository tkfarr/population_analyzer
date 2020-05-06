class Msa < ApplicationRecord
  belongs_to :cbsa

  validates_presence_of :cbsa_id, :name, :lsad
  validates_uniqueness_of :name, scope: :cbsa_id

  def update_msa_changes_from_csv(csv_data)
    pop_estimate_2010 = csv_data[7] if pop_estimate_2010 != csv_data[7]
    pop_estimate_2011 = csv_data[8] if pop_estimate_2011 != csv_data[8]
    pop_estimate_2012 = csv_data[9] if pop_estimate_2012 != csv_data[9]
    pop_estimate_2013 = csv_data[10] if pop_estimate_2013 != csv_data[10]
    pop_estimate_2014 = csv_data[11] if pop_estimate_2014 != csv_data[11]
    pop_estimate_2015 = csv_data[12] if pop_estimate_2015 != csv_data[12]
    pop_change_2010 = csv_data[13] if pop_change_2010 != csv_data[13]
    pop_change_2011 = csv_data[14] if pop_change_2011 != csv_data[14]
    pop_change_2012 = csv_data[15] if pop_change_2012 != csv_data[15]
    pop_change_2013 = csv_data[16] if pop_change_2013 != csv_data[16]
    pop_change_2014 = csv_data[17] if pop_change_2014 != csv_data[17]
    pop_change_2015 = csv_data[18] if pop_change_2015 != csv_data[18]
    births_2010 = csv_data[19] if births_2010 != csv_data[19]
    births_2011 = csv_data[20] if births_2011 != csv_data[20]
    births_2012 = csv_data[21] if births_2012 != csv_data[21]
    births_2013 = csv_data[22] if births_2013 != csv_data[22]
    births_2014 = csv_data[23] if births_2014 != csv_data[23]
    births_2015 = csv_data[24] if births_2015 != csv_data[24]
    deaths_2010 = csv_data[25] if deaths_2010 != csv_data[25]
    deaths_2011 = csv_data[26] if deaths_2011 != csv_data[26]
    deaths_2012 = csv_data[27] if deaths_2012 != csv_data[27]
    deaths_2013 = csv_data[28] if deaths_2013 != csv_data[28]
    deaths_2014 = csv_data[29] if deaths_2014 != csv_data[29]
    deaths_2015 = csv_data[30] if deaths_2015 != csv_data[30]
    natural_inc_2010 = csv_data[31] if natural_inc_2010 != csv_data[31]
    natural_inc_2011 = csv_data[32] if natural_inc_2011 != csv_data[32]
    natural_inc_2012 = csv_data[33] if natural_inc_2012 != csv_data[33]
    natural_inc_2013 = csv_data[34] if natural_inc_2013 != csv_data[34]
    natural_inc_2014 = csv_data[35] if natural_inc_2014 != csv_data[35]
    natural_inc_2015 = csv_data[36] if natural_inc_2015 != csv_data[36]

    save
  end
end
