package classes;

import hx.ws.SocketImpl;

class WebSocket {
	public var socket:SocketImpl;
	public var send:Dynamic;

	public function new(s:SocketImpl) {
		this.socket = s;
	}
}