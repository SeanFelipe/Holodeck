require_relative 'figures'
require_relative 'mesher'

module Contents
  class << self

    @@c = Array.new
    def c; @@c; end

    def add(item)
      @@c << item
    end

    def reload
      load "#{MainGame::BASEDIR}/contents.rb"
      Contents.add_workbox_contents
    end

    def add_workbox_contents
      @cc = Array.new
      #add_cone
      #add_center_sphere
      #add_metal_beam
      #add_metal_beam(-300)
      #add_camera_sim_box(100, 0, -200)
      #add_camera_sim_box(0, 1, 0)
      @@c << Figures.female
      #@@c << Apartment.door
      @@c << Apartment.refimage
      @@c.concat(Apartment::surrounding_walls)
      $pmesh = Mesher.wall_proto(9.017 * 2, 8.5344 * 2)

      #add_mesh_parts
      #puts "end of add_workbox_contents w @@c: #{@@c}"
      #$pmesh = Apartment.length_side
      #puts "$pmesh: #{$pmesh}"
    end


    def new_box(width, height, depth, material, xpos, ypos, zpos)
      model = MK.builder.create_box(width, height, depth, Materials::GRAY, VertexAttributes::Usage::Position | VertexAttributes::Usage::Normal)
      metal_beam = ModelInstance.new(model)
      ypos_adjusted = ypos + ( height / 2 )
      metal_beam.transform.trn(Vector3.new(xpos, ypos_adjusted, zpos))
      return metal_beam
    end

    def add_camera_sim_box(x, y, z)
      width = 3
      depth = 2
      height = 1
      sim_box_camera = new_box(width, height, depth, Materials::GRAY, x, y, z)
      @@c << sim_box_camera
    end

    def add_metal_beam(zpos=0)
      width = 20
      other_dim = 1
      metal_beam = new_box(width, other_dim, other_dim, Materials::GRAY, 0, 0, zpos)
      @@c << metal_beam
    end

    def add_center_sphere(zpos=0)
      width = 2
      model = MK.builder.createSphere(width, width, width, 0.8, 0.8, 0.1, Materials::GRAY, VertexAttributes::Usage::Position | VertexAttributes::Usage::Normal)
      sphere = ModelInstance.new(model)
      sphere.transform.trn(Vector3.new(0, 10, 0))
      @@c << sphere
    end

    def add_mesh_parts
      MK.builder.begin()
      part = MK.builder.part("part1", GL20::GL_TRIANGLES, VertexAttributes::Usage::Position | VertexAttributes::Usage::Normal, Materials::GRAY)
      part.cone(5, 5, 5, 10)
      node = MK.builder.node()
      node.translation.set(1,10,0)
      part = MK.builder.part("part2", GL20::GL_TRIANGLES, VertexAttributes::Usage::Position | VertexAttributes::Usage::Normal, Materials::GRAY)
      part.sphere(0.5, 0.5, 0.5, 1, 1)
      model = MK.builder.end() # Model
      inst = ModelInstance.new(model)
      @@c << inst
    end
  end
end
