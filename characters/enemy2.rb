class Enemy2 < Sprite
  IMAGE = Image.load("images/enemy2.png")
  attr_reader :bullets

  def initialize(map)
    @map = map
    self.x, self.y = @map.random_pos
    self.image = IMAGE
    @bullets = []
  end

  def update
    new_x = self.x + (rand(3) - 1) * 2
    new_y = self.y + (rand(3) - 1) * 2
    if @map.validate_pos(new_x, new_y)
      self.x, self.y = new_x, new_y
    else
      vanish
    end
  end

  def hit(player_bullet)
    self.vanish
    player_bullet.score += 1
    player_bullet.vanish
  end
end