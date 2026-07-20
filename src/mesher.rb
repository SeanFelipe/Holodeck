module Mesher

  class V
    ZDEPTH = 3
    attr_accessor :x, :y
    def initialize(x, y)
      @x = x
      @y = y
    end
  end

  POSITION_NUM_COMPONENTS = 3
  COLOR_NUM_COMPONENTS = 4

  WALL_HEIGHT = 4

  class << self

    def wall_proto(width, depth)
      dx, dy = width / 2, depth / 2
      h2 = WALL_HEIGHT / 2

      vertices = [
        -dx, h2, 0,
        dx, h2, 0,
        dx, -h2, 0,
        -dx, -h2, 0,
      ]

      arr = []
      #interesting.each { |vv| arr.concat([vv.x, vv.y, 0]) }
      #interesting.each { |vv| arr.concat([vv.x, vv.y, z_depth]) }
      puts "arr: #{arr}"
      #vs = arr.to_java :float
      vs = vertices.to_java :float
      const_position = 1
      #const_color = 2
      a_position =  VertexAttribute.new(const_position, POSITION_NUM_COMPONENTS, "a_position")
      mesh = Mesh.new(true, vs.length, 0, a_position)
      mesh.setVertices(vs, 0, vs.length)
      puts "mesh vertices: #{mesh.getNumVertices}"
      return mesh
    end


    def proto
      width = 20
      height = 6
      dx = width / 2.0
      dy = height / 2.0
      #vbo = VertexBufferObject.new(true, 8, VertexAttributes::Usage::Position | VertexAttributes::Usage::Normal)
      # symmetrical so we need to only define one set, without z-coords.
      z_depth = 3
      interesting = [
        -dx, 0, 0,
         dx, 0, 0,
         dx, height, 0,
        -dx, height, 0,
        #V.new(-dx, dy),
        #V.new( dx, dy),
        #V.new(0, dx),
        #V.new(0, -dx),
      ]

      arr = []
      #interesting.each { |vv| arr.concat([vv.x, vv.y, 0]) }
      #interesting.each { |vv| arr.concat([vv.x, vv.y, z_depth]) }
      #puts "mesher arr: #{arr}"
      #vs = arr.to_java :float
      vs = interesting.to_java :float
      const_position = 1
      #const_color = 2
      a_position =  VertexAttribute.new(const_position, POSITION_NUM_COMPONENTS, "a_position")
      mesh = Mesh.new(true, vs.length, 0, a_position)
      mesh.setVertices(vs, 0, vs.length)
      #puts "Mesher#proto vertices: #{mesh.getNumVertices}"
      return mesh
    end
  end
end
