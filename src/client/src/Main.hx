package;

import classes.Render;
import classes.Game;

class Main {
    public static var instance:Main;
    public var game:Game;
    public var renderer:Render;

    public function new() {
        trace("Bundle loaded.");

        game = new Game();
        renderer = new Render();
    }

    public static function main() {
        instance = new Main();
    }
}
