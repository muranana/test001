class Enemy1 < Sprite
  BULLET_FOA = 20
  IMAGE = Image.load("images/enemy1.png")
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

    # 弾丸発射（ランダム）
    shoot
    @bullets.delete_if{|b| b.vanished? }
  end

  def hit(player_bullet)
    self.vanish
    player_bullet.score += 1
    player_bullet.vanish
  end

  private

  def shoot
    r = rand(BULLET_FOA)
    if r == 0
      @bullets << EnemyBullet.new(self.x, self.y + Map::CHIP_SIZE, @map)
    end
  end
end