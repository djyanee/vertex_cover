require 'securerandom'
require 'set'
require_relative 'edge'

class Graph
  attr_accessor :vertex_array, :edge_array

  def initialize
    @vertex_array = []
    @edge_array = []
  end

  def add_vertices(count)
    while vertex_array.size != count
      add_random_vertex
    end
  end

  def add_edges(count)
    while edge_array.size != count
      add_random_edge
    end
  end

  def to_s
    output = "Vertices:\n"
    vertex_array.each { |vertex| output << "#{vertex}\n" }
    output << "\nEdges:\n"
    edge_array.each { |edge| output << "#{edge}\n" }
    output
  end

  def edges_for_vertex(vertex)
    edge_array.select { |edge| edge.includes_vertex?(vertex) }
  end

  def is_covered?(boolean_array)
    cover_array = []

    boolean_array.each.with_index do |vertex_boolean, index|
      cover_array.concat(edges_for_vertex(vertex_array[index])) if vertex_boolean
    end

    return true if cover_array.uniq.size == edge_array.size
    false
  end

  def load_graph(number, graph_array)
    number.times do
      add_vertex(SecureRandom.hex(5).to_sym)
    end
    graph_array.each.with_index do |row, row_index|
      row.each.with_index do |vertex, column_index|
        edge = Edge.new(vertex_array[row_index], vertex_array[column_index])
        edge_array << edge if vertex == 1 && !edge_exists?(edge)
      end
    end
  end

  def add_vertex(vertex)
    vertex_array << vertex
  end

  def add_edge(vertex_one, vertex_two)
    edge_array << Edge.new(vertex_one, vertex_two)
  end

  # NEEDED FOR TABU LIST ALGORITHM
  def find_neighbours(vertex)
    neighbours_array = []
    edges_with_vertex = edge_array.select { |edge| edge.includes_vertex?(vertex) }
    edges_with_vertex.each do |edge|
      neighbours_array << if edge.vertex_one == vertex
                            edge.vertex_two
                          else
                            edge.vertex_one
                          end
    end
    neighbours_array
  end

  def number_of_edges_for_vertex(vertex)
    edges_for_vertex(vertex).size
  end

  def neighbour_with_most_edges(neighbours)
    count_array = neighbours.map { |neighbour| number_of_edges_for_vertex(neighbour) }
    neighbours[count_array.index(count_array.max)]
  end

  def get_index_of_vertex(vertex)
    vertex_array.index(vertex)
  end
  # END

  private

  def add_random_vertex
    vertex = SecureRandom.hex(1).to_sym
    vertex_array << vertex.to_sym unless vertex_array.include?(vertex)
  end

  def add_random_edge
    random_vertex_one = vertex_array[rand(vertex_array.size)]
    random_vertex_two = vertex_array[rand(vertex_array.size)]
    edge = Edge.new(random_vertex_one, random_vertex_two)
    if random_vertex_one != random_vertex_two && !edge_exists?(edge)
      edge_array << edge
    end
  end

  def edge_exists?(given_edge)
    edge_array.each do |edge|
      return true if edge.is_same_as? given_edge
    end
    false
  end
end
