package shared;

import shared.Config;

class Player {
	public var sid:Int;
    private var x:Int;
    private var y:Int;
    private var health:Int;

	public function new(sid:Int, x:Int, y:Int) {
		this.sid = sid;
        this.x = x;
        this.y = y;

        this.health = Config.PlayerBaseHealth;
	}
}
