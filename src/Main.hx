class Main extends hxd.App {
    var player: Player;

    override public function init() {
        s2d.scaleMode = ScaleMode.LetterBox(640, 480);
        player = new Player(320, 0, s2d);
        new Solid(0, 280, 640, 200, s2d);
    }

    override public function update(dt: Float) {
        player.update(dt);
    }

    public static function main() {
        new Main();
    }
}