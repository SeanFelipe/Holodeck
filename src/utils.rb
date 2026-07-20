$desktop = true
FileRoot = "#{ENV['REDC_START_DIR']}/assets"

def libgdx_version
  llog("version: #{com::badlogic::gdx::Version::VERSION}")
  return com::badlogic::gdx::Version::VERSION
end

def fh(path)
  Gdx::files::internal("#{FileRoot}/#{path}")
end
alias :fhook :fh

def sh(fname)
  #Gdx::files::internal("#{FileRoot}/../src/shaders/#{shader_file}")
  Gdx::files::internal("src/shaders/#{fname}.glsl").readString
end
alias :shader_hook :sh

def llog(*args)
  puts '-------------------------'
  args.each {|a| puts a}
  puts '-------------------------'
end

def log_with_description(name, contents)
  puts "#{name}: #{contents}"
end
alias :ld :log_with_description

def lsep(c='=')
  puts c * 25
end

def rotation_vec3(axis)
=begin
  # original version. Seems to get the the z axis wrong.
  vs = {
    :x => [1.0,0.0,0.0],
    :y => [0.0,1.0,0.0],
    :z => [0.0,0.0,1.0]
  }
=end
  vs = {
    :x => [1.0,0.0,0.0],
    :y => [0.0,0.0,1.0],
    :z => [0.0,1.0,0.0],
  }
  Vector3.new(vs[axis].to_java(:float))
end
alias :rv3 :rotation_vec3

def rotation_quaternion(instance, axis, degrees)
  qpre = instance.transform.getRotation(Quaternion.new)
  vs = {
    :x => Vector3.new(1.0,0.0,0.0),
    :y => Vector3.new(0.0,1.0,0.0),
    :z => Vector3.new(0.0,0.0,1.0),
  }
  vec = vs.fetch(axis)
  qpost = Quaternion.new(vec, degrees)
  instance.transform.set(qpost.mul(qpre).nor)
end
alias :rotate_q :rotation_quaternion

def render
  Gdx::graphics::requestRendering
end

def to_radians(degree)
  return degree / 180 * Math::PI
end
