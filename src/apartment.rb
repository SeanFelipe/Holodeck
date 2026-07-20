module Apartment
  # ORIGINAL SIZE pretty small
  #D = 9.017 # 355 inches, 29'7"
  #W = 8.5344 # 336 inches, 28'0"
  #H = 4.826 # 14 feet, 190"
  #
  # LET'S MAKE IT A DOUBLE_SIZE apartment, 2X W and L but same size H
  D = 9.017 * 2
  W = 8.5344 * 2
  #H = 4.826 # 14 feet, 190"
  H = 4
  #WALL_HEIGHT = 0.2
  WALL_HEIGHT = H
  WALL_THICKNESS = 0.2

  POSITION_NUM_COMPONENTS = 3

  class << self
    def door
      height = 2.4
      width = 1.7
      depth = 0.1
      zpad = -1.3
      xloc = -1.9
      model = MK.builder.create_box(
        width,
        height,
        depth,
        Materials::DOOR,
        VertexAttributes::Usage::Position | VertexAttributes::Usage::Normal | VertexAttributes::Usage::TextureCoordinates
      )
      inst = ModelInstance.new(model)
      inst.transform.trn(xloc, height / 2, zpad)
      return inst
    end

    def wall(len)
      model = MK.builder.create_box(
        len,
        WALL_THICKNESS,
        WALL_HEIGHT,
        Materials::WALL,
        VertexAttributes::Usage::Position | VertexAttributes::Usage::Normal | VertexAttributes::Usage::TextureCoordinates
      )
      inst = ModelInstance.new(model)
      return inst
    end

    def wall1
      w1 = wall(D)
      rotate_q(w1, :x, -90)
      rotate_q(w1, :y, -90)
      xbase = -9
      ybase = WALL_HEIGHT / 2
      zbase = -10
      xpad = -0.50
      ypad = 0
      zpad = -0
      w1.transform.trn(xpad + xbase, ypad + ybase, zpad + zbase)
      return w1
    end

    def wall2
      w1 = wall(D)
      rotate_q(w1, :x, -90)
      rotate_q(w1, :y, -90)
      xbase = 8
      ybase = WALL_HEIGHT / 2
      zbase = -10
      xpad = -0.1
      ypad = 0
      zpad = -0
      w1.transform.trn(xpad + xbase, ypad + ybase, zpad + zbase)
      return w1
    end

    def wall3
      w1 = wall(W)
      rotate_q(w1, :x, -90)
      #rotate_q(w1, :y, -90)
      xbase = -0
      ybase = WALL_HEIGHT / 2
      zbase = -1
      xpad = -0.75
      ypad = 0
      zpad = -0.05
      w1.transform.trn(xpad + xbase, ypad + ybase, zpad + zbase)
      return w1
    end

    def wall4
      w1 = wall(W)
      rotate_q(w1, :x, -90)
      #rotate_q(w1, :y, -90)
      xbase = -0
      ybase = WALL_HEIGHT / 2
      zbase = -19
      xpad = -0.75
      ypad = 0
      zpad = 0.10
      w1.transform.trn(xpad + xbase, ypad + ybase, zpad + zbase)
      return w1
    end


    def surrounding_walls
      out = []
      out << wall1
      out << wall2
      out << wall3
      out << wall4
      return out
    end

    def refimage
      texture = Texture.new(fh('ref_photos/apartment_1bd.jpg'))
      #ratio = 1.67
      #texture = Texture.new(fh('ref_photos/armata_schematic_side.jpg'))
      #texture = Texture.new(fh('ref_photos/countryside.png'))
      #grass = TextureRegion.new(texture, 0, 0, 16, 16)
      #attribute = TextureAttribute.createDiffuse(grass)
      attribute = TextureAttribute.createDiffuse(texture)
      mat = Material.new(attribute)
      xpad = -0
      ypad = 0
      scale = 1.28
      w = W * scale
      l = D * scale
      #ratio = 1.67
      #xmod = 1.64
      #l = 8.88
      #len = l * xmod
      #height = len / ratio
      model = MK.builder.create_box(w, l, 0.1, mat, VertexAttributes::Usage::Position | VertexAttributes::Usage::Normal | VertexAttributes::Usage::TextureCoordinates)
      #model = MK.builder.create_box(0.01,10,10, Materials::VIOLET, VertexAttrib
      inst = ModelInstance.new(model)
      inst.materials.first.set(attribute)
      rotate_q(inst, :x, -90)
      rotate_q(inst, :y, 90)
      #rotate_q(inst, :y, -90)
      #rotate_q(inst, :z, -90)
      inst.transform.trn(xpad,ypad,-10)
      return inst
    end
  end
end
