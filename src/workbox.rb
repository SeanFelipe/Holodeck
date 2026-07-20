module Workbox

  FLOOR_THICKNESS = 1
  # because shapes are deployed with their *center*
  # at the desired coordinates, we need to offset Y in this odd way
  # to have y=0 be the top of the floor
  Y_OFFSET = FLOOR_THICKNESS / 2.0

  class << self
    @@w = Array.new
    def w; @@w; end

    @@gradations = Array.new
    def gradations; @@gradations; end

    @@showg = true
    def show_gradations; @@showg; end
    def toggle_gradations; @@showg == ! @@showg; end

    def setup
      length = Dims::WORKBOX_SIZE
      #zdepth = 500
      #thickness = length / 25
      thickness = length / 100.0
      ln, t = length, thickness
      half = length / 2

      box_lines = {
        top: [[0, ln, 0], [ln, t, t]],
        top_back: [[0, ln, -length], [ln, t, t]],
        bottom: [[0, 0, 0], [ln, t, t]],
        bottom_back: [[0, 0, -length], [ln, t, t]],

        left: [[-half, half, 0], [t, ln, t]],
        left_back: [[-half, half, -length], [t, ln, t]],
        right: [[half, half, 0], [t, ln, t]],
        right_back: [[half, half, -length], [t, ln, t]],

        spline_tl: [[-half, ln, -half], [t, t, ln]],
        spline_bl: [[-half, 0, -half], [t, t, ln]],
        spline_tr: [[half, ln, -half], [t, t, ln]],
        spline_br: [[half, 0, -half], [t, t, ln]],
      }

      box_lines.values.each do |d|
        pos = d.first
        dims = d.last

        xpos = pos.first
        ypos  = pos[1] - Y_OFFSET
        zpos = pos.last

        lenx = dims.first
        leny = dims[1]
        lenz = dims.last

        model = MK.builder.create_box(
          lenx, leny, lenz, Materials::CORAL,
          VertexAttributes::Usage::Position | VertexAttributes::Usage::Normal
        )
        instance = ModelInstance.new(model)
        instance.transform.trn(Vector3.new(xpos, ypos, zpos))
        #puts "created workbox line at #{xpos} #{ypos} #{zpos}"
        @@w << instance
      end
      add_workbox_gradations
      setup_floor
    end


    def add_workbox_gradations
      num_gradations = 10
      interval = Dims::WORKBOX_SIZE / num_gradations

      xlen = interval / 24
      #ylen = interval / 16
      ylen = interval / 24
      zlen = interval / 24

      full = Dims::WORKBOX_SIZE
      half = full / 2
      xpos = -half
      #ypos = -full * 2
      ystart = 0
      ypad = ylen / 2
      ypos = ystart + ypad
      zpos = 0

      num_gradations.times.each do |ii|
        model = MK.builder.create_box(
          xlen, ylen, zlen, Materials::CORAL,
          VertexAttributes::Usage::Position | VertexAttributes::Usage::Normal
        )
        instance = ModelInstance.new(model)
        instance.transform.trn(Vector3.new(xpos, ypos, zpos))
        #puts "adding gradation to workbox: #{xpos} #{ypos} #{zpos}"
        @@gradations << instance
        xpos += interval
      end
    end

=begin
def setup_tiles
  length = Dims::WORKBOX_SIZE / 2
  height = length / 10

  xpos = 0
  ypos = - Dims::WORKBOX_SIZE / 2
  zpos = - Dims::WORKBOX_SIZE / 2

  model = MK.builder.create_box(
    length, height, length, $olive,
    VertexAttributes::Usage::Position | VertexAttributes::Usage::Normal
  )
  instance = ModelInstance.new(model)
  instance.transform.trn(Vector3.new(xpos, ypos, zpos))
  @@w << instance
end
=end

    def setup_floor
      bh = FLOOR_THICKNESS
      bw = Dims::FULL
      bd = bw
      xpos = 0
      ypos = - Y_OFFSET
      zpos = - Dims::WORKBOX_SIZE / 2
      navymodel = MK.builder.create_box(bw, bh, bd, Materials::NAVY, VertexAttributes::Usage::Position | VertexAttributes::Usage::Normal)
      cyanmodel = MK.builder.create_box(bw, bh, bd, Materials::CYAN, VertexAttributes::Usage::Position | VertexAttributes::Usage::Normal)
      boxCyan = ModelInstance.new(cyanmodel)
      boxNavy = ModelInstance.new(navymodel)
      boxCyan.transform.trn(Vector3.new(xpos, ypos, zpos))
      boxNavy.transform.trn(Vector3.new(xpos, ypos, zpos))
      #@@w << boxCyan
      @@w << boxNavy
    end
  end
end
