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
    count.times { add_vertex }
  end

  def add_edges(count)
    count.times { add_random_edge }
  end

  def to_s
    output = "Vertices:\n"
    @vertex_array.each { |vertex| output << "#{vertex}\n" }
    output << "Edges:\n"
    @edge_array.each { |edge| output << "#{edge}\n" }
    output
  end

  private

  def add_vertex
    vertex = "a#{SecureRandom.hex(10)}".to_sym
    @vertex_array << vertex.to_sym unless @vertex_array.include?(vertex)
  end

  def add_edge(vertex_one, vertex_two)
    @edge_array << Edge.new(vertex_one, vertex_two)
  end

  def add_random_edge
    random_vertex_one = @vertex_array[rand(@vertex_array.size)]
    random_vertex_two = @vertex_array[rand(@vertex_array.size)]
    edge = Edge.new(random_vertex_one, random_vertex_two)
    if random_vertex_one != random_vertex_two && !edge_exists?(edge)
      @edge_array << edge
    end
  end

  def edge_exists?(given_edge)
    @edge_array.each do |edge|
      return true if edge.is_same_as? given_edge
    end
    false
  end
end

a = Graph.new
a.add_vertices(10)
a.add_edges(10)
puts a