require 'java'
java_import java.lang.Runnable

module Reloader
  FILES =  [
   #"./reloader.rb",
   #"./contents.rb",
   #"./figures.rb",
   #"./mux.rb",
   #"./workbox.rb",
   #"./dims.rb",
   #"./camera.rb",
   #"./apartment.rb",
   #"./zredc.rb",
   "./texture_stick.rb",
  ]

  BASE_DIR = Dir.pwd

  class ReloadRequest
    include Runnable
    def run
      Reloader.reload
    end
  end

  class << self
    def reload(from_listener=false)
      $hotreload = true

      basedir = BASE_DIR
      basedir += '/src' if from_listener
      puts "start reload from dir: #{basedir}"
      $VERBOSE = nil
      FILES.each do |ff|
        path = "#{basedir}/#{ff}"
        puts "loading #{path}..."
        load path
      end
      #puts "reloaded files:"
      #FILES.each {|ff| puts ff}
      #Workbox.setup
      #Contents.add_workbox_contents
      #Camera.setup
      #Contents.c = []
      TextureStick.init
      #puts "post-reload, workbox contents: #{Contents.c}"
    end

    def post_reload
      Gdx::app::postRunnable(ReloadRequest.new)
    end
  end
end

