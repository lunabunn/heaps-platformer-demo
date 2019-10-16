import hxd.Key;
import h2d.Tile;
import h2d.Bitmap;

using Utilities.MathExtensions;

class Player extends Entity {
	inline public static var GRAVITY = 0.8;
	inline public static var ACCEL = 0.4;
    inline public static var DECCEL = 0.1;
	inline public static var SPEED = 4;
    inline public static var JUMP = -8;
    inline public static var AIRJUMPS = 2;

    var airJumpCount:Int = 0;

	public function new(x, y, parent) {
		super(new Bitmap(Tile.fromColor(0xffffff, 32, 32), parent), x, y, -16, -16, new Entity.Rect(this, -16, -16, 16, 16));
	}

	override public function update(dt:Float) {
        var ax = (Key.isDown(Key.RIGHT) ? ACCEL * dt * 60 : 0) - (Key.isDown(Key.LEFT) ? ACCEL * dt * 60 : 0);
        if (ax != 0)
		    dx = Math.absMin(SPEED * Math.sign(dx), dx + ax);
        else {
            var sign = Math.sign(dx);
            dx -= DECCEL * dt * 60 * sign;
            if (Math.sign(dx) != sign)
                dx = 0;
        }
        
		if (ry >= 0) {
            dy += GRAVITY * dt * 60;
            if (airJumpCount < AIRJUMPS && Key.isPressed(Key.UP)) {
                dy = JUMP;
                airJumpCount++;
            }
        } else {
            airJumpCount = 0;
            if (Key.isDown(Key.UP))
                dy = JUMP;
        }

		super.update(dt);
	}
}