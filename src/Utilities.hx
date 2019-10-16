class MathExtensions {
	public static function absMin(cl:Class<Math>, a:Float, b:Float) {
		if (Math.abs(a) < Math.abs(b))
			return a;
		return b;
	}

	public static function sign(cl:Class<Math>, x:Float) {
		return x / Math.abs(x);
	}
}