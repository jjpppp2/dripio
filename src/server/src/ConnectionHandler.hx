package;

import hx.ws.SocketImpl;
import hx.ws.WebSocketHandler;
import hx.ws.Types;
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
			trace("ok");
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
