import h2d.Bitmap;

using Utilities.MathExtensions;

class Entity {
	public var x:Float;
	public var y:Float;
    public var ox:Float;
    public var oy:Float;
	public var dx:Float = 0;
	public var dy:Float = 0;
	public var col:Rect;
	public var bitmap:Bitmap;

    var rx:Float = 0;
    var ry:Float = 0;

	public function new(bitmap:Bitmap, x:Float = 0, y:Float = 0, ox:Float = 0, oy:Float = 0, col:Rect = null) {
		this.bitmap = bitmap;
        bitmap.x = x + ox;
		bitmap.y = y + oy;
		this.x = x;
		this.y = y;
        this.ox = ox;
        this.oy = oy;
		if ((this.col = col) == null)
			this.col = new Rect(this);
	}

	public function update(dt:Float) {
		rx = 0;
        x += dx * dt * 60;
        for (solid in Solid.solids) {
            var xr = col.getResolveDeltaX(solid.col);
            if (xr != 0) {
                x += xr;
                rx += xr;
            }
        }

        ry = 0;
        y += dy * dt * 60;
        for (solid in Solid.solids) {
            var yr = col.getResolveDeltaY(solid.col);
            if (yr != 0) {
                y += yr;
                ry += yr;
            }
        }

		bitmap.x = x + ox;
		bitmap.y = y + oy;
	}
}

class Rect {
	public var x1:Float;
    public var y1:Float;
	public var x2:Float;
	public var y2:Float;
    public var entity:Entity;

	public function new(entity:Entity, x1:Float = 0, y1:Float = 0, x2:Float = 1, y2:Float = 1) {
		this.entity = entity;
        this.x1 = x1;
        this.y1 = y1;
        this.x2 = x2;
        this.y2 = y2;
	}

	public function getResolveDeltaX(rect:Rect):Float {
		if (entity.x + x1 >= rect.entity.x + rect.x2 || entity.x + x2 <= rect.entity.x + rect.x1 || entity.y + y1 >= rect.entity.y + rect.y2 || entity.y + y2 <= rect.entity.y + rect.y1)
            return 0;
        else
            return Math.absMin(rect.entity.x + rect.x1 - entity.x - x2, rect.entity.x + rect.x2 - entity.x - x1);
	}

    public function getResolveDeltaY(rect:Rect):Float {
		if (entity.x + x1 >= rect.entity.x + rect.x2 || entity.x + x2 <= rect.entity.x + rect.x1 || entity.y + y1 >= rect.entity.y + rect.y2 || entity.y + y2 <= rect.entity.y + rect.y1)
            return 0;
        else
            return Math.absMin(rect.entity.y + rect.y1 - entity.y - y2, rect.entity.y + rect.y2 - entity.y - y1);
	}
}