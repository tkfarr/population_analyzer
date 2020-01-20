class Cbsa < ApplicationRecord
  has_many :zip_codes
  has_many :msas

  validates_presence_of :code
  validates_uniqueness_of :code
end
