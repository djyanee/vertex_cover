# Jan Lachowicz (s9946)

require_relative 'graph'
require_relative 'genetic_algorithm'
require_relative 'tabu_list'

a = Graph.new
a.add_vertices(30)
a.add_edges(120)

puts 'Genetic algorithm:'
start_time = Time.now
puts genetic_algorithm(a, 50, 24, 18)
puts "Time: #{Time.now - start_time} seconds."

puts 'Tabu-list algorithm:'
start_time = Time.now
puts tabu_list(a, 200)
puts "Time: #{Time.now - start_time} seconds."
