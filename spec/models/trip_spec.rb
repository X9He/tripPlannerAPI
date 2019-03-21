require 'rails_helper'

RSpec.describe Trip, type: :model do
  # Association test
  # ensure Trip model has a 1:m relationship with the Location model
  it { should have_many(:locations).dependent(:destroy) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
end
