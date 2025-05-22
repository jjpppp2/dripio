package classes;

import hx.ws.Types.MessageType;
import packets.OutgoingPackets;
import packets.IncomingPackets.decodePacket;
import haxe.io.Bytes;
import haxe.io.Bytes;
import hx.ws.Log;
import hx.ws.WebSocket;

class Game {
	public var ws:WebSocket;
	// public var players:Array<Player>;
	// public var myPlayer:Player;
	public var timeSinceGameUpdate:Float;

	public function new() {
		Log.mask = Log.INFO | Log.DEBUG | Log.DATA;
		this.ws = new WebSocket("ws://localhost:5000"); // ("wss://quiver-descriptive-sight.glitch.me");
		this.ws.binaryType = cast "arraybuffer";

		this.ws.onopen = this.onopen;
		this.ws.onmessage = this.onmessage;
		this.ws.onerror = this.onerror;
		this.ws.onclose = this.onclose;
	}

	private function onopen() {
		trace("WS OPENED");

		encodePacket(OutgoingPackets.Spawn, ["ok"]);
		encodePacket(OutgoingPackets.Spawn, ["ok"]);
		encodePacket(OutgoingPackets.Spawn, ["ok"]);
		encodePacket(OutgoingPackets.Spawn, ["ok"]);
		encodePacket(OutgoingPackets.Spawn, ["ok"]);
	}

	private function onerror(error:String) {
		//#if js
		//alert('Error encountered while trying to connect to the game. Try reloading.');
		//#end
	}

	private function onclose() {}

	private function onmessage(msg:MessageType) {
		switch (msg) {
			case BytesMessage(data):
				final bytes:haxe.io.Bytes = cast data;
				final args = decodePacket(bytes);

				switch (args) {
					case Ping:
						this.Packets_Ping();
					case _:
						trace("unknown packet inbound!!");
				}
			
			case StrMessage(text):
				trace("waht????" + text);
		}
		
	}

	private function Packets_Ping() {
		trace("WOAHHHHHHHHH PING PACKET SO COOL!!!");
	}
}
