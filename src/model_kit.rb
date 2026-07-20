module MK
  class << self
    def builder; @@builder; end
    def batch; @@batch; end
    def loader; @@batch; end

    def init
      @@builder = ModelBuilder.new
      @@batch = ModelBatch.new
      @@loader = G3dModelLoader.new(UBJsonReader.new)
    end
  end
end
