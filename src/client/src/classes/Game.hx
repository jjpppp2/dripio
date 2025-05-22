package classes;

import packets.OutgoingPackets;
import js.html.ErrorEvent;
import packets.IncomingPackets.decodePacket;
import haxe.io.Bytes;
import js.lib.ArrayBuffer;
import js.html.MessageEvent;
import js.html.WebSocket;
import js.Browser.alert;

class Game {
	public var ws:WebSocket;
	// public var players:Array<Player>;
	// public var myPlayer:Player;
	public final document:Any;
	public var timeSinceGameUpdate:Float;

	public function new() {
		this.ws = new WebSocket("ws://localhost:5000"); // ("wss://quiver-descriptive-sight.glitch.me");
		this.ws.binaryType = cast "arraybuffer";

		this.ws.onopen = this.onopen;
		this.ws.onmessage = this.onmessage;
		this.ws.onerror = this.onerror;
		this.ws.onclose = this.onclose;

		this.document = js.Browser.document;
	}

	private function onopen() {
		trace("WS OPENED");

		encodePacket(OutgoingPackets.Spawn, ["ok"]);
		encodePacket(OutgoingPackets.Spawn, ["ok"]);
		encodePacket(OutgoingPackets.Spawn, ["ok"]);
		encodePacket(OutgoingPackets.Spawn, ["ok"]);
		encodePacket(OutgoingPackets.Spawn, ["ok"]);
	}

	private function onerror(error:ErrorEvent) {
		alert('Error encountered while trying to connect to the game. Try reloading.');
	}

	private function onclose() {}

	private function onmessage(e:MessageEvent) {
		final buffer:ArrayBuffer = cast e.data;
		final bytes = Bytes.ofData(buffer);
		final args = decodePacket(bytes);

		switch (args) {
			case Ping:
				this.Packets_Ping();
			case _:
				trace("unknown packet inbound!!");
		}
	}

	private function Packets_Ping() {
		trace("WOAHHHHHHHHH PING PACKET SO COOL!!!");
	}
}
