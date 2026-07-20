THICKNESS = 0.3
GRID_INCREMENT = 50
NUM_GRID_LINES = 7
GRID_START = NUM_GRID_LINES * GRID_INCREMENT / 2 * -1
GRID_LINE_LENGTH = 300
BEGINNING_L = GRID_LINE_LENGTH * -1

def horizontal_grid_stack
  # for a horiz grid,
  # constant x value, constant y value, dynamic z value
  coords = [0.0, GRID_START, GRID_START]
  #coords = [150.0, 0.0, 20.0]
  index = nil

  lenx = GRID_LINE_LENGTH
  leny = THICKNESS
  lenz = THICKNESS

  grid = []
  NUM_GRID_LINES.times do
    NUM_GRID_LINES.times do
      #puts "building grid line at #{coords}, index #{index}"
      xpos, ypos, zpos = coords[0], coords[1], coords[2]
      model = MK.builder.create_box(
        lenx, leny, lenz, Materials::GOLDENROD,
        VertexAttributes::Usage::Position | VertexAttributes::Usage::Normal
      )
      instance = ModelInstance.new(model)
      instance.transform.trn(Vector3.new(xpos, ypos, zpos))
      puts "created grid line at #{xpos} #{ypos} #{zpos}"
      grid << ModelInstance.new(instance)
      coords[2] += GRID_INCREMENT
    end
    coords[1] += GRID_INCREMENT
    coords[2] = GRID_START
  end
  return grid
end

def vertical_grid_stack
  # for a horiz grid,
  # constant x value, constant y value, dynamic z value
  coords = [GRID_START, 0.0, GRID_START]
  #coords = [150.0, 0.0, 20.0]
  index = nil

  lenx = THICKNESS
  leny = GRID_LINE_LENGTH
  lenz = THICKNESS

  grid = []
  NUM_GRID_LINES.times do
    NUM_GRID_LINES.times do
      puts "building grid line at #{coords}, index #{index}"
      xpos, ypos, zpos = coords[0], coords[1], coords[2]
      model = MK.builder.create_box(
        lenx, leny, lenz, Materials::CORAL,
        VertexAttributes::Usage::Position | VertexAttributes::Usage::Normal
      )
      instance = ModelInstance.new(model)
      instance.transform.trn(Vector3.new(xpos, ypos, zpos))
      puts "created grid line at #{xpos} #{ypos} #{zpos}"
      grid << ModelInstance.new(instance)
      coords[0] += GRID_INCREMENT
    end
    coords[2] += GRID_INCREMENT
    coords[0] = GRID_START
  end
  return grid
end


def setup_grid_by_axis(which_axis, color)
  material = Material.new(ColorAttribute.createDiffuse(color))
  coords = [0.0, 0.0, 0.0]
  index = nil
  case which_axis
  when :x
    indexa = 0
    indexb = 1
    lenx = THICKNESS
    leny = GRID_LINE_LENGTH
    lenz = THICKNESS
  when :y
    indexa = 1
    indexb = 2
    lenx = THICKNESS
    leny = THICKNESS
    lenz = GRID_LINE_LENGTH
  when :z
    indexa = 2
    indexb = 3
    lenx = GRID_LINE_LENGTH
    leny = THICKNESS
    lenz = THICKNESS
  end
  coords[indexa] = BEGINNING_L
  coords[indexb] = BEGINNING_L
  out = []
  NUM_GRID_LINES.times do
    NUM_GRID_LINES.times do
      puts "building grid line at #{coords}, index #{index}"
      xpos, ypos, zpos = coords[0], coords[1], coords[2]
      model = MK.builder.create_box(
        lenx, leny, lenz, material,
        VertexAttributes::Usage::Position | VertexAttributes::Usage::Normal
      )
      instance = ModelInstance.new(model)
      instance.transform.trn(Vector3.new(xpos, ypos, zpos))
      if which_axis == :y
        rotm = Vector3.new(1,0,0)
        instance.transform.setToRotation(rotm, 90)
      end
      puts "created grid line at #{xpos} #{ypos} #{zpos}"
      out << ModelInstance.new(instance)
      coords[indexb] += GRID_INCREMENT
    end
  coords[indexa] += GRID_INCREMENT
  end
  return out
end


def setup_3d_grid
  @grid_lines = []
  #xgrid = setup_grid_by_axis(:x, Color::CORAL)
  #@grid_lines += xgrid
  #ygrid = setup_grid_by_axis(:y, Color::MAROON)
  #@grid_lines += ygrid
  #zgrid = setup_grid_by_axis(:z, Color::GOLDENROD)
  #@grid_lines += zgrid
  #proto = setup_grid_proto
  #@grid_lines += horizontal_grid_stack
  #@grid_lines += vertical_grid_stack
end

def setup_axes
  width = 0.35
  material = Material.new(ColorAttribute.createDiffuse(Color::RED))
  model = MK.builder.create_box(300.0, width, width, material, VertexAttributes::Usage::Position | VertexAttributes::Usage::Normal)
  @xaxisbox = ModelInstance.new(model)

  material = Material.new(ColorAttribute.createDiffuse(Color::GREEN))
  #material = Material.new(ColorAttribute.createDiffuse(Color::RED))
  model = MK.builder.create_box(width, 300.0, width, material, VertexAttributes::Usage::Position | VertexAttributes::Usage::Normal)
  @yaxisbox = ModelInstance.new(model)

  #material = Material.new(ColorAttribute.createDiffuse(Color::RED))
  material = Material.new(ColorAttribute.createDiffuse(Color::BLUE))
  model = MK.builder.create_box(width, width, 300.0, material, VertexAttributes::Usage::Position | VertexAttributes::Usage::Normal)
  @zaxisbox = ModelInstance.new(model)
end
