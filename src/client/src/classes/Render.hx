package classes;

import haxe.Timer;
import hxd.Window;
import src.shared.Config;
import hxd.App;
import h2d.Graphics;
import hxd.Key;
import h2d.Text;
import haxe.ui.Toolkit;
import haxe.ui.core.Screen;
import haxe.ui.containers.VBox;
import haxe.ui.components.Button;

class Render extends App {
	private var camera:Camera;
	private var delta:Float;
	private var lastFrameCall:Float;
	private var xOffset:Float;
	private var yOffset:Float;
	private var zoom:Float;

	public var moveDir:Null<Float>;

	private var background:Graphics;
	private var grid:Graphics;
	private var playersC:Graphics;

	private var font:Any;
	private var fpsText:Text;

	public var timeSinceGameUpdate:Float;

	public function new() {
		super();
		this.camera = new Camera();
	}

	override function init() {
		this.background = new Graphics(s2d);
		this.renderBackground();

		this.grid = new Graphics(s2d);
		this.renderGridLines();

		this.playersC = new Graphics(s2d);
		this.renderPlayers();

		this.font = hxd.res.DefaultFont.get();

		this.fpsText = new Text(font, s2d);
		this.fpsText.x = 10;
		this.fpsText.y = 10;
		this.fpsText.text = "FPS: --";

		Toolkit.init({
			root: s2d
		});

		var vb = new VBox();
		vb.percentHeight = 100;
		vb.percentWidth = 100;

		var btn = new Button();
		btn.text = "moomoo opop";
		btn.onClick = function(_) {
			trace("OP");
			btn.text = "OPPP";
		};

		vb.addComponent(btn);

		Screen.instance.addComponent(vb);
	}

	override private function update(date:Float):Void {
		if (lastFrameCall == 0)
			lastFrameCall = date;
		delta = (date - lastFrameCall);
		lastFrameCall = date;

		timeSinceGameUpdate += delta * 100000;

		if (delta > 0) {
			var fps = Std.int(1000.0 / (delta));
			fpsText.text = "FPS: " + fps;
		}

		var dx = 0;
		var dy = 0;
		moveDir = null;
		if (Key.isDown(Key.W))
			dy -= 1;
		if (Key.isDown(Key.S))
			dy += 1;
		if (Key.isDown(Key.A))
			dx -= 1;
		if (Key.isDown(Key.D))
			dx += 1;

		if (dx != 0 || dy != 0) {
			moveDir = Math.atan2(dy, dx);
		} else
			moveDir = null;

		if (Main.instance.game.playerManager.myPlayer != null) {
			camera.x = Main.instance.game.playerManager.myPlayer.visualX;
			camera.y = Main.instance.game.playerManager.myPlayer.visualY;
		}

		background.x = -this.camera.x;
		background.y = -this.camera.y;

		grid.x = -this.camera.x;
		grid.y = -this.camera.y;

		playersC.clear();
		renderPlayers();
		playersC.x = -this.camera.x + Window.getInstance().width / 2;
		playersC.y = -this.camera.y + Window.getInstance().height / 2;
	}

	private function renderPlayers() {
		for (player in Main.instance.game.playerManager.players) {
			//var t = Math.min(((Timer.stamp() * 1000) - timeSinceGameUpdate) / 110.0, 1.0);

			player.visualX = player.visualX * (1 - 0.05) + player.x * 0.05; //lerp(player.lastX, player.x, t);
			player.visualY = player.visualY * (1 - 0.05) + player.y * 0.05; //lerp(player.lastY, player.y, t);

			playersC.beginFill(0xbf8f54);
			playersC.lineStyle(5.5, 0x303030);
			playersC.drawCircle(player.visualX, player.visualY, 35, 0);
			playersC.endFill();
		}
		// var alpha:Float = Game.timeSinceGameUpdate / Config.ServerUpdateRate;

		// var x = lerp(oldx, currx, alpha);
	}

	private function renderBackground() {
		background.clear();

		// grasslands biome
		background.beginFill(0x77E261);
		background.drawRect(0, 0, Config.MapSize, Config.MapSize);
		background.endFill();

		// overlay to darken colors
		background.beginFill(0x231450, 0.3);
		background.drawRect(0, 0, Config.MapSize, Config.MapSize);
		background.endFill();
	}

	private function renderGridLines() {
		grid.clear();
		grid.lineStyle(4, 0x000000, 0.06);

		var x = 0;
		while (x < Config.MapSize) {
			grid.moveTo(0, x);
			grid.lineTo(Config.MapSize, x);

			x += Config.GridBoxSize;
		}

		var y = 0;
		while (y < Config.MapSize) {
			grid.moveTo(y, 0);
			grid.lineTo(y, Config.MapSize);

			y += Config.GridBoxSize;
		}
	}

	private function lerp(a:Float, b:Float, t:Float):Float {
		return a + (b - a) * t;
	}
}

class Camera {
	public var x(default, default):Float;
	public var y(default, default):Float;

	public function new() {
		x = -1920 / 2 + 700;
		y = -1080 / 2 + 700;
	}
}
