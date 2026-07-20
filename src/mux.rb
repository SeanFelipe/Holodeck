require 'pry'

class ZomgMuxer < InputAdapter

  INCREMENT = 10
  TI = 15
  ZINC = 50.0

  def keyDown(keycode)
    $keydown = keycode
    puts "keyDown: #{keycode}"

    # quit - load - restart
    case keycode
    when Input::Keys::B
      binding.pry
    when Input::Keys::L
      load './zredc.rb'
    when Input::Keys::R
      #`touch ../is_running/desktop`
      #Gdx.app.exit
      $redc.rreload
    when Input::Keys::Q
      Gdx.app.exit
    end

    return true
  end
end
