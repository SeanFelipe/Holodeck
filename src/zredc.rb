require 'pry-debugger-jruby'
require_relative 'all'



class MainGame < ApplicationAdapter

  def setup_camera
    $camera = PerspectiveCamera.new(90, @ww, @hh)
    # orthographic camera is sort of tricky
    #$camera = OrthographicCamera.new(100.0, 100.0)
    #$camera_x, $camera_y, $camera_z = 0.0, 0.0, 200.0
    $camera_x, $camera_y, $camera_z = 30.0, 0.0, -50.0

    ## Move the camera 5 units back along the z-axis and look at the origin
    $camera.position.set($camera_x, $camera_y, $camera_z)
    $camera.lookAt(0.0,0.0,0.0)

    ## Near and Far (plane) represent the minimum and maximum ranges of the camera in, um, units
    $camera.near = 10
    #$camera.far = 1000.0
    $camera.far = 5000.0
  end

  def set_input_processor
    @mux = InputMultiplexer.new
    @mux.addProcessor(InputMuxer.new)
    Gdx.input.setInputProcessor(@mux)
  end

  def setup_cruiser
    @builder = ModelBuilder.new
    @shape_renderer = ShapeRenderer.new
    @cruiser = Ship3d.new(:cruiser)
  end

  def setup_environment
    #val = 0.05
    val = 0.00000005
    # Finally we want some light, or we wont see our color.  The environment gets passed in during
    # the rendering process.  Create one, then create an Ambient ( non-positioned, non-directional ) light.
    #$environment = Environment.new
    #$environment.set(ColorAttribute.new(ColorAttribute::AmbientLight, 0.8, 0.8, 0.8, 1.0))
    #$environment.set(ColorAttribute.new(ColorAttribute::AmbientLight, val, val, val, val))
    #$environment.set(ColorAttribute.new(ColorAttribute::AmbientLight, 1.0, 1.0, 1.0, 1.0))

    #add_point_lights
    #front_of_ship if $cruiser != nil
  end

  def setup_axes
    width = 1.0
    material = Material.new(ColorAttribute.createDiffuse(Color::RED))
    model = @builder.create_box(300.0, width, width, material, VertexAttributes::Usage::Position | VertexAttributes::Usage::Normal)
    @xaxisbox = ModelInstance.new(model)

    #material = Material.new(ColorAttribute.createDiffuse(Color::GREEN))
    material = Material.new(ColorAttribute.createDiffuse(Color::RED))
    model = @builder.create_box(width, 300.0, width, material, VertexAttributes::Usage::Position | VertexAttributes::Usage::Normal)
    @yaxisbox = ModelInstance.new(model)

    material = Material.new(ColorAttribute.createDiffuse(Color::RED))
    #material = Material.new(ColorAttribute.createDiffuse(Color::BLUE))
    model = @builder.create_box(width, width, 300.0, material, VertexAttributes::Usage::Position | VertexAttributes::Usage::Normal)
    @zaxisbox = ModelInstance.new(model)
  end

  def setup_3d_grid
    increment = 50
    num_lines = 10
    sidel = 300.0
    material = Material.new(ColorAttribute.createDiffuse(Color::CORAL))
    @grid_lines = []
    xpos, ypos, zpos = -300.0, 0.0, 0.0
    num_lines.times do
      model = @builder.create_box(1, sidel, 1, material, VertexAttributes::Usage::Position | VertexAttributes::Usage::Normal)
      instance = ModelInstance.new(model)
      instance.transform.trn(Vector3.new(xpos, ypos, zpos))
      @grid_lines << ModelInstance.new(instance)
      xpos += increment
    end
  end

  def render_grid
    @grid_lines.each do |g|
      $modelBatch.render(g, $environment)
    end
  end

  def create
    Gdx::graphics::setContinuousRendering(false)
    @ww, @hh = Gdx::graphics::getWidth, Gdx::graphics::getHeight

    @builder = ModelBuilder.new
    $modelBatch = ModelBatch.new
    $modelLoader = G3dModelLoader.new(UBJsonReader.new)

    set_input_processor
    setup_environment
    setup_camera
    #setup_cruiser
    setup_axes
    setup_3d_grid
  end


  def render
    #Gdx::gl::gl_clear_color(0, 0.5, 0.2, 1)
    #Gdx::gl::gl_clear_color(0.5, 0.5, 0.5, 1)
    Gdx::gl::gl_clear_color(0.2, 0.2, 0.2, 1)
    Gdx::gl::gl_clear(GL20::GL_COLOR_BUFFER_BIT | GL20::GL_DEPTH_BUFFER_BIT)

    $camera.update
    $modelBatch.begin($camera)
    render_grid
    #$modelBatch.render(@cruiser.model, $environment)
    $modelBatch.end

  end

  def dispose
  end
end
