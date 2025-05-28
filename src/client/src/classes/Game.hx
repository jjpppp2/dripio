package classes;

import src.shared.Player;
import org.msgpack.MsgPack;
import haxe.Timer;
import packets.IncomingPackets;
import packets.OutgoingPackets;
import hx.ws.Types.MessageType;
import haxe.io.Bytes;
import hx.ws.Log;
import hx.ws.WebSocket;
import classes.PlayerManager;
import Log;

class Game {
	public var ws:WebSocket;
	public var playerManager:PlayerManager;
	public var timeSinceGameUpdate:Float;

	public function new() {
		// Log.mask = Log.INFO | Log.DEBUG | Log.DATA;
		this.ws = new WebSocket("ws://localhost:5000"); // ("wss://quiver-descriptive-sight.glitch.me");
		this.ws.binaryType = cast "arraybuffer";

		this.ws.onopen = this.onopen;
		this.ws.onmessage = this.onmessage;
		this.ws.onerror = this.onerror;
		this.ws.onclose = this.onclose;

		playerManager = new PlayerManager();

		Log.info("Initializing Bundle.");
	}

	private function onopen() {
		Log.info("Connected to game server.");

		sendPacket(OutgoingPackets.Spawn, ["ok"]);
	}

	private function onerror(error:String) {
		Log.error('Error while connecting to game server: $error');
		// alert('Error encountered while trying to connect to the game. Try reloading.');
	}

	private function onclose() {}

	private function onmessage(msg:MessageType) {
		switch (msg) {
			case BytesMessage(buffer):
				var bytesList = new haxe.io.BytesBuffer();
				while (buffer.available > 0) {
					var b = buffer.readByte();
					bytesList.addByte(b);
				}
				var bytes = bytesList.getBytes();
				var data = MsgPack.decode(bytes);

				final packet = parseIncomingPacket(cast data[0], cast data[1]);
				switch (packet) {
					case AddPlayer(data):
						final args = data[0];

						final chunkSize = 8;
						var i = 0;

						while (i < args[1].length) {
							final chunk = args[1].slice(i, i + chunkSize);

							final player = new Player(args[1][i], args[1][i + 1], args[1][i + 2]);
							playerManager.addPlayer(player, cast args[0]);
							trace(args[0]);

							i += chunkSize;
						}
					
					case UpdatePlayers(data):
						playerManager.updatePlayers(data[0]);

					case _: trace("useless");
				}

			case StrMessage(content):
				trace(content);
		}
	}
}
