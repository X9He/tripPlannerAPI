require 'rubygems'
require 'http'
require_relative 'TSP'

module GenerateTrip
  def self.generate_trip(locations)
    starting_address = locations['startingAddress']
    tourist_locations = locations['touristLocations']
    puts tourist_locations
    tourist_locations.push(starting_address)
    routes_hash = Hash.new()
    key = 'GFCgDDLXoK4wA1zqapmAXlVAR3MQIY6k'
    puts 'stuff'
    array_of_routes = []
    tourist_locations.each_with_index do |loc1, i|
      tourist_locations.each_with_index do |loc2, j|
        next unless j > i

        puts loc1, loc2
        puts i, j
        tourist_locations_i_escaped = tourist_locations[i]
        tourist_locations_i_escaped.gsub!(/\s/, '')
        tourist_locations_j_escaped = tourist_locations[j]
        tourist_locations_j_escaped.gsub!(/\s/, '')
        puts 'tourist_locations_i_escaped is ' + tourist_locations_i_escaped
        puts 'tourist_locations_j_escaped is ' + tourist_locations_j_escaped
        # request_url = "http://www.mapquestapi.com/directions/v2/optimizedroute?key=#{key}&json={\"locations\":[\"#{tourist_locations_i_escaped}\", \"#{tourist_locations_j_escaped}\"]}"

        # res = HTTP.get(request_url)
        res = HTTP.get("http://www.mapquestapi.com/directions/v2/optimizedroute",
                       :params => {:key => key},
                       :json => {
                          :locations => [tourist_locations_i_escaped, tourist_locations_j_escaped]
                       }
        )
        res = JSON.parse(res.to_s)
        puts res
        puts res['route']['realTime']
        array_of_routes.push(res)
        routes_hash[loc1 + loc2] = res['route']['realTime']
        routes_hash[loc2 + loc1] = res['route']['realTime']
        # locations_hash[tourist_locations[i] + ',' + tourist_locations[j]] = res
      end
    end
    tourist_locations.pop
    result = TSP.solve_tsp(routes_hash, tourist_locations, starting_address)
    result.push(starting_address)
  end
end