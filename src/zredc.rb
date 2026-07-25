require 'pry-debugger-jruby'
require_relative 'java_imports'
require_relative 'colorz'
require_relative 'mux'


class MainGame < ApplicationAdapter
  @@app = nil

  def create
    Gdx::graphics::setContinuousRendering(false)
    $ww, $hh = Gdx::graphics::getWidth, Gdx::graphics::getHeight
    Gdx.input.setInputProcessor(ZomgMuxer.new)

  end

  def render
    Gdx::gl::gl_clear_color(0, 0.5, $blueval, 1)
    #Gdx::gl::gl_clear_color(0.5, 0.5, 0.5, 1)
    Gdx::gl::gl_clear(GL20::GL_COLOR_BUFFER_BIT | GL20::GL_DEPTH_BUFFER_BIT)
    puts "MainGame.render"
    end

  def dispose
  end
end
