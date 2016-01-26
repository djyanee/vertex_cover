class Edge
  attr_accessor :vertex_one, :vertex_two

  def initialize(vertex_one, vertex_two)
    @vertex_one = vertex_one
    @vertex_two = vertex_two
  end

  def is_same_as?(other)
    normal = vertex_one == other.vertex_one && vertex_two == other.vertex_two
    inverse = vertex_one == other.vertex_two && vertex_two == other.vertex_one
    normal || inverse
  end

  def to_s
    "#{@vertex_one} <---> #{@vertex_two}"
  end
end

