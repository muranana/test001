require_relative 'base'

module Scenes
  class EndingScene < Base
    def initialize
      @bg_image = Image.load("images/bg_ending.png")
      @title_font = Font.new(64)
    end

    def play
      Window.draw(0, 0, @bg_image)
      draw_font_center(270, "Congratulations!", @title_font, color: C_BLUE)
    end
  end
end