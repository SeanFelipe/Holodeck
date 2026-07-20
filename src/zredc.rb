require_relative 'mux'
require_relative 'utils'
require_relative 'tool_kit'
require_relative 'texture_stick'
require_relative 'materials'

CAMERA_START_X = 0
CAMERA_START_Y = 0
CAMERA_START_Z = 200

class MainGame < ApplicationAdapter
  def create
    puts 'MainGame#create'    #Gdx::graphics::setContinuousRendering(false)
    $ww, $hh = Gdx::graphics::getWidth, Gdx::graphics::getHeight
    set_camera
    set_input_processor
    set_environment

    TK.init
    TextureStick.init
  end

  def set_camera
    $camera = PerspectiveCamera.new(67, $ww, $hh)
    $camera.position.set(CAMERA_START_X, CAMERA_START_Y, CAMERA_START_Z)
    ## Near and Far (plane) represent the minimum and maximum ranges of the camera in, um, units
    $camera.look_at(0,0,0)
    $camera.near = 1.0
    $camera.far = 300.0
    $camera.update
    @camController = CameraInputController.new($camera)
  end

  def set_input_processor
    @mux = InputMultiplexer.new
    @mux.addProcessor(ZomgMuxer.new)
    @mux.addProcessor(@camController)
    Gdx.input.setInputProcessor(@mux)
  end

  def set_environment
    $environment = Environment.new
    #puts "zredc @env class: #{$environment.class}"
    #$environment.set(ColorAttribute.new(ColorAttribute::AmbientLight, 0.4, 0.4, 0.4, 1.0))
    light = DirectionalLight.new
    light.set(0.8, 0.8, 0.8, -1.0, -0.8, -0.2)
    #$environment.add(light)
  end

  def render
    Gdx::gl::gl_clear_color(0, 0, 0, 1)
    #Gdx::gl::gl_clear_color(0.5, 0.5, 0.5, 1)
    Gdx::gl::gl_clear(GL20::GL_COLOR_BUFFER_BIT | GL20::GL_DEPTH_BUFFER_BIT)

    TextureStick.render
  end
end
