# Jan Lachowicz (s9946)

class Edge
  attr_accessor :vertex_one, :vertex_two

  def initialize(vertex_one, vertex_two)
    @vertex_one = vertex_one
    @vertex_two = vertex_two
  end

  # SPRAWDZENIE CZY KRAWEDZ ISTNIEJE (ZALOZENIE O DWUKIERUNKOWOSCI KRAWEDZI)
  def is_same_as?(other)
    normal = vertex_one == other.vertex_one && vertex_two == other.vertex_two
    inverse = vertex_one == other.vertex_two && vertex_two == other.vertex_one
    normal || inverse
  end

  # SPRAWDZA CZY KRAWEDZ ZAWIERA DANY WIERZCHOLEK
  def includes_vertex?(vertex)
    return true if vertex_one == vertex || vertex_two == vertex
    false
  end

  # WYPISANIE KRAWEDZI
  def to_s
    "#{@vertex_one} <---> #{@vertex_two}"
  end
end
