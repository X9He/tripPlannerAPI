require 'rubygems'
require 'http'
require_relative 'MST'

module GenerateTrip
  def self.generate_trip(locations)
    starting_address = locations['startingAddress']
    tourist_locations = locations['touristLocations']
    puts "derp saucea"
    puts tourist_locations
    tourist_locations.push(starting_address)
    # lunchLocation = locations.lunch
    # dinnerLocation = locations.dinner
    locations_hash = Hash.new()
    key = 'GFCgDDLXoK4wA1zqapmAXlVAR3MQIY6k'
    puts 'stuff'
    array_of_routes = []
    tourist_locations.each_with_index do |loc1, i|
      tourist_locations.each_with_index do |loc2, j|
        next unless j > i && j == tourist_locations.length - 1

        puts loc1, loc2
        puts i, j
        tourist_locations_i_escaped = tourist_locations[i].gsub!(/\s/, '%20')
        tourist_locations_j_escaped = tourist_locations[j].gsub!(/\s/, '%20')
        request_url = "http://www.mapquestapi.com/directions/v2/optimizedroute?key=#{key}&json={\"locations\":[\"#{tourist_locations_i_escaped}\", \"#{tourist_locations_j_escaped}\"]}"

        puts request_url
        # res = HTTP.get(request_url)
        res = HTTP.get("http://www.mapquestapi.com/directions/v2/optimizedroute",
                       :params => {:key => key,
                                   json: "{locations:[#{tourist_locations_i_escaped}, #{tourist_locations_j_escaped}]}"})
        res = JSON.parse(res.to_s)
        puts res
        # puts res['route']['realTime']
        # array_of_routes.push(res)
        # locations_hash[tourist_locations[i] + ',' + tourist_locations[j]] = res
      end
    end
      # puts locations_hash
  end
end