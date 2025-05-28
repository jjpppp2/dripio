package packets;

import haxe.io.Bytes;
import org.msgpack.MsgPack;

enum IncomingPackets {
	AddPlayer(data:Array<Dynamic>);
	AddBuilding(data:Array<Dynamic>);
	UpdatePlayers(data:Array<Dynamic>);
	Ping;
}

class PacketData {
	public var type:String;
	public var data:Map<String, Dynamic>;

	public function new() {}
}

function parseIncomingPacket(type:String, data:Array<Dynamic>):IncomingPackets {
	switch (type) {
		case "AddPlayer": return IncomingPackets.AddPlayer(data);
		case "AddBuilding": return IncomingPackets.AddBuilding(data);
		case "UpdatePlayers": return IncomingPackets.UpdatePlayers(data);
		case "Ping": return IncomingPackets.Ping;
		case _:
			throw "unknown packet type";
	}
}
