package src.shared;

import src.shared.Config;

class Player {
	public var sid:Int;
    public var x:Float;
    public var y:Float;
    public var lastX:Float;
    public var lastY:Float;
    public var visualX:Float;
    public var visualY:Float;

    private var health:Int;

	public function new(sid:Int, x:Float, y:Float) {
		this.sid = sid;
        this.x = x;
        this.y = y;
        this.lastX = x;
        this.lastY = y;
        this.visualX = x;
        this.visualY = y;

        this.health = Config.PlayerBaseHealth;
	}
}
