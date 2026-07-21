class ZomgMuxer < InputAdapter

  def keyDown(keycode)
    $keydown = keycode
    puts "keyDown: #{keycode}"

    # quit
    case keycode
    when Input::Keys::Q
      Gdx.app.exit
    end

    return true
  end
end
