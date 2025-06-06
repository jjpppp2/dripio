package;

import packets.OutgoingPackets;
import hx.ws.SocketImpl;
import hx.ws.WebSocketHandler;
import hx.ws.Types;
import haxe.io.Bytes;
import org.msgpack.MsgPack;
import packets.IncomingPackets;
import classes.WebSocket;

class ConnectionHandler extends WebSocketHandler {
	public function new(s:SocketImpl) {
		super(s);
		var wss = new WebSocket(s);
		wss.send = send;

		onopen = function() {
			trace(id + ". OPEN");

			//send(MsgPack.encode([OutgoingPackets.Ping.getName()]));
		}

		onclose = function() {
			trace(id + ". CLOSE");
		}

		onmessage = function(message:MessageType) {
			switch (message) {
				case BytesMessage(buffer):
					// figure out way to simplify later (no clue what its doing)
					/*var bytesList = new haxe.io.BytesBuffer();
					while (buffer.available > 0) {
						var b = buffer.readByte();
						bytesList.addByte(b);
					}
					var bytes = bytesList.getBytes();*/
					var data = MsgPack.decode(buffer.readAllAvailableBytes());

					final packet = parseIncomingPacket(cast data[0], cast data[1]);
					switch (packet) {
						case Spawn(data):
							Server.core.newPlayer(data[0], wss);
						
						case Move(data):
							Server.core.setMoveDir(wss, data[0]);
						
						case _:
							trace("useless");
					}
				case StrMessage(content):
					trace("what?? " + content);
			}
			/*
				switch (message) {
					case BytesMessage(content):
						trace(content.readAllAvailableBytes());
					case StrMessage(content):
						var str = "echo: " + content;
						trace(str);
						send(str);
			}*/
		}

		onerror = function(error) {
			trace(id + ". ERROR: " + error);
		}
	}
}
