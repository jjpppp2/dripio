package packets;

import haxe.io.Bytes;
import org.msgpack.MsgPack;

enum OutgoingPackets {
	AddPlayer(data:Array<Dynamic>);
	AddBuilding(data:Array<Dynamic>);
    UpdatePlayers(data:Array<Dynamic>);
    Ping();
}

class PacketData {
	public var type: String;
	public var data: Map<String, Dynamic>;

	public function new() {}
}

/*
function decodePacket(packet: Bytes): IncomingPackets {
    final p: Dynamic = MsgPack.decode(packet);

    final type = Reflect.field(p, "type");
    final data = Reflect.field(p, "data");

    return switch (type) {
        case "AddPlayer": IncomingPackets.AddPlayer(data);
        case "AddBuilding": IncomingPackets.AddBuilding(data);
        case "UpdatePlayers": IncomingPackets.UpdatePlayers(data);
        case "Ping": IncomingPackets.Ping;
        case _: throw "unknown packet type";
    }
}
*/