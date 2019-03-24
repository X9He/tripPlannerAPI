require_relative '../modules/GenerateTrip'

class GenController < ApplicationController
  # GET /trips/generate
  def generate
    puts 'in generate'
    locations = JSON.parse(request.body.string)['locations']
    GenerateTrip.generate_trip(locations)
  end
end