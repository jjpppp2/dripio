package;

import js.Browser;
import classes.Render;
import classes.Game;
import packets.OutgoingPackets;
import js.html.AddEventListenerOptions;
import js.html.KeyboardEvent;

class Main {
    public static var instance:Main;
    public var game:Game;

    public function new() {
        trace("Bundle loaded.");

        game = new Game();
        final render = new Render();
    }

    public static function main() {
        instance = new Main();
    }
}
