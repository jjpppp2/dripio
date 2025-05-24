package src.client.src.classes;

import src.shared.Config;
import hxd.App;
import h2d.Graphics;
import hxd.Key;
import h2d.Text;

class Render extends App {
	private var camera:Camera;
	private var delta:Float;
	private var lastFrameCall:Float;
	private var xOffset:Float;
	private var yOffset:Float;
	private var zoom:Float;

	private var background:Graphics;
	private var grid:Graphics;
	//private var playersC:Graphics;

	private var font:Any;
	private var fpsText:Text;

	public function new() {
		super();
		this.camera = new Camera();
	}

	override function init() {
		this.background = new Graphics(s2d);
		this.renderBackground();

		this.grid = new Graphics(s2d);
		this.renderGridLines();

		//this.playersC = new Graphics(s2d);
		//this.renderPlayers();

		this.font = hxd.res.DefaultFont.get();

		this.fpsText = new Text(font, s2d);
		this.fpsText.x = 10;
		this.fpsText.y = 10;
		this.fpsText.text = "FPS: --";
	}

	override private function update(date:Float):Void {
		/*
			this.delta = (this.lastFrameCall ?? date) - date;
			this.lastFrameCall = date;

			this.xOffset = this.camera.x;
			this.yOffset = this.camera.y;

			this.renderBackground();
			this.renderGridLines();
		 */

		if (lastFrameCall == 0) lastFrameCall = date;
		delta = (date - lastFrameCall);
		lastFrameCall = date;

		if (delta > 0) {
			var fps = Std.int(1000.0 / (delta));
			fpsText.text = "FPS: " + fps;
		}

		if (Key.isDown(Key.W))
			camera.y -= 50;
		if (Key.isDown(Key.S))
			camera.y += 50;
		if (Key.isDown(Key.A))
			camera.x -= 50;
		if (Key.isDown(Key.D))
			camera.x += 50;

		background.x = -this.camera.x;
		background.y = -this.camera.y;

		grid.x = -this.camera.x;
		grid.y = -this.camera.y;

		// trace(delta);
	}

	private function renderPlayers() {
		// var alpha:Float = Game.timeSinceGameUpdate / Config.ServerUpdateRate;

		// var x = lerp(oldx, currx, alpha);
	}

	private function renderBackground() {
		background.clear();

		// render the boundaries (just draw on whole screen)
		// background.beginFill("#232323");
		// background.fillRect(0, 0, Browser.window.innerWidth, Browser.window.innerHeight);
		// background.endFill();

		// context.save();
		// context.translate(-xOffset, -yOffset);

		// winter biome
		background.beginFill(0xFCFCFD);
		background.drawRect(0, 0, Config.MapSize, Config.SnowBiomeY);
		background.endFill();

		// grasslands biome
		background.beginFill(0x77E261);
		background.drawRect(0, Config.SnowBiomeY, Config.MapSize, (Config.MapSize - Config.SnowBiomeY));
		background.endFill();

		// overlay to darken colors
		background.beginFill(0x231450, 0.3);
		background.drawRect(0, 0, Config.MapSize, Config.MapSize);
		background.endFill();
	}

	private function renderGridLines() {
		// context.save();
		// context.translate(-xOffset, -yOffset);

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

		// context.stroke();
		// context.restore();
	}

	private function renderPlayers() {
		
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
