require 'app/modules/GenerateTrip'

class GenController < ApplicationController
  # GET /trips/generate
  def generate
    puts 'in generate'
    # puts JSON.parse(request.body.string)['locations']
    GenerateTrip.generate_trip(JSON.parse(request.body.string)['locations'])
  end
end