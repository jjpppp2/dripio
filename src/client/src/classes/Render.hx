package classes;

import js.html.CanvasRenderingContext2D;
import js.html.CanvasElement;
import js.Browser;
import src.shared.Config;

class Render {
	private var camera:Camera;
	private var delta:Float;
	private var lastFrameCall:Float;
	private var xOffset:Float;
	private var yOffset:Float;
	private final canvas:CanvasElement;
	private final context:CanvasRenderingContext2D;

	public function new() {
		this.camera = new Camera();
		final doc = js.Browser.document;
		this.canvas = cast doc.getElementById("ctx");
		this.context = canvas.getContext2d();

		Browser.window.requestAnimationFrame(this.render);
	}

	private function render(date:Float):Void {
		this.delta = (this.lastFrameCall ?? date) - date;
		this.lastFrameCall = date;

		this.xOffset = this.camera.x;
		this.yOffset = this.camera.y;

		this.renderBackground();
		this.renderGridLines();
	}

	private function renderPlayers() {
		//var alpha:Float = Game.timeSinceGameUpdate / Config.ServerUpdateRate;

		//var x = lerp(oldx, currx, alpha);
	}

	private function renderBackground() {
		// render the boundaries (just draw on whole screen)
		context.fillStyle = "#232323";
		context.fillRect(0, 0, Browser.window.innerWidth, Browser.window.innerHeight);

		context.save();
		context.translate(-xOffset, -yOffset);

		// winter biome
		context.fillStyle = "#fcfcfd";
		context.fillRect(0, 0, Config.SnowBiomeY, Config.MapSize);

		// grasslands biome
		context.fillStyle = "#77e261";
		context.fillRect(0, Config.SnowBiomeY, Config.MapSize, (Config.MapSize - Config.SnowBiomeY));

		// overlay to darken colors
		context.fillStyle = "rgba(35, 20, 80, 0.3)";
		context.fillRect(0, 0, Config.MapSize, Config.MapSize);
		context.restore();
	}

	private function renderGridLines() {
		context.save();
		context.translate(-xOffset, -yOffset);
		context.beginPath();
		context.lineWidth = 4;
		context.globalAlpha = 0.06;
		context.strokeStyle = "#000";

		var x = 0;
		while (x < Config.MapSize) {
			context.moveTo(0, x);
			context.lineTo(Config.MapSize, x);

			x += Config.GridBoxSize;
		}

		var y = 0;
		while (y < Config.MapSize) {
			context.moveTo(y, 0);
			context.lineTo(y, Config.MapSize);

			y += Config.GridBoxSize;
		}

		context.stroke();
		context.restore();
	}

	private function lerp(a:Float, b:Float, t:Float):Float {
		return a + (b - a) * t;
	}
}

class Camera {
	@:isVar
	public var x(get, set):Float;
	@:isVar
	public var y(get, set):Float;

	public function new() {
		this.x = -1920.0 / 2.0 + 700;
		this.y = -1080.0 / 2.0 + 700;
	}

	function get_y():Float {
		return this.y;
	}

	function set_y(y:Float):Float {
		this.y = y;
		return y;
	}

	function get_x():Float {
		return this.x;
	}

	function set_x(x:Float):Float {
		this.x = x;
		return x;
	}
}
