require 'pstore'
require_relative 'dims'

module Camera
  POSX = 0
  POSY = 2
  POSZ = 10

  TARGET = Vector3.new(0, -0, -50)
  #TARGET = Vector3.new(0, -100, POSZ)
  #TARGET = Vector3.new(0, 0, -Dims::FULL)
  #TARGET = Vector3.new(0, 0, Dims::HALF / 2)

  PERSIST_FILE = 'persist/camera.pstore'

  DEFAULT_STATE = {
    posx: nil,
    posy: nil,
    posz: nil,
    rotx: 0,
    roty: 0,
  }

  class << self
    def c; @@camera; end
    def posx; @@state.fetch(:posx); end
    def posy; @@state.fetch(:posy); end
    def posz; @@state.fetch(:posz); end
    def rotx; @@state.fetch(:rotx); end
    def roty; @@state.fetch(:roty); end

    def setup
      $ww, $hh = Gdx::graphics::getWidth, Gdx::graphics::getHeight
      @@camera ||= PerspectiveCamera.new(90, $ww, $hh)

      @@persist_store = PStore.new(PERSIST_FILE)
      @@state = @@persist_store.transaction { @@persist_store[:data] }
      puts "persist_store: #{@@state}"
      if @@state
        puts 'camera pos/rot: persist'
        $lazy_load_camera_rotation = true
      else
        puts 'camera pos/rot: default'
        @@state = DEFAULT_STATE
      end

      @@state.store(:posx, POSX)
      @@state.store(:posy, POSY)
      @@state.store(:posz, POSZ)
      ## Near and Far (plane) represent the minimum and maximum ranges of the camera in, um, units
      @@camera.near = 0.5
      @@camera.far = 200.0
      # orthographic camera is sort of tricky
      #$camera = OrthographicCamera.new(100.0, 100.0)

      if ! $hotreload
        @@camera.position.set(posx, posy, posz)
        @@camera.lookAt(TARGET)
        @@camera.update
      end

      $show_axes = false
      $show_grid = false
    end

    def set_prev_camera_values
      rx = @@state.fetch(:rotx)
      ry = @@state.fetch(:roty)
      puts "set_prev: #{rx} #{ry}"
      @@camera.rotate(Vector3.new(0,1,0), -rx)
      @@camera.rotate(Vector3.new(1,0,0), -ry)
    end

    def rotatex(val)
      # somehow we need to -1 the value
      new = @@state.fetch(:rotx) + val
      @@state.store(:rotx, new)
      persist_data
      @@camera.rotate(Vector3.new(0,1,0), -val)
    end

    def rotatey(val)
      new = @@state.fetch(:roty) - val
      @@state.store(:roty, new)
      # somehow we need to -1 the value
      persist_data
      @@camera.rotate(Vector3.new(1,0,0), -val)
    end

    def get_rotation
=begin
      public float getCameraRotation()
      {
           float camAngle = -(float)Math.atan2(camera.up.x, camera.up.y)*MathUtils.radiansToDegrees + 180;
           return camAngle;
      }
=end
=begin
      angle_rads = - ( MathUtils.atan2($camera.up.x, $camera.up.y) )
      angle_degs = angle_rads * MathUtils.radiansToDegrees
      fin = angle_degs + 180
      return fin
=end
    end

    def persist_data
      @@persist_store.transaction { @@persist_store[:data] = @@state }
    end
  end
end
