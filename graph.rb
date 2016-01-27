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

  def add_vertex(vertex)
    vertex_array << vertex
  end

  def add_edge(vertex_one, vertex_two)
    edge_array << Edge.new(vertex_one, vertex_two)
  end

  private

  def add_random_vertex
    vertex = SecureRandom.hex(5).to_sym
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
