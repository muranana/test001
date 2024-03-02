require_relative 'base'

module Scenes
  class StageBase < Base
    def initialize
      @score = 0
      @score_font = Font.new(32)
    end

    def play
      Window.draw(0, 0, @bg_image)
      @map.update
      @map.render
      draw_score
    end

    private

    def draw_score
      Window.draw_font(500, 10, "SCORE: #{@score}", @score_font, color: C_YELLOW)
    end

    def stage_completed?
      Input.key_push?(K_RETURN)
    end
  end
end