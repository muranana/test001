class Player < Sprite
  IMAGE = Image.load("images/player.png")
  attr_reader :bullets
  attr_accessor :score_per_frame

  def initialize(map)
    @map = map
    self.x, self.y = @map.player_default_pos
    self.image = IMAGE
    @bullets = []
    @score_per_frame = 0
  end

  def update
    new_x = self.x + Input.x
    new_y = self.y + Input.y
    if @map.validate_pos(new_x, new_y)
      self.x, self.y = new_x, new_y
    end

    if Input.key_push?(K_SPACE)
      self.bullets << PlayerBullet.new(self.x, self.y - Map::CHIP_SIZE, @map)
    end
  end

  def update_score
    bullets.each do |b|
      if b.vanished?
        @score_per_frame += b.score
      end
    end
  end

  def hit(enemy_bullet)
    @score_per_frame -= 1 unless enemy_bullet.vanished?
    enemy_bullet.vanish
  end
end