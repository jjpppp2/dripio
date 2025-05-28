package packets;

import org.msgpack.MsgPack;
import haxe.io.Bytes;

enum OutgoingPackets {
    Spawn;
    ChatMessage(data:Array<Dynamic>);
    Aim(data:Array<Dynamic>);
    Move;
    Ping();
}

function sendPacket(type:OutgoingPackets, args:Array<Dynamic>):Void {
    final data:Dynamic = [type.getName(), args]; // convert enum to string name
    final encoded:Bytes = MsgPack.encode(data);
    Main.instance.game.ws.send(encoded);
}
