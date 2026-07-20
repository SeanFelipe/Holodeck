require_relative 'dims'

=begin
environment.set(new ColorAttribute(ColorAttribute.AmbientLight, 0.4f, 0.4f, 0.4f, 1f))
//environment.add(new DirectionalLight().set(0.8f, 0.8f, 0.8f, 20f, 20f, 5f))
environment.add(new DirectionalLight().set(2.8f, 2.8f, 2.8f, 40f, -40f, -10f))

=end

def setup_lighting
  #add_basic_lighting
  #add_point_light
  #add_point_light(Vector3.new(-50, 100, 100))
  #add_directional_light
  add_corner_pointlights
  #add_spotlight
  add_cone
end

def add_basic_lighting
  $environment.set(ColorAttribute.new(ColorAttribute::AmbientLight, 0.4, 0.4, 0.4, 1))
  dl = DirectionalLight.new
  dl.set(1, 1, 1, 1.0, 0.8, 0.2)
  $environment.add(dl)
end

def add_point_light(pos=nil)
  if pos == nil
    xpos = 0
    #ypos = Dims::WORKBOX_SIZE * 2
    #zpos = - Dims::WORKBOX_SIZE
    ypos = 0
    zpos = -100
  else
    xpos, ypos, zpos = pos.x, pos.y, pos.z
  end
  p = Vector3.new(xpos, ypos, zpos)
  $intensity = 5
  light = PointLight.new
  light.set(Color::WHITE, p, $intensity)
  $environment.add(light)
end

def add_spotlight
  pos = Vector3.new(Dims::FRX, Dims::FRY, Dims::FRZ)
  direction = Vector3.new(0.0, 0.0, 0.0)
  angle = 60
  fade_exponent = 1
  intensity = 50000
  light = SpotLight.new
  light.set(Color::RED, pos, direction, intensity, angle, fade_exponent)
  light.setTarget(Vector3.new(0,0,0))
  $environment.add(light)
end

=begin
def add_corner_spotlights
  hl = Dims::WORKBOX_SIZE / 2
  sp = [
    [-hl, hl, hl],
    [-hl, hl, -hl],
    [hl, hl, hl],
    [hl, hl, -hl],
  ]

  sp.each do |pos|
    p = Vector3.new(pos.first, pos[1], pos.last)
    direction = Vector3.new(0.0, -0.8, 0.0)
    angle = 60
    fade_exponent = 1
    $intensity = 50000
    light = SpotLight.new
    light.set(Color::WHITE, p, direction, $intensity, angle, fade_exponent)
    light.setTarget(Vector3.new(0,0,0))
    $environment.add(light)
  end
end
=end

def add_corner_pointlights
  hl = Dims::WORKBOX_SIZE / 2
  #pad = 100
  pad = 0
  #hl = Dims::WORKBOX_SIZE / 2 + 100
  sp = [
    [-hl - pad, hl + pad, hl + pad],
    #[-hl - pad, hl + pad, -hl - pad],
    #[hl + pad, hl + pad, hl + pad],
    [hl + pad, hl + pad, -hl - pad],
  ]

  brightness = 10000
  #brightness = 6000 # two lights this is better

  sp.each do |pos|
    p = Vector3.new(pos.first, pos[1], pos.last)
    #puts "adding point light at: #{p.x} #{p.y} #{p.z}"
    light = PointLight.new
    light.set(Color::WHITE, p, brightness)
    $environment.add(light)
  end
end

def add_directional_light
  direction = Vector3.new(-1.0, -0.8, 0.2)
  $intensity = 500000
  light = DirectionalLight.new
  light.set(Color::BLUE, direction)
  $environment.add(light)
end

def add_cone
  MK.builder.begin()
  part = MK.builder.part("cone", GL20::GL_TRIANGLES, VertexAttributes::Usage::Position | VertexAttributes::Usage::Normal, Materials::CORAL)
  #part.cone(10, 25, 10, 4)
  part.cone(5, 15, 5, 4)
  model = MK.builder.end # returns a  Model
  inst = ModelInstance.new(model)
  xpos = Dims::FRX
  ypos = Dims::FRY
  zpos = Dims::FRZ
  inst.transform.trn(Vector3.new(xpos, ypos, zpos))
  inst.transform.rotate(0,0,1,45)
  inst.transform.rotate(1,0,0,45)
  #inst.transform.rotate(1,0,0,-225)
  return inst
end
