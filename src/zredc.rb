require 'pry-debugger-jruby'
require_relative 'all'



class MainGame < ApplicationAdapter

  def setup_camera
    $camera = PerspectiveCamera.new(90, @ww, @hh)
    # orthographic camera is sort of tricky
    #$camera = OrthographicCamera.new(100.0, 100.0)
    #$camera_x, $camera_y, $camera_z = 0.0, 0.0, 200.0
    $camera_x, $camera_y, $camera_z = 30.0, 0.0, 0.0

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
  end

  def create
    Gdx::graphics::setContinuousRendering(false)
    @ww, @hh = Gdx::graphics::getWidth, Gdx::graphics::getHeight
    set_input_processor
    setup_camera
    setup_cruiser
  end

  def render
    #Gdx::gl::gl_clear_color(0, 0.5, 0.2, 1)
    #Gdx::gl::gl_clear_color(0.5, 0.5, 0.5, 1)
    Gdx::gl::gl_clear_color(0.2, 0.2, 0.2, 1)
    Gdx::gl::gl_clear(GL20::GL_COLOR_BUFFER_BIT | GL20::GL_DEPTH_BUFFER_BIT)
    end

  def dispose
  end
end
