module Materials
  CORAL = Material.new(ColorAttribute.createDiffuse(Color::CORAL))
  #GRAY  = Material.new(ColorAttribute.createDiffuse(Color::GRAY))
  GRAY  = Material.new(ColorAttribute.createDiffuse(Color.new(0.6, 0.6, 0.6, 0.5)))
  #DARK_GRAY = Material.new(ColorAttribute.createDiffuse(Color::DARK_GRAY))
  DARK_GRAY  = Material.new(ColorAttribute.createDiffuse(Color.new(0.8, 0.8, 0.8, 0.2)))
  GOLDENROD = Material.new(ColorAttribute.createDiffuse(Color::GOLDENROD))
  OLIVE = Material.new(ColorAttribute.createDiffuse(Color::OLIVE))
  MAROON = Material.new(ColorAttribute.createDiffuse(Color::MAROON))
  CYAN = Material.new(ColorAttribute.createDiffuse(Color::CYAN))
  NAVY = Material.new(ColorAttribute.createDiffuse(Color::NAVY))
  VIOLET = Material.new(ColorAttribute.createDiffuse(Color::VIOLET))
  WALL = Material.new(ColorAttribute.createDiffuse(Color.new(0.5, 0.5, 0.5, 0.01)))
  WALL_BLACK  = Material.new(ColorAttribute.createDiffuse(Color.new(0, 0, 0, 1)))
  DOOR  = Material.new(ColorAttribute.createDiffuse(Color::TEAL))
end

def setup_texture_material(texture)
  $tmat = Material.new(Attribute.createDiffuse(Color::VIOLET))
end

