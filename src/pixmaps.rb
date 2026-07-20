=begin
def setup_pixmap
  pmap = Pixmap.new(16,16,Pixmap::Format::RGBA8888)
  pmap.setColor(Color::WHITE);
  pmap.fill();

  pmap.setColor(Color::RED);
  pmap.fillCircle(8, 8, 4);
  pmap.setColor(Color::WHITE);
  pmap.fill();

  pmap.setColor(Color::RED);
  pmap.fillCircle(8, 8, 4);
  $protoTexture = Texture.new(pmap)
  pmap.dispose
end
=end

def setup_pixmap
  dim = 32
  half = dim / 2
  qtr = dim / 4
  three_qtrs = qtr * 3
  pmap = Pixmap.new(32,32,Pixmap::Format::RGBA8888)
  pmap.setColor(Color::WHITE);
  pmap.fill();

  pmap.setColor(Color::RED);
  #pmap.fillCircle(16, 16, 4);
  pmap.fillTriangle(5,half, three_qtrs,qtr, three_qtrs,three_qtrs)

  $protoTexture = Texture.new(pmap)
  pmap.dispose

  #pmap.setColor(Color::WHITE);
  #pmap.fill();
  #pmap.setColor(Color::RED);
  #pmap.fillCircle(8, 8, 4);
end
