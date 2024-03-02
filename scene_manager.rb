class SceneManager
  @@scenes = {}
  @@current_scene_code = nil

  def self.load_scene(code, scene_instance)
    @@scenes[code.to_sym] = scene_instance
  end

  def self.transition(code)
    @@current_scene_code = code.to_sym
  end

  def self.play
    if @@current_scene_code && @@scenes.has_key?(@@current_scene_code)
      @@scenes[@@current_scene_code].play
    else
      raise "シーン名<#{@@current_scene_code}>はシーンとして登録されていません。"
    end
  end
end
