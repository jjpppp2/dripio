package packets;

import org.msgpack.MsgPack;

enum IncomingPackets {
    Spawn(data:Array<Dynamic>);
    ChatMessage(data:Array<Dynamic>);
    Aim(data:Array<Dynamic>);
    Move(data:Array<Dynamic>);
    Ping();
}

function parseIncomingPacket(name:String, args:Array<Dynamic>):IncomingPackets {
    switch (name) {
        case "Spawn": return IncomingPackets.Spawn(args);
        case "ChatMessage": return IncomingPackets.ChatMessage(args);
        case "Aim": return IncomingPackets.Aim(args);
        case "Move": return IncomingPackets.Move(args);
        case "Ping": return IncomingPackets.Ping;
        case _: throw "unknown packet";
    }
}

/*
function sendPacket(type:OutgoingPackets, args:Array<Dynamic>):Void {
    final data:Dynamic = [type.getName(), args]; // convert enum to string name
    final encoded:Bytes = MsgPack.encode(data);
    Main.instance.game.ws.send(encoded);
}
*/