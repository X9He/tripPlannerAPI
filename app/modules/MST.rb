module MST
  def self.get_travel_time(hash_of_routes, route, starting_address)
    start_cost = hash_of_routes[starting_address + route[0]]
    end_cost = hash_of_routes[route[0] + starting_address]
    total_cost = start_cost + end_cost
    route.each_with_index do |loc, pos|
      if pos < route.length - 1
        total_cost += hash_of_routes[loc + route[pos + 1]]
      end
    end
    total_cost
  end

  def self.do_MST(hash_of_routes, tourist_locations, starting_address)
    temperature = 15_000
    while temperature > 0.1
      new_locations = tourist_locations
      new_locations.shuffle
      cur_cost = get_travel_time(hash_of_routes, tourist_locations, starting_address)
      new_cost = get_travel_time(hash_of_routes, new_locations, starting_address)
      delta_e = cur_cost - new_cost
      if delta_e.positive?
        tourist_locations = new_locations
      else
        prob = Math.exp(delta_e/temperature)
        tourist_locations = new_locations if rand(1) <= prob
      end
      log_x = Math.log(temperature, 1.5)
      log_x -= 0.0003
      temperature = 1.5**log_x
      end
    tourist_locations
  end
end