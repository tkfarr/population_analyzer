class Msa < ApplicationRecord
  belongs_to :cbsa

  validates_presence_of :cbsa_id, :name, :lsad
  validates_uniqueness_of :name, scope: :cbsa_id
end
