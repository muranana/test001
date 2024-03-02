require_relative 'stage_base'

module Scenes
  class Stage2Scene < StageBase
    def initialize
      super
      @bg_image = Image.load("images/bg_stage2.png")
      @map = Map.new("map_data/stage2.map", 10, 30, 10, 18, 160, 10)
    end

    def play
      super

      SceneManager.transition(:ending) if stage_completed?
    end
  end
end