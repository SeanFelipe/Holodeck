require_relative 'redc_requires'
require_relative 'model_kit'
require_relative 'tool_kit'
require_relative 'grid_setup'
require_relative 'workbox'
require_relative 'lighting'
require_relative 'materials'
require_relative 'contents'
require_relative 'pixmaps'
require_relative 'mesher'
require_relative 'reloader'
require_relative 'camera'
require_relative 'apartment'
require_relative 'input_controller_logging_camera'

#class MainGame < gdx.ApplicationAdapter
class MainGame < ApplicationAdapter
  def set_input_processor
    #@camInputController = CameraInputController.new(Camera.c)
    @camInputController = LoggingCIC.new(Camera.c)
    @mux = InputMultiplexer.new
    @mux.addProcessor(@camInputController)
    @mux.addProcessor(InputMuxer.new)
    Gdx.input.setInputProcessor(@mux)
  end

  def create
    llog("libgdx version: #{com::badlogic::gdx::Version::VERSION}")
    Gdx::graphics::setContinuousRendering(false)

    $ww, $hh = Gdx::graphics::getWidth, Gdx::graphics::getHeight

    setup_toolkits
    Camera.setup # need to setup camera before input processors
    set_input_processor
    setup_environment
    #setup_shader
    setup_3d_grid
    setup_axes
    setup_lighting
    setup_pixmap
    Workbox.setup
    setup_models

    RedTimer.init
    RedTimer.flip(50) # need an extra flip after the shader is ready

    $mesh = Mesher.proto
    $dshader = ShaderProgram.new(sh('vertex'), sh('fragment'))
    puts "$dshader.isCompiled: #{$dshader.isCompiled}"
    puts "$dshader.getLog: #{$dshader.getLog}"
    if $lazy_load_camera_rotation
      Camera.set_prev_camera_values
    end
  end

  def setup_shader
    blockPart = Contents.c.first.nodes.get(0).parts.get(0)
    @renderable = Renderable.new
    blockPart.setRenderable(@renderable)
    @renderable.worldTransform.set(1, 20, 0, 0,0,0,0)
    #@renderable.environment = $environment
    #@renderable.worldTransform.idt
    #@renderable.meshPart.primitiveType = GL20::GL_POINTS

    textureBinder = DefaultTextureBinder.new(DefaultTextureBinder::WEIGHTED, 1)
    @renderContext = RenderContext.new(textureBinder)

    vshader = Gdx::files::internal("glsl/test.vertex.glsl").readString
    fshader = Gdx::files::internal("glsl/test.fragment.glsl").readString
    config = DefaultShader::Config.new(vshader, fshader)
    @shader = DefaultShader.new(@renderable, config)
    @shader.init


    #@shader = ZomgShader.new
    #@shader.init
    #vert = Gdx::files::internal("glsl/basic/vertex.glsl").readString
    #frag = Gdx::files::internal("glsl/basic/fragment.glsl").readString
    #@shader_program = ShaderProgram.new(vert, frag)
  end

  def setup_models
    #$cruiser = Ship3d.new(:cruiser)
    #$cruiser = Ship3d.new(:ts_mech)
    #$cruiser = Ship3d.new(:ts_mech)
    Contents.add_workbox_contents
  end

  def render
    @camInputController.update
    base = 0.1
    #Gdx::gl::gl_clear_color(1, 1, 1, 1)
    Gdx::gl::gl_clear_color(base, base, base, 1)
    #Gdx::gl::gl_clear_color(0.5, 0.5, 0.5, 1)
    Gdx::gl::gl_clear(GL20::GL_COLOR_BUFFER_BIT)
    Gdx::gl::gl_clear(GL20::GL_DEPTH_BUFFER_BIT)


    MK.batch.begin(Camera.c)
    render_axes if $show_axes
    render_workbox
    render_gradations if Workbox.show_gradations
    render_models
    MK.batch.end

    #render_pmesh

    render_shader
    #render_sprite_batch

    Camera.c.update
  end

  def render_models
    #MK.batch.render($mech, @environment)
    #MK.batch.render(@asteroid, @environment)
    #MK.batch.render($cruiser.model, $environment)

    # don't render the first item, save that for our shader

    #Contents.c[1..-1].each do |item|
    Contents.c.each do |item|
      MK.batch.render(item, $environment)
    end

    #box = Contents.c[2]
    #beam_edge = Contents.c.first
    #beam_middle = Contents.c[1]
    #cone = Contents.c.last
    #MK.batch.render(beam_middle, $environment)
  end

  def render_shader
    #@shader_program.begin
    #@shader_program.setUniformMatrix("u_projViewTrans", Camera.c.combined);
    #MK.batch.render(Contents.c[1], $environment, @shader)
    #@shader_program.end

    #@renderContext.begin
=begin
    @shader.begin(Camera.c, @renderContext)
    @shader.render(@renderable)
    @shader.end
=end
    #@renderContext.end
  end

  def render_pmesh
    count = $pmesh.getNumVertices
    puts "render_pmesh with count: #{count}"
    Gdx::gl::glEnable(GL20::GL_BLEND);
    Gdx::gl::glBlendFunc(GL20::GL_SRC_ALPHA, GL20::GL_ONE_MINUS_SRC_ALPHA);
    #start = Array.new.to_java :float
    #verts = $pmesh.getVertices(start)
    #puts "render_pmesh with shader: #{$dshader} verts: #{verts}"
    $dshader.begin
    $dshader.setUniformMatrix("u_projTrans", Camera.c.combined);
    $pmesh.render($dshader, GL20::GL_TRIANGLE_FAN)
    #$pmesh.render($dshader, GL20::GL_POINTS)
    $dshader.end
  end

  def render_axes
    MK.batch.render(@xaxisbox) # red
    MK.batch.render(@yaxisbox) # green
    MK.batch.render(@zaxisbox) # blue
  end

  def render_workbox
    Workbox.w.each do |g|
      #puts "render_workbox: #{g}"
      MK.batch.render(g, $environment)
    end
  end

  def render_gradations
    Workbox.gradations.each do |g|
      #puts "render_gradations: #{g.transform.getValues}"
      MK.batch.render(g, $environment)
    end
  end

  def render_font
    #t = "#{Camera.posx} #{Camera.posy} #{Camera.posz} #{Camera.rotx} #{Camera.roty}"
    t = "#{Camera.c.position}"
    #fx = $ww - 200
    fx = 50
    fy = 50
    #TK.font.draw(TK.batch, t, fx, fy)
  end

  def render_2d
    TK.batch.draw($protoTexture, 50, 50)
  end

  def move_camera(v3)
    Camera.c.position.set(Vector3.new(v3.x, v3.y, v3.z))
    t = "#{Camera.posx} #{Camera.posy} #{Camera.posz}"
    #$camera.look_at(0,0,0)
  end

  def setup_toolkits
    MK.init # 'ModelKit', loads a ModelBuilder and ModelBatch
    TK.init # 'ToolKit', includes SpriteBatch and TK.font
  end

  def setup_environment
    # Finally we want some light, or we wont see our color.  The environment gets passed in during
    # the rendering process.  Create one, then create an Ambient ( non-positioned, non-directional ) light.
    $environment = Environment.new
    #$environment.set(ColorAttribute.new(ColorAttribute::AmbientLight, 0.2, 0.2, 0.2, 0.2))
    #$environment.set(ColorAttribute.new(ColorAttribute::AmbientLight, 1.0, 1.0, 1.0, 1.0))
    #$environment.set(ColorAttribute.new(ColorAttribute::AmbientLight, 1.0, 1.0, 1.0, 1.0))
  end

  def from_lcic(campos)
    puts "from_lcic #{campos}"
  end
end
