require_relative 'stage_base'

module Scenes
  # 第１ステージの進行管理用クラス
  class Stage1Scene < StageBase
    ENEMY_FOA = 200 # Frequency of appearance(出現頻度)

    # コンストラクタ
    def initialize
      # まずは親クラスであるStageBaseの同名メソッド（この場合はコンストラクタ）を実行する。
      super

      # シーン全体の背景画像を読み込む。
      @bg_image = Image.load("images/bg_stage1.png")

      # 第１ステージ用のマップオブジェクトを生成する。
      @map = Map.new("map_data/stage1.map", 10, 30, 10, 18, 160, 10)

      # プレイヤーオブジェクトを生成する。
      # ※ プレイヤーがマップ領域内だけで活動できるようにするため、マップオブジェクトを引き渡している点に留意。
      @player = Player.new(@map)

      # 敵キャラの集合を初期化する。
      @enemies = []
    end

    # １フレーム分の処理を進行させる
    def play
      # まずは親クラスであるStageBaseの同名メソッド（play）を実行する。
      super

      # 続いてプレイヤーオブジェクトの1フレーム分の挙動を更新する。
      @player.update
      # プレイヤーオブジェクトの画像を描画する。
      @player.draw

      # 敵キャラの追加処理を実行し、条件が合致すれば@enemiesに敵キャラオブジェクトを追加する。
      add_enemy

      # 敵キャラが放っている弾の全体集合を得る。
      enemy_bullets = @enemies.map{|e| e.bullets}.flatten

      # 各オブジェクトの集合（配列として実現）である@enemiesの各要素（個々の敵キャラオブジェクト）に対して「update」メソッドを実行する。
      Sprite.update(@enemies)
      Sprite.update(@player.bullets)
      Sprite.update(enemy_bullets)

      # プレイヤーの放った弾丸と敵キャラの当たり判定を一括処理する。
      Sprite.check(@player.bullets, @enemies)

      # 敵キャラの放った弾丸とプレイヤーキャラの当たり判定を一括処理する。
      Sprite.check(enemy_bullets, @player)

      # プレイヤーの放った弾丸からスコア計算を行う。
      @player.update_score
      @score += @player.score_per_frame
      @player.score_per_frame = 0

      # 各オブジェクトの集合から、「消滅済みフラグ」（vanished?）が立っているものを除去する（消滅したものを残していてもメモリの無駄なので）。
      @enemies.delete_if{|e| e.vanished? && e.bullets.empty? }
      @player.bullets.delete_if{|pb| pb.vanished? }

      #各オブジェクトの集合に属する個々のオブジェクトに対して「draw」メソッドを実行する。
      Sprite.draw(@enemies)
      Sprite.draw(@player.bullets)
      Sprite.draw(enemy_bullets)

      # この１フレームの実行でステージクリア条件が成立したか判定し、成立している場合は次のステージに画面遷移する。
      SceneManager.transition(:stage2) if stage_completed?
    end

    private

    # ゲーム空間に敵キャラオブジェクトを追加する
    def add_enemy
      # FOA（Frequency of appearance: 出現頻度）値を計算する。
      # ※ 計算式はサンプルゲームであるためごく簡易的なもの。
      foa = rand(ENEMY_FOA)
      return if foa % 10 != 0

      # 得られたfoaを7で割った剰余の値に応じて処理を分ける（7という数値自体に強い意味付けは無い）
      enemy_type = foa % 7
      case enemy_type
      when 0
        @enemies << Enemy1.new(@map)
      when 1
        @enemies << Enemy2.new(@map)
      end
    end
  end
end