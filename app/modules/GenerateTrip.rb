require 'rubygems'
require 'http'

module GenerateTrip
  def self.generate_trip(locations)
    key = ''
    res = HTTP.get("http://www.mapquestapi.com/directions/v2/optimizedroute?key=#{key}&json={'locations':['Denver,CO','Westminster,CO','Boulder,CO']}")
    puts 'stuff'
    res = JSON.parse(res.to_s)
    puts res['route']['realTime']
    locations.each do |i|
      puts 'why????'
    end
  end
end