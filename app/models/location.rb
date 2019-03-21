class Location < ApplicationRecord
  # model association
  belongs_to :trip

  # validation
  validates_presence_of :name
end
