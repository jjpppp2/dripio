package classes;

import packets.OutgoingPackets;
import src.shared.Util;
import sys.thread.Thread;

class GameServer {
	static var running:Bool;

	static public function start() {
        running = true;

		var updateThread = Thread.create(() -> {
			while (running) {
				updateLoop();
				Sys.sleep(0.110);
			}
		});
	}

	static public function updateLoop():Void {
		for (player in Server.core.players) {
			trace(player.sid, player.x, player.y);
			player.update();
		}

		handleNetwork();
	}

	static function handleNetwork():Void {
		final sanitizedPlayerData = Server.core.players.map(player -> {
			return {
				x: player.x,
				y: player.y,
				sid: player.sid
			}
		});

		final finalData:Array<Dynamic> = [];
		for (p in sanitizedPlayerData) {
			var drained:Array<Dynamic> = Util.drainObject(p);
			for (item in drained) {
				finalData.push(item);
			}
		}

		Server.core.sendToAll(OutgoingPackets.UpdatePlayers(finalData));
	}
}
