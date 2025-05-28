package classes;

import classes.WebSocket;
import haxe.Timer;
import src.shared.Config;
import org.msgpack.MsgPack;
import src.shared.Player;
import hx.ws.SocketImpl;
import packets.OutgoingPackets;
import src.shared.Util;
import haxe.io.Bytes;

class Core {
	public var players:Array<Player>;

	private var wsPlayers:Map<Int, WebSocket>;
	private var playerIds:Array<Int>;
	private var nextId:Int;

	public function new() {
		this.players = [];
		this.wsPlayers = new Map<Int, WebSocket>();
		this.playerIds = [];
		this.nextId = 0;
	}

	public function newPlayer(name:String, ws:WebSocket) {
		var player = new Player(getAnId(), Util.getRandomRange(cast 0, cast Config.MapSize), Util.getRandomRange(cast 0, cast Config.MapSize));
		this.players.push(player);
		this.wsPlayers.set(player.sid, ws);

		Log.info('New player spawned into the game. Username: $name');

		GameServer.updateLoop();

		// send to the client their player info and sid
		this.sendTo(player.sid, OutgoingPackets.AddPlayer([true, Util.drainObject(player)]));
		// send to everyone else the new player
		this.sendToAllExcept(player.sid, OutgoingPackets.AddPlayer([false, Util.drainObject(player)]));
		// send to the client the older players
		final finalData:Array<Dynamic> = [];
		for (p in players) {
			if (p.sid != player.sid) {
				var drained:Array<Dynamic> = Util.drainObject(p);
				for (item in drained) {
					finalData.push(item);
				}
			}
		}
		this.sendTo(player.sid, OutgoingPackets.AddPlayer([false, finalData]));
	}

	private function getAnId():Int {
		if (this.playerIds.length > 0) {
			return playerIds.pop();
		}

		return nextId++;
	}

	private function freeId(id:Int):Void {
		playerIds.push(id);
	}

	public function removePlayerById(id:Int) {
		this.players.filter(player -> player.sid != id);
		this.wsPlayers.remove(id);

		Log.info('Player left the game. ID: $id');
	}

	public function sendTo(id:Int, type:OutgoingPackets) {
		final data:Dynamic = MsgPack.encode([type.getName(), type.getParameters()]);
		final ws = this.wsPlayers.get(id);

		try {
			ws.send(data);
		} catch (_) {
			// close websocket connection if we encounter an error
			ws.socket.close();
			this.removePlayerById(id);
		}
	}

	public function sendToAll(type:OutgoingPackets):Void {
		for (key => ws in this.wsPlayers) {
			this.sendTo(key, type);
		}
	}

	public function sendToAllExcept(id:Int, type:OutgoingPackets):Void {
		for (key => ws in this.wsPlayers) {
			if (key != id) {
				this.sendTo(key, type);
			}
		}
	}

	// UTILITIES FUNCTIONS:
	public function setMoveDir(wss:WebSocket, dir:Float) {
		for (player in players) {
			final socket = wsPlayers.get(player.sid);
			if (socket == wss) {
				player.moveDir = dir;
				//this.sendToAllExcept(player.sid, OutgoingPackets.Move([player.sid, dir]));
				break;
			}
		}
	}
}
