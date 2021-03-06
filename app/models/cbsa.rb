class Cbsa < ApplicationRecord
  has_and_belongs_to_many :zip_codes
  has_many :msas

  validates_presence_of :code
  validates_uniqueness_of :code
end
