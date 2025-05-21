package;

import hx.ws.Log;
import hx.ws.WebSocketServer;

class Server {
    static function main() {
        Log.mask = Log.INFO | Log.DEBUG | Log.DATA;
        var server = new WebSocketServer<ConnectionHandler>("localhost", 5000, 40);
        server.start();
    }
}