class EnemyBullet < Sprite
  IMAGE = Image.load("images/enemy_bullet.png")

  def initialize(x, y, map)
    self.x, self.y = x, y
    self.image = IMAGE
    @map = map
    @speed = 5
  end

  def update
    self.y += @speed
    vanish unless @map.validate_pos(self.x, self.y)
  end
end