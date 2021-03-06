class Trip < ApplicationRecord
  # model association
  has_many :locations, dependent: :destroy

  # validations
  validates_presence_of :title, :created_by
end
