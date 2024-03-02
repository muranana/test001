require_relative 'base'

module Scenes
  class OpeningScene < Base
    def initialize
      @bg_image = Image.load("images/bg_opening.png")
      @title_font = Font.new(48)
      @label_font = Font.new(24)
    end

    def play
      Window.draw(0, 0, @bg_image)
      draw_font_center(150, "RubyCamp 2024sp Sample Game", @title_font, color: C_YELLOW)
      draw_font_center(400, "Push space key to start", @label_font, color: C_RED)

      SceneManager.transition(:stage1) if Input.key_push?(K_SPACE)
    end
  end
end