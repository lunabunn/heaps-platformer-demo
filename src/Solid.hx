import h2d.Tile;
import h2d.Bitmap;

class Solid extends Entity {
    public static var solids = new Array<Solid>();

    public function new(x, y, w, h, parent) {
        super(new Bitmap(Tile.fromColor(0xffffff, w, h), parent), x, y, new Entity.Rect(this, 0, 0, w, h));
        solids.push(this);
    }
}