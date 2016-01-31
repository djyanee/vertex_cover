# Jan Lachowicz (s9946)

require_relative 'graph'

def genetic_algorithm(graph, iteration_count, population_count, children_count)
  vertex_count = graph.vertex_array.size
  min_vertex_count = graph.vertex_array.size
  population = []
  new_population = []

  # GENEROWANIE LOSOWEJ POPULACJI POCZATKOWEJ
  while population.size != population_count
    random_candidate = random_boolean_array(vertex_count)
    population << random_candidate if graph.is_covered?(random_candidate)
  end

  # GENEROWANIE POPULACJI POTOMNEJ
  iteration_count.times do
    children_count.times do
      # # 1. SELEKCJA
      first_parent = spin_roulette(population)
      second_parent = spin_roulette(population)

      # # 2. KRZYZOWANIE
      new_population << crossover(first_parent, second_parent)
      new_population += [first_parent, second_parent]
    end

    # # 3. MUTACJA
    mutate(new_population)

    # OCENA WSZYSTKICH OSOBNIKOW POPULACJI
    new_population.select! { |member| graph.is_covered?(member) }
    new_population.sort! { |x, y| x.count(true) <=> y.count(true) }

    vertex_count_now = new_population.first.count(true)
    min_vertex_count = vertex_count_now if min_vertex_count > vertex_count_now

    population = new_population[0..31].dup
    new_population = Array.new
  end

  min_vertex_count
end

# GENEROWANIE LOSOWEGO OSOBNIKA
def random_boolean_array(size)
  output_array = Array.new(size)
  output_array.map { |cell| cell = [true, false].sample }
end

# SELEKCJA RULETKOWA
def spin_roulette(population)
  roulette_array = Array.new(population.size, 0)

  population.each.with_index do |boolean_array, index|
    roulette_array[index] = roulette_array[index - 1] + boolean_array.count(false)
  end

  random_number = rand(0...roulette_array[-1])

  roulette_array.each.with_index do |chance, index|
    return population[index] if random_number <= chance
  end
end

# KRZYZOWANIE
def crossover(first_parent, second_parent)
  crossover_point = rand(1..(first_parent.size - 1))
  [first_parent[0..crossover_point]] + [second_parent[(crossover_point + 1)..-1]]
end

# MUTACJA
def mutate(population)
  random_number = rand((population.size - 1) * 1000)
  if random_number < population.size - 1
    gen_number = population[random_number].size
    population[random_number][rand(gen_number)] ^= true
  end
end
