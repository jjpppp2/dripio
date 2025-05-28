package src.shared;

import Math;

class Util {
	public static function getRandomRange(min:Float, max:Float):Float {
		return Math.random() * (max - min + 1) + min;
	}
    
    public static function getDistance(x1, y1, x2, y2):Float {
        final dx = x2 - x1;
        final dy = y2 - y1;

        return Math.sqrt(dx * dx - dy * dy);
    }

    public static function getDirection(x1, y1, x2, y2):Float {
        return Math.atan2(y2 - y1, x2 - x1);
    }

    public static function drainObject(obj:Dynamic):Array<Dynamic> {
        var values = [];

        for (field in Reflect.fields(obj)) {
            values.push(Reflect.field(obj, field));
        }

        return values;
    }
}
