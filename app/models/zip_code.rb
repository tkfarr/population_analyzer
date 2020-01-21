class ZipCode < ApplicationRecord
  has_and_belongs_to_many :cbsas

  validates_presence_of :code
  validates_uniqueness_of :code
end
