class PlayerBullet < Sprite
  IMAGE = Image.load("images/player_bullet.png")
  attr_accessor :score

  def initialize(x, y, map)
    self.x, self.y = x, y
    self.image = IMAGE
    @map = map
    @speed = -5
    @score = 0
  end

  def update
    self.y += @speed
    vanish unless @map.validate_pos(self.x, self.y)
  end
end