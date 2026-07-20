require 'java'
java_import java.lang.Runnable

module Reloader
  FILES =  [
   #"./desktop.rb",
   "./colorz.rb",
   "./zredc.rb",
  ]

  BASE_DIR = Dir.pwd

  class ReloadRequest
    include Runnable
    def run
      $redc.render
      puts "ReloadRequest.run"
    end
  end

  class << self
    def reload(from_listener=false)
      basedir = BASE_DIR
      basedir += '/src' if from_listener
      puts "start reload from dir: #{basedir}"
      $VERBOSE = nil
      FILES.each do |ff|
        path = "#{basedir}/#{ff}"
        print "loading #{path}..."
        result = load path
        print "#{result}\n"
        #puts "load #{path} complete."
        #binding.pry
      end
      puts "reloaded files:"
      FILES.each {|ff| puts ff}
      post_reload
    end

    def post_reload
      puts "posting render request..."
      Gdx::app::postRunnable(ReloadRequest.new)
    end
  end
end
