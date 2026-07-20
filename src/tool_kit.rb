module TK
  class << self
    def mb; @@mb; end
    def sbatch; @@sbatch; end
    def font; @@font; end

    def init
      @@sbatch = SpriteBatch.new
      @@mb = ModelBatch.new
    end
  end
end
