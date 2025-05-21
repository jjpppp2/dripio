package packets;

import org.msgpack.MsgPack;
import js.lib.Uint8Array;
import haxe.io.Bytes;

enum OutgoingPackets {
    Spawn;
    ChatMessage(data:Array<Dynamic>);
    Aim(data:Array<Dynamic>);
    Move(data:Array<Dynamic>);
    Ping();
}

function encodePacket(type:OutgoingPackets, args:Array<Dynamic>):Void {
    final data:Dynamic = [type.getName(), args]; // convert enum to string name
    final encoded:Bytes = MsgPack.encode(data);
    final uint8 = new Uint8Array(encoded.length);
    for (i in 0...encoded.length) {
        uint8[i] = encoded.get(i);
    }
    Main.instance.game.ws.send(uint8);
}