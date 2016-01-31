# Jan Lachowicz (s9946)

require_relative 'graph'

def tabu_list(graph, iteration_count)
  min_vertex_count = graph.vertex_array.size

  iteration_count.times do
    boolean_array = Array.new(graph.vertex_array.size, false)

    tabu_list = [graph.vertex_array.sample]
    boolean_array[graph.get_index_of_vertex(tabu_list.last)] = true

    while !graph.is_covered?(boolean_array)
      neighbours_list = graph.find_neighbours(tabu_list.last)

      if (neighbours_list - tabu_list).empty?
        breaked = true
        break
      end

      # przyjmuję, że decydująca przy wyborze następnego wierzchołka jest ilość krawędzi (max)
      neighbours_list -= tabu_list
      tabu_list << graph.neighbour_with_most_edges(neighbours_list)

      number_to_check = graph.get_index_of_vertex(tabu_list.last)
      # sprawdzenie czy jest typu Boolean
      if number_to_check.is_a? Fixnum
        boolean_array[graph.get_index_of_vertex(tabu_list.last)] = true
      end
    end

    min_vertex_count = tabu_list.size if min_vertex_count > tabu_list.size && !breaked
  end

  min_vertex_count
end
