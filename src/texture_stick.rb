module TextureStick
  # var nameca: String,
  # var textureTopX: Int,
  # var textureTopY: Int,
  # var textureSideX: Int,
  # var textureSideY: Int,
  # var textureBottomX: Int,
  # var textureBottomY: Int
  @@textures = {
    grass: [:dirt, 0, 0, 3, 0, 2, 0],
    stone: [:stone, 0, 0, 3, 0, 2, 0],
    plank: [:plank, 0, 0, 3, 0, 2, 0],
    glass: [:glass, 0, 0, 3, 0, 2, 0],
  }

  TW = 16
  SPRITESHEET = 'texture_cubes/texture_cube_spritesheet.png'
  YEL = 'texture_cubes/yellow_sand.png'

  DIM = 30

  class << self

    def init
      puts 'TextureStick init'
      @builder = ModelBuilder.new

      @texture = Texture.new(fh(SPRITESHEET))
      @yel = Texture.new(fh(YEL))

      @grass = TextureRegion.new(@texture, 0, 0, TW, TW)
      @glass = TextureRegion.new(@texture, TW, TW * 3, TW, TW)
      @bricks = TextureRegion.new(@texture, TW * 7, 0, TW, TW)
      @dirt = TextureRegion.new(@texture, TW * 2, 0, TW, TW)
      #@pink = TextureRegion.new(@texture, 0, TW * 9, TW, TW)
      @pink = TextureRegion.new(@texture, 0, 9, TW, TW)
      #@yel = TextureRegion.new(@texture, 0, TW * 3, TW, TW)
      #@yel = TextureRegion.new(@texture, 18, TW * 3 + 12, TW, TW)
      # when we are on the
      #@glass = TextureRegion.new(@texture, 20, TW * 3, TW * 2, TW * 2)

      @urx = $ww - ( TW * 3 )
      @ury = $hh - ( TW * 3 )

      build_model
    end

    def matr
      atc = BlendingAttribute.new(GL20::GL_SRC_ALPHA, GL20::GL_ONE_MINUS_SRC_ALPHA) || IntAttribute.createCullFace(GL20::GL_NONE) ||  DepthTestAttribute.new(false)
      #attrs = GdxArray.new
      #attrs.add(TextureAttribute.create_diffuse(@bricks))
      #attrs.add(TextureAttribute.create_diffuse(@texture))
      #m = Material.new(TextureAttribute.create_diffuse(@grass))
      #attrs.add(atc)
      #ta = TextureAttribute.create_diffuse(@grass)
      ta = TextureAttribute.create_diffuse(@yel)
      ta.scaleU = 0.5
      ta.scaleV = 0.5
      m = Material.new(ta, atc)
    end

    def build_model
      attrs = VertexAttributes::Usage::Position || VertexAttributes::Usage::Normal || VertexAttributes::Usage::TextureCoordinates
      #@builder.begin
      #@builder.node
      #stick_model = @builder.createBox(DIM, DIM, DIM, Materials::CORAL, attrs)
      stick_model = @builder.createBox(DIM, DIM, DIM, matr, attrs)
      #@builder.begin
      #@builder.part("box", GL20::GL_TRIANGLES, attrs, matr).rect(-0.5, -0.5, -0.5, -0.5, 0.5, -0.5, 0.5, 0.5, -0.5, 0.5, -0.5, -0.5, 0, 0, -1)
      #stick_model = @builder.end
      @stick = ModelInstance.new(stick_model)
      #@stick.transform.rotate(0,0,1,-30)
      @stick.transform.rotate(0,1,0,30)
      @stick.transform.rotate(1,0,0,15)
      #@builder.end
    end

=begin
      @@textures.each_pair do |kind, values|
        tr_top = TextureRegion.new(texture, values[1] * TW, values[2] * TW, TW, TW)
        tr_side = TextureRegion.new(texture, values[3] * TW, values[4] * TW, TW, TW)
        tr_bottom = TextureRegion.new(texture, values[5] * TW, values[6] * TW, TW, TW)

        texture_attrs = VertexAttributes::Usage::Position || VertexAttributes::Usage::Normal || VertexAttributes::Usage::TextureCoordinates
        material_attrs = Attributes.new
        material_attrs.set(BlendingAttribute.new(GL20::GL_SRC_ALPHA, GL20::GL_ONE_MINUS_SRC_ALPHA))
        material_attrs.set(IntAttribute.createCullFace(GL20::GL_NONE))
        material_attrs.set(DepthTestAttribute.new(false))

        builder.begin
        builder.part("box", GL20::GL_TRIANGLES, attr, Material.new(TextureAttribute::createDiffuse(tr_top, material_attrs)).rect(-0.5, -0.5, -0.5, -0.5, 0.5, -0.5, 0.5, 0.5, -0.5, 0.5, -0.5, -0.5, 0, 0, -1)
        builder.part("box", GL20::GL_TRIANGLES, attr, Material.new(TextureAttribute::createDiffuse(tr_side, material_attrs)).rect(-0.5, 0.5, 0.5, -0.5, -0.5, 0.5, 0.5, -0.5, 0.5, 0.5, 0.5, 0.5, 0, 0, 1)
        builder.part("box", GL20::GL_TRIANGLES, attr, Material.new(TextureAttribute::createDiffuse(tr_side, material_attrs)).rect(-0.5, -0.5, 0.5, -0.5, -0.5, -0.5, 0.5, -0.5, -0.5, 0.5, -0.5, 0.5, 0, -1, 0)

                     builder.part("box", GL20::GL_TRIANGLES, attr, Material.new(TextureAttribute::createDiffuse(tr_side, material_attrs)).rect(-0.5, 0.5, -0.5, -0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, -0.5, 0, 1, 0)

                                  builder.part("box", GL20::GL_TRIANGLES, attr, Material.new(TextureAttribute::createDiffuse(tr_side, material_attrs)).rect(-0.5, -0.5, 0.5, -0.5, 0.5, 0.5, -0.5, 0.5, -0.5, -0.5, -0.5, -0.5, -1, 0, 0)
                                               builder.part("box", GL20::GL_TRIANGLES, attr, Material.new(TextureAttribute::createDiffuse(tr_bottom, material_attrs))
                                                 .rect(0.5, -0.5, -0.5, 0.5, 0.5, -0.5, 0.5, 0.5, 0.5, 0.5, -0.5, 0.5, 1, 0, 0)
                                               model = builder.end
      end
=end

    def render
      TK.sbatch.begin
      #TK.sbatch.draw(@@texture, 50, 50)
      TK.sbatch.draw(@grass, @urx, @ury)
      TK.sbatch.draw(@glass, @urx, @ury - TW)
      TK.sbatch.draw(@dirt, @urx, @ury - (TW * 2))
      TK.sbatch.draw(@bricks, @urx, @ury - (TW * 3))
      TK.sbatch.end
      render_models
    end

    def render_models
      puts "models render"
      TK.mb.begin($camera)
      TK.mb.render(@stick, $environment)
      TK.mb.end
    end
  end
end
