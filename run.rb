require_relative 'graph'

a = Graph.new
a.add_vertices(5)
a.add_edges(5)
puts a
puts
puts a.is_covered?([true, true, true, true, true])

puts puts

b = Graph.new
b.add_vertex(:a)
b.add_vertex(:b)
b.add_vertex(:c)
b.add_vertex(:d)
b.add_vertex(:e)
b.add_edge(:a, :b)
b.add_edge(:a, :c)
b.add_edge(:a, :d)
b.add_edge(:b, :d)
b.add_edge(:c, :d)
b.add_edge(:c, :e)
b.add_edge(:d, :e)
puts b
puts b.is_covered?([true, true, true, true, true])

c = Graph.new
c.load_graph(6, [[0, 0, 0, 1, 1, 1],
                 [0, 0, 0, 1, 1, 1],
                 [0, 0, 0, 1, 1, 1],
                 [1, 1, 1, 0, 0, 0],
                 [1, 1, 1, 0, 0, 0],
                 [1, 1, 1, 0, 0, 0]])
puts c.is_covered?([true, true, true, false, false, false])

d = Graph.new
d.load_graph(12, [[0, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0],
                  [1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0],
                  [1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0],
                  [0, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0],
                  [0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 1, 0],
                  [1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0],
                  [1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 1],
                  [1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 1],
                  [0, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0, 1],
                  [0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 1, 1],
                  [0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1],
                  [0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0]])
puts d.is_covered?([true, true, true, false, true, true, true, false, true, true, false, true])
