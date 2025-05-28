package classes;

import haxe.Timer;
import packets.OutgoingPackets;
import src.shared.Player;
import Main;

class PlayerManager {
	public var players:Array<Player>;
	public var myPlayer:Player;

	public function new() {
		players = [];
	}

	public function addPlayer(player:Player, isMine:Bool) {
		players.push(player);

		if (isMine) {
			myPlayer = player;
		}
	}

	public function updatePlayers(data:Array<Dynamic>) {
		var i = 0;
		while (i < data.length) {
			final player = getPlayerBySid(data[i]);

			if (player != null) {
				player.lastX = player.x;
				player.lastY = player.y;
				player.x = data[i + 1];
				player.y = data[i + 2];
			}

			i += 3;
		}

		Main.instance.renderer.timeSinceGameUpdate = 0.0; //Timer.stamp() * 1000;

		// update our movement
		sendPacket(OutgoingPackets.Move, [Main.instance.renderer.moveDir]);
		//trace(Main.instance.renderer.moveDir);
	}

	public function getPlayerBySid(sid:Int):Player {
		return players.filter(p -> p.sid == sid)[0];
	}
}
