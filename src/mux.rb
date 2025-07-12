class InputMuxer < InputAdapter
  def keyDown(keycode)
    case keycode
    when Input::Keys::Q
      Gdx.app.exit
    end
  end
end

