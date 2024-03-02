class Map
  CHIP_SIZE = 32
  @@chips = [
    Image.load("map_chips/chip_0.png"),
    Image.load("map_chips/chip_1.png"),
    Image.load("map_chips/chip_2.png"),
    Image.load("map_chips/chip_3.png"),
    Image.load("map_chips/chip_4.png")
  ]

  def initialize(data_filename, mx, my, map_width, map_height, pos_x, pos_y)
    @map_data = load_map_data(data_filename)
    @map_width, @map_height = map_width, map_height
    @pos_x, @pos_y = pos_x, pos_y
    @mx, @my = mx, my

    @scrolled_x = 0
    @scrolled_y = 0
    @x_limit_left = @map_width / 2 + 1
    @x_limit_right = @map_data.first.size - @map_width / 2 - 1

    @view_width = @map_width * CHIP_SIZE
    @view_height = @map_height * CHIP_SIZE
    @rt_width = (@map_width + 2) * CHIP_SIZE
    @rt_height = (@map_height + 2) * CHIP_SIZE
    @view = RenderTarget.new(@view_width, @view_height, C_BLACK)
    @rt = RenderTarget.new(@rt_width, @rt_height, C_BLACK)
  end

  def update
    if @my > @map_height / 2
      @scrolled_y += 1
      if @scrolled_y >= CHIP_SIZE && @scrolled_y > 0
        @scrolled_y = 0
        @my -= 1
      end
    end

    @scrolled_x -= 1 if Input.x > 0 && @mx <= @x_limit_right
    @scrolled_x += 1 if Input.x < 0 && @mx >= @x_limit_left

    if @scrolled_x >= CHIP_SIZE && @scrolled_x > 0
      @scrolled_x = 0
      @mx -= 1
    end

    if @scrolled_x <= -CHIP_SIZE && @scrolled_x < 0
      @scrolled_x = 0
      @mx += 1
    end
  end

  def render
    render_chips
    @view.draw(-CHIP_SIZE + @scrolled_x, -CHIP_SIZE + @scrolled_y, @rt)
    Window.draw(@pos_x, @pos_y, @view)
  end

  # プレイヤーキャラの初期表示位置を返す
  def player_default_pos
    [
      @pos_x + (@view_width / 2) - (CHIP_SIZE / 2),
      @pos_y + @view_height - 100
    ]
  end

  # 敵キャラの初期出現位置をランダムに返す
  def random_pos
    [
      @pos_x + rand(@view_width - CHIP_SIZE),
      @pos_y + rand(@view_height / 2)
    ]
  end

  # 引数で指定された座標（nx, ny）がマップ表示領域内に収まっているかどうか判定する
  def validate_pos(nx, ny)
    @pos_x <= nx && nx <= (@pos_x + @view_width - CHIP_SIZE) &&
    @pos_y <= ny && ny <= (@pos_y + @view_height - CHIP_SIZE)
  end

  private

  def render_chips
    left_x = @mx - (@map_width / 2) - 1
    right_x = @mx + (@map_width / 2) + 1
    top_y = @my - (@map_height / 2) - 1
    bottom_y = @my + (@map_height / 2) + 1

    (top_y..bottom_y).each do |my|
      (left_x..right_x).each do |mx|
        if @map_data[my]
          chip_num = @map_data[my][mx]
          if chip_num
            rt_x = (mx - left_x) * CHIP_SIZE
            rt_y = (my - top_y) * CHIP_SIZE
            @rt.draw(rt_x, rt_y, @@chips[chip_num])
          else
            # 黒塗り
          end
        else
          # 黒塗り
        end
      end
    end
  end

  def load_map_data(data_filename)
    data = []
    File.open(data_filename) do |f|
      f.each_line do |line|
        data << line.chomp.split(/,/).map(&:to_i)
      end
    end
    data
  end
end