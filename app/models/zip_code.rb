class ZipCode < ApplicationRecord
  belongs_to :cbsa

  validates_presence_of :code
  validates_uniqueness_of :code
end
