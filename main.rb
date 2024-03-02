require 'dxruby'

require_relative 'map'
require_relative 'scene_manager'
require_relative 'scenes/base'
require_relative 'scenes/stage_base'
require_relative 'scenes/opening_scene'
require_relative 'scenes/ending_scene'
require_relative 'scenes/stage1_scene'
require_relative 'scenes/stage2_scene'
require_relative 'characters/player'
require_relative 'characters/enemy1'
require_relative 'characters/enemy2'
require_relative 'characters/player_bullet'
require_relative 'characters/enemy_bullet'

Window.caption = "RubyCamp2024sp"
Window.width  = 800
Window.height = 600

SceneManager.load_scene(:opening, Scenes::OpeningScene.new)
SceneManager.load_scene(:ending, Scenes::EndingScene.new)
SceneManager.load_scene(:stage1, Scenes::Stage1Scene.new)
SceneManager.load_scene(:stage2, Scenes::Stage2Scene.new)
SceneManager.transition(:opening)

Window.loop do
  break if Input.key_push?(K_ESCAPE)
  SceneManager.play
end
