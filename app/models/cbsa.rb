class Cbsa < ApplicationRecord
  has_many :zip_codes
  has_many :msas
end
