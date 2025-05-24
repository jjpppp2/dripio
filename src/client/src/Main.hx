package client;

import src.client.src.classes.Render;
import src.client.src.classes.Game;

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
