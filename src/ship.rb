require_relative 'all'


class Ship3d

  FNS = {
    :cruiser => 'models3d/space_cruiser/space_cruiser_4.g3db',
    :ts_mech => 'models3d/turbosquid_mech/turbosquid_mech.g3db',
    :asteroid => 'models3d/asteroid/Asteroid.g3db',
  }

  ROTATION_AMT = 10
  ACCELERATION = 1

  attr_accessor :model, :transform, :speed, :velocity

  def initialize(stype)
    m = $modelLoader.loadModel(fh(FNS[stype]))
    @model = ModelInstance.new(m)
    @transform = @model.transform
    @speed = 0.0
    @rotation = 0.0
    @rotating = false
    @px = Math::sin(to_radians(@rotation))
    @py = Math::cos(to_radians(@rotation))
=begin
    # right side view
    @transform.rotate(0,1,0,270) # y-axis
=end
    #@transform.rotate(1,0,0,180) # also z-axis ?
    #@transform.rotate(0,0,1,180) # z-axis


    @transform.rotate(0,1,0,200) # y-axis
    @transform.rotate(0,0,1,15) # z-axis
  end

  def accelerate
    @speed -= ACCELERATION
    puts "#{self.class} speed: #{@speed} rotation: #{@rotation}"
  end

  def slow
    @speed += ACCELERATION
    puts "#{self.class} speed: #{@speed} rotation: #{@rotation}"
  end

  def update(delta)
    #puts "#{self.class} update at delta: #{delta}"
    _rotate if @rotating
    magnitude = @speed * delta
    dx = magnitude * @px
    dy = magnitude * @py
    #llog dx, dy
    @transform.trn(dx, dy, 0)
  end

  def _rotate
    case @direction
    when :right
      @rotation += ROTATION_AMT
      @rotation -= 360 if @rotation > 360
      @transform.rotate(0,1,0,-ROTATION_AMT)
    when :left
      @rotation -= ROTATION_AMT
      @rotation += 360 if @rotation < 0
      @transform.rotate(0,1,0,+ROTATION_AMT)
    end
    @rotation = 0 if @rotation == 360
    @px = Math::sin(to_radians(@rotation))
    @py = Math::cos(to_radians(@rotation))
    puts "rotation: #{@rotation} px: #{@px} py: #{@py}"
    llog Math::sin(@rotation), Math::cos(@rotation), Math::tan(@rotation)
    #puts "cruiser transform matrix: #{@transform}"
  end

  def left
    @rotating = true
    @direction = :left
    puts "rotation: #{@rotation} px: #{@px} py: #{@py}"
  end

  def right
    @rotating = true
    @direction = :right
    puts "rotation: #{@rotation} px: #{@px} py: #{@py}"
  end

  def stop_rotation; @rotating = false; end

end
