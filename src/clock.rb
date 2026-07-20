require_relative 'all'
require 'java'

class UpdateTask < TimerTask
  def initialize; puts "#{self.class} initialize"; end
  def run
    #puts "#{self.class} run"
    #$meshes.update
  end
end

class RedTimer < Timer
  DELAY = 100
  #DELAY = 1000
  def initialize
    super
    self.scheduleAtFixedRate(UpdateTask.new, 0, DELAY)
  end
end
