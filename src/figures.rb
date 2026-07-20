module Figures
  class << self
    def female
      jsonReader = UBJsonReader.new
      modelLoader = G3dModelLoader.new(jsonReader)
      model = modelLoader.loadModel(fh('models3d/humanoids/female.g3db'))
      inst = ModelInstance.new(model)
      # 23Q5 need to remove the emissive attribute to fix all-white models
      # https://github.com/libgdx/libgdx/issues/5529
      inst.materials.get(0).remove(ColorAttribute::Emissive)
      #ratio = 0.009
      ratio = 0.012
      xpad = -1.9
      ypad = -0
      zpad = -1.5
      inst.transform.scale(ratio, ratio, ratio)
      inst.transform.trn(xpad, ypad, zpad)
      return inst
    end
  end
end

