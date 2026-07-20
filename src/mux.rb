require 'pry'
require_relative 'reloader'

#class InputMuxer < gdx.InputAdapter
class InputMuxer < InputAdapter

  INCREMENT = 10
  #TI = 10
  TI = 5
  puts "new TI: #{TI}"
  ZINC = 50.0
  RINC = 20.0 # rotation increment

  def keyDown(keycode)
    begin
      process_keydown(keycode)
    rescue NoMethodError => e
      puts e
      puts e.backtrace
    end
  end

  def process_keydown(keycode)
    $keydown = keycode
    puts "keyDown: #{keycode}"

    if $keydown != nil

      case $keydown
      when Input::Keys::NUM_4
        $show_gradations = !$show_gradations
      when Input::Keys::B
        binding.pry
      end

=begin
      case $keydown
      when 19
        puts 'forward arrow'
        $cruiser.accelerate
      when 21 # l arrow
        $cruiser.left
      when 22 # r arrow
        $cruiser.right
      when 20
        puts 'back arrow'
        $cruiser.slow
      when Input::Keys::P
        puts $cruiser.transform
      end
=end

      incr = 30
      if [ 69,70,71,72,74,75 ].include? $keydown
        #qpre1 = $m1.transform.getRotation(Quaternion.new)
        #qpre2 = $m2.transform.getRotation(Quaternion.new)
        incr = 30

        case $keydown
        when 69 # -_
          vec = Vector3.new(1,0,0)
          ang = incr
        when 70 # +=
          vec = Vector3.new(1,0,0)
          ang = - incr
        when 71
          vec = Vector3.new(0,1,0)
          ang = incr
        when 72
          vec = Vector3.new(0,1,0)
          ang = - incr
        when 74
          vec = Vector3.new(0,0,1)
          ang = incr
        when 75
          vec = Vector3.new(0,0,1)
          ang = - incr
        end

        qpost1 = Quaternion.new(vec, ang)
        qpost2 = Quaternion.new(vec, ang)
        $m1.transform.set(qpost1.mul(qpre1).nor)
        $m2.transform.set(qpost2.mul(qpre2).nor)
      end


=begin
        #$turret.left
        #$pic.transform.rotate(rv3(:y), -90)
        qpost = Quaternion.new(Vector3.new(1,0,0), -90)
        $m1.transform.set(qpost.mul(qpre).nor)
        #$m1.transform.rotate(rv3(:x), -incr)
        #$m2.transform.rotate(rv3(:x), -incr)
      when 70 # +=
        #$turret.right
        #$pic.transform.rotate(rv3(:y), 90)
        qpre = $m1.transform.getRotation(Quaternion.new)
        qpost = Quaternion.new(Vector3.new(1,0,0), -90)
        $m1.transform.set(qpost.mul(qpre).nor)
        #$m1.transform.rotate(rv3(:x), incr)
        #$m2.transform.rotate(rv3(:x), incr)
      when 71
        #$pic.transform.rotate(rv3(:x), -90)
        $m1.transform.rotate(rv3(:y), -incr)
        $m2.transform.rotate(rv3(:y), -incr)
      when 72
        #$pic.transform.rotate(rv3(:x), 90)
        $m1.transform.rotate(rv3(:y), incr)
        $m2.transform.rotate(rv3(:y), incr)
      when 74
        #$pic.transform.rotate(rv3(:z), -90)
        $m1.transform.rotate(rv3(:z), -incr)
        $m2.transform.rotate(rv3(:z), -incr)
      when 75
        #$pic.transform.rotate(rv3(:z), 90)
        $m1.transform.rotate(rv3(:z), incr)
        $m2.transform.rotate(rv3(:z), incr)
      end
=end

=begin
    when Input::Keys::J
      $cruiser.transform.rotate(rotation_vec3(:x), -INCREMENT);
    when Input::Keys::K
      puts 'pressed K'
      $cruiser.transform.rotate(rotation_vec3(:x), INCREMENT);
    when Input::Keys::N
      puts 'pressed N'
      $cruiser.transform.rotate(rotation_vec3(:z), INCREMENT);
    when Input::Keys::M
      puts 'pressed M'
      $cruiser.transform.rotate(rotation_vec3(:z), -INCREMENT);
    end

=end

      # move camera
      case $keydown
      when Input::Keys::I
        puts "camera rotation: #{Camera.get_rotation}"
      when Input::Keys::O
        Camera.rotatex(-RINC)
      when Input::Keys::P
        Camera.rotatex(RINC)
      when Input::Keys::K
        Camera.rotatey(-RINC)
      when Input::Keys::L
        Camera.rotatey(RINC)
      when Input::Keys::Z
        puts 'pressed Z'
        zoom_camera_z(-ZINC)
      when Input::Keys::X
        puts 'pressed X'
        zoom_camera_z(ZINC)
      when Input::Keys::D
        v3 = Vector3.new(0, 10, 0)
      when Input::Keys::C
        v3 = Vector3.new(0, -10, 0)
      when Input::Keys::W
        v3 = Vector3.new(-TI, 0, 0)
      when Input::Keys::E
        v3 = Vector3.new(TI, 0, 0)
      when 19
        puts 'forward arrow'
        v3 = Vector3.new(0, 0, -TI)
      when 20
        puts 'back arrow'
        v3 = Vector3.new(0, 0, TI)
      when Input::Keys::K
        #puts "camera lookAt"
        $camera.lookAt(Camera::CAMERA_TARGET)
      end

      $redc.move_camera(v3) if v3 != nil

=begin
      # move camera
      case $keydown
      when 8
        coords = Vector3.new(0, 0, 100)
        $camera.position.set(coords)
      when 9
        coords = Vector3.new(100, 0, 0)
        $camera.position.set(coords)
      when 10
        coords = Vector3.new(0, 0, -100)
        $camera.position.set(coords)
      when 11
        coords = Vector3.new(-100, 0, 0)
        $camera.position.set(coords)
      end

      #$camera.lookAt(Camera::CAMERA_TARGET)
=end

=begin
      # move cruiser
      case keycode
      when Input::Keys::C
        puts 'pressed C'
        $cruiser.transform.trn(Vector3.new(-TI, 0, 0))
      when Input::Keys::V
        puts 'pressed V'
        $cruiser.transform.trn(Vector3.new(TI, 0, 0))
      when Input::Keys::G
        $cruiser.transform.trn(Vector3.new(0, TI, 0))
      when Input::Keys::B
        $cruiser.transform.trn(Vector3.new(0, -TI, 0))
      end

=end


      # quit - load - restart - grid
      case $keydown
      when Input::Keys::A
        $show_axes = ! $show_axes
      when Input::Keys::G
        $show_grid = ! $show_grid
      when Input::Keys::R
        #`touch ../is_running/desktop`
        #Gdx.app.exit
        #$redc.rreload
        #Contents.reload
        #Reloader.reload
        Reloader.post_reload
      when Input::Keys::Q
        Gdx.app.exit
      end
    end

    #puts $cruiser.transform

    RedTimer.flip
    return true
  end

  def keyUp(keycode)
    begin
      process_keyup(keycode)
    rescue NoMethodError => e
      puts e
      puts e.backtrace
    end
  end

  def process_keyup(keycode)
    $keydown = nil
    puts "keyUp: #{keycode}"
    rotation_codes = [21, 22]
    if rotation_codes.include? keycode
      #$cruiser.stop_rotation
    end
    RedTimer.flip
    return true
  end

  def mouseMoved(sx, sy)
    #puts "mousemoved: #{sx} #{sy}"
    return true
  end

  def set_camera
    #llog $camera_x,@camera_y,$camera_z
    $camera.position.set($camera_x,$camera_y,$camera_z)
    #$camera.lookAt(Camera::CAMERA_TARGET)
    RedTimer.flip
  end

  def zoom_camera_z(amt)
    #llog $camera_x,$camera_y,$camera_z
    $camera_z += amt
    $camera.position.set($camera_x, $camera_y, $camera_z)
    RedTimer.flip
  end
end
