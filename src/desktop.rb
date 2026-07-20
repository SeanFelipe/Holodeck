require 'listen'
require_relative 'java_imports'
require_relative 'zredc'
require_relative 'reloader'

configuration = Lwjgl3ApplicationConfiguration.new
configuration.title = 'RedC'
configuration.disableAudio true
#motox = 720
ten80 = 1080 / 3
#new_feb = 400
#$worldx = ten80
#$worldy = $worldx * 1.7777
$worldx = 1200
$worldy = 1024
$scale = 1
#configuration.width = $worldx / $scale
#configuration.height = $worldy / $scale  # 16:9 aspect ratio
#configuration.height = configuration.width * 1.644  # Gdx.graphics.getWidth motox getHeight from the phone is 720, 1184
configuration.setWindowedMode($worldx, $worldy)
configuration.resizable = true


runfile_dir = 'src'

listener = Listen.to(runfile_dir, only: /\.rb/) do |modified, added, removed|
  puts "modified absolute path: #{modified}"
  #puts "added absolute path: #{added}"
  #puts "removed absolute path: #{removed}"
  if modified != []
    if modified != nil
      print 'reloading...'
      Reloader.reload(true)
      #print 'reload complete'
    end
  end
end
listener.start


$redc = MainGame.new
puts 'starting $redc ...'
Lwjgl3Application.new($redc, configuration)
