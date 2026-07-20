module TK
  class << self
    def batch; @@batch; end

    def init
      @@batch = SpriteBatch.new
    end
  end
end
