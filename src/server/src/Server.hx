package;

import classes.GameServer;
import hx.ws.Log;
import hx.ws.WebSocketServer;
import classes.Core;

class Server {
    public static var core:Core;

    static function main() {
        Log.mask = Log.INFO | Log.DEBUG | Log.DATA;
        var server = new WebSocketServer<ConnectionHandler>("localhost", 5000, 40);
        server.start();

        Server.core = new Core();
        GameServer.start();
    }
}