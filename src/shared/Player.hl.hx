package src.shared;

import src.shared.Config;
import Math;

class Player {
	public var sid:Int;

	public var x:Float;
	public var y:Float;

	private var health:Float;

	public var moveDir:Null<Float>;

	private var xVel:Float;
	private var yVel:Float;
	private var speed:Float;

	public var lastX:Float;
	public var lastY:Float;
	public var visualX:Float;
	public var visualY:Float;

	public function new(sid:Int, x:Float, y:Float) {
		this.sid = sid;
		this.x = x;
		this.y = y;
		this.speed = Config.PlayerBaseSpeed;
		this.moveDir = null;

		this.health = cast Config.PlayerBaseHealth;
	}

	public function update() {
		if (moveDir != null) {
			xVel = Math.cos(moveDir) * speed;
			yVel = Math.sin(moveDir) * speed;
		} else {
			// apply deceleration
			if (Math.abs(xVel) > 0.01) {
				xVel *= Config.PlayerDeceleration;
			} else
				xVel = 0.0;

			if (Math.abs(yVel) > 0.01) {
				yVel *= Config.PlayerDeceleration;
			} else
				yVel = 0.0;
		}

		// xVel *= (1000 / 110);
		// yVel *= (1000 / 110);

		x += xVel;
		y += yVel;

		x = Math.max(0, Math.min(x, Config.MapSize));
		y = Math.max(0, Math.min(y, Config.MapSize));
	}
}
