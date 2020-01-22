class CbsasZipCode < ApplicationRecord
  belongs_to :cbsa
  belongs_to :zip_code

  validates_presence_of :cbsa, :zip_code
  validates_uniquness_of :cbsa, :zip_code
end
