module Scenes
  class Base
    def play
      raise "override me."
    end

    # 指定されたY座標にテキストを中央寄せで表示する
    def draw_font_center(pos_y, text, font, options = {})
      pos_x = (Window.width - font.get_width(text)) / 2
      Window.draw_font(pos_x, pos_y, text, font, options)
    end
  end
end