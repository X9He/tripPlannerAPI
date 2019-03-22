require_relative '../modules/GenerateTrip'

class GenController < ApplicationController
  # GET /trips/generate
  def generate
    puts 'in generate'
    # puts JSON.parse(request.body.string)['locations']
    GenerateTrip.generate_trip(['derp', 'derp'])
  end
end