class LoggingCIC < CameraInputController
  def touchDragged(screenx, screeny, pointer)
    super(screenx, screeny, pointer)
    #puts "touchDragged #{screenx} #{screeny}"
    #puts "touchDragged camera: #{camera} direction: #{camera.direction}"
    #puts "camera dir: #{camera.direction} pos: #{camera.position}"
    #puts "camera dir: #{camera.direction} position: #{camera.position}"
    #puts "$redc: #{$redc}"
    #$redc.from_lcic(camera.position)
    #$campos = Vector3.new(camera.position)
  end
end
