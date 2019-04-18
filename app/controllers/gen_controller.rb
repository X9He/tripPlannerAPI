# frozen_string_literal: true

require_relative '../modules/GenerateTrip'

class GenController < ApplicationController
  # GET /trips/generate
  def generate
    puts 'in generate'
    locations = JSON.parse(request.body.string)['locations']
    optimal_locations = GenerateTrip.generate_trip(locations)
    render :json => optimal_locations
  end
end