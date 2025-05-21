package shared;

import shared.Config;

class Player {
	public var sid:Int;
    private var x:Float;
    private var y:Float;
    private var health:Float;
    private var moveDir:Float;
    private var xVel:Float;
    private var yVel:Float;
    private var speed:Float;

	public function new(sid:Int, x:Float, y:Float) {
		this.sid = sid;
        this.x = x;
        this.y = y;
        this.speed = Config.PlayerBaseSpeed;

        this.health = cast Config.PlayerBaseHealth;
	}

    function update() {
        // update coordinates
        final xMovement = (this.moveDir ? Math.cos(this.moveDir ?? 0) : null);
        final yMovement = (this.moveDir ? Math.sin(this.moveDir ?? 0) : null);

        final distanceTraveled = Math.sqrt(xMovement * xMovement + yMovement * yMovement);

        // apply acceleration
        this.xVel += distanceTraveled * Math.cos(this.moveDir ?? 0);
        this.yVel += distanceTraveled * Math.sin(this.moveDir ?? 0);

        // apply deceleration
        if(this.xVel > 0.01) {
            this.xVel *= Config.PlayerDeceleration;
        } else this.xVel = 0.0;

        if(this.yVel > 0.01) {
            this.yVel *= Config.PlayerDeceleration;
        } else this.yVel = 0.0;
    }
}
