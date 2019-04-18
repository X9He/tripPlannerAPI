module TSP
  def self.get_travel_time(hash_of_routes, route, starting_address)
    # puts 'printing the stuff in get_travel_time'
    # puts starting_address, route[0]
    from_start_to_next = starting_address + route[0]
    from_end_to_start = route[-1] + starting_address
    # puts 'from_start_to_next is ', from_start_to_next
    # puts 'from_end_to_start is ', from_end_to_start
    # puts hash_of_routes
    start_cost = hash_of_routes[from_start_to_next]
    end_cost = hash_of_routes[from_end_to_start]
    # puts 'start_cost is ', start_cost
    # puts 'end_cost is ', end_cost
    total_cost = start_cost + end_cost
    route.each_with_index do |loc, pos|
      if pos < route.length - 1
        current_leg = loc + route[pos + 1]
        total_cost += hash_of_routes[current_leg]
      end
    end
    total_cost
  end

  def self.solve_tsp(hash_of_routes, tourist_locations, starting_address)
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