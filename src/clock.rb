require 'java'
require_relative 'utils'

module RedTimer
  DELAY = 100
  class << self
    def init
      @@timer = Timer.new
    end
    def flip(delay=0)
      @@timer.schedule(UpdateTask.new, delay)
    end
  end

  class UpdateTask < TimerTask
    def run
      puts "#{self.class} run"
      #$cruiser.update(Gdx::graphics::getDeltaTime)
      #update_task_render
      #request_render
    end
  end
end
