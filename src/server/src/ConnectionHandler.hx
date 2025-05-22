package;

import hx.ws.SocketImpl;
import hx.ws.WebSocketHandler;
import hx.ws.Types;
import haxe.io.Bytes;
import org.msgpack.MsgPack;

class ConnectionHandler extends WebSocketHandler {
	public function new(s:SocketImpl) {
		super(s);

		onopen = function() {
			trace(id + ". OPEN");
		}

		onclose = function() {
			trace(id + ". CLOSE");
		}

		onmessage = function(message:MessageType) {
			switch (message) {
				case BytesMessage(buffer):

					// figure out way to simplify later (no clue what its doing)
					var bytesList = new haxe.io.BytesBuffer();
					while (buffer.available > 0) {
						var b = buffer.readByte();
						bytesList.addByte(b);
					}
					var bytes = bytesList.getBytes();
					var data = MsgPack.decode(bytes);

					trace(data);
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
