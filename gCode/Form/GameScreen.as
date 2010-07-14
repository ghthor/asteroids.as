package gCode.Form
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import gCode.Asteroid;
	import gCode.Bullet;
	import gCode.Entity;
	import gCode.I_Asteroid;
	import gCode.Ship;
	import qEngine.Console;
	import qEngine.qForm.Form;
	import qEngine.qForm.FormManager;
	import qEngine.qForm.I_Form;
	import qEngine.qMath.Vector2D;
	import qEngine.qRender.Canvas;
	/**
	 * ...
	 * @author ...
	 */
	public class GameScreen extends Form implements I_Form
	{
		// useless atm
		var canvas:Canvas = new Canvas();
		
		// Player controlled Ship
		var ship:Ship;
		
		// The Bullets that are in Play fired from the ship
		var bullets:Array = new Array()
		
		public static const BulletSpeed:Number = 11
		public static const BulletsPerSec:Number = 8
		
		// Asteroids
		var numRoids:Number = 5
		var asteroids:Array = new Array()
		
		public static var StageWidth:Number = 800
		public static var StageHeight:Number = 600
		public static var FPS:Number = 60
		public static var Acceleration:Number = .25 // pixels per frame
		public static var MaxSpeed:Number = 10 // pixels per frame
		public static var Drag:Number = -.015
		public static var RotationPerTick:Number = 6 // degs per tick
		
		public var gui_lives:TextField;
		
		public function GameScreen() {
			stop();
			ship = new Ship(this)
		}
		
		/// Run After All Forms Have Been Created
		public function initialize():void {
			
			gui_lives = _gui_lives
			gui_lives.text = ship.lives.toString()
			
			canvas.x = 0
			canvas.y = 0
			addChild(canvas)
			
			Entity.canvas = canvas
			
			//addChild(Console.display)
			//Console.display.y = 100
			
			ship.initialize()
			addChildAt(ship,0)
			ship.X = StageWidth / 2
			ship.Y = StageHeight / 2
			
			for (var i:int = 0; i < numRoids; i++) {
				var a:Asteroid = new Asteroid()
				a.initialize()
				a.randomize()
				addChildAt(a,0)
				asteroids.push(a)
			}
		}
		
		var forward:Boolean = false
		var backward:Boolean = false
		var rotRight:Boolean = false
		var rotLeft:Boolean = false
		var firing:Boolean = false
		
		var Key_W = 87
		var Key_A = 65
		var Key_S = 83
		var Key_D = 68
		var Key_Z = 90
		
		private function keyDown(e:KeyboardEvent):void {
			//trace("Key Down: " + e.keyCode)
			switch (e.keyCode) {
				case Key_W:
				case Keyboard.UP:
					forward = true
					break
				case Key_S:
				case Keyboard.DOWN:
					backward = true
					break
				case Key_A:
				case Keyboard.LEFT:
					rotLeft = true
					break
				case Key_D:
				case Keyboard.RIGHT:
					rotRight = true
					break
				case Keyboard.ENTER:
				case Keyboard.NUMPAD_ENTER:
				case Keyboard.SPACE:
					firing = true
					break
				default:
					ship.lives += 1
					trace("Key Down: " + e.keyCode)
			}
		}
		
		private function keyUp(e:KeyboardEvent):void {
			switch(e.keyCode) {
				case Key_W:
				case Keyboard.UP:
					forward = false
					break
				case Key_S:
				case Keyboard.DOWN:
					backward = false
					break
				case Key_A:
				case Keyboard.LEFT:
					rotLeft = false
					break
				case Key_D:
				case Keyboard.RIGHT:
					rotRight = false
					break
				case Keyboard.ENTER:
				case Keyboard.NUMPAD_ENTER:
				case Keyboard.SPACE:
					firing = false
					break
				default:
					//trace("Key Up: " + e.keyCode)
			}
		}
		
		var fireTick:Number = FPS
		private function tick(e:Event):void {
			
			//ship.updateFacing(mouseCoords)
			
			// Process the Player's Input
			if (rotLeft && !ship.Dead) {
				ship.rotate(-RotationPerTick)
			}
			if (rotRight && !ship.Dead) {
				ship.rotate(RotationPerTick)
			}
			if (forward && !ship.Dead) {
				ship.accelForward()
			}
			if (backward && !ship.Dead) {
				ship.accelBackwards()
			}
			
			fireTick++
			// Spawn a bullet
			if (firing && !ship.Dead) {
				if (fireTick >= FPS/BulletsPerSec) {
					fireTick = 0
					var b:Bullet = ship.spawnBullet()
					addChild(b)
					bullets.push(b)
				}
			}
			
			// Tick everything foward and do Collison Detection
			for (var i:int = 0; i < 1.0/tickResolution; i++) {
				
				// Tick the ship Forward
				if (!ship.Dead) {
					ship.tick(tickResolution)
				}
				
				// Tick the Bullets Forward
				if (bullets.length > 0) {
					bullets = bullets.filter(tickBullets)
				}
				
				// Tick the Asteroids Forward
				if (asteroids.length > 0) {
					asteroids = asteroids.filter(tickAsteroids)
				}
				
				// Check for Collisons with the Ship
				if (asteroids.length > 0 && !ship.Dead) {
					asteroids.forEach(collideShip)
				}
				
				// Collide bullets and asteroids
				if (bullets.length > 0) {
					bullets = bullets.filter(collideBullets)
				}
			}
			
			// If the playe is dead we need to Respawn them
			if (ship.Dead && ship.lives > 0) {
				deathTicks++
				
				// Respawn Ship
				// This needs to do it intelligently so you don't spawn on an asteroid
				if (deathTicks >= 60) {
					deathTicks = 0
					addChild(ship)
					ship.Dead = false
					ship.X = StageWidth / 2
					ship.Y = StageHeight / 2
				}
			}
		}
		
		var deathTicks:int = 0
		public function collideShip(asteroid:Asteroid, i:int, arr:Array):void {
			var hit:Boolean = ship.ChkCollide(asteroid)
			
			// If hit its time to die
			if (hit) {
				ship.Death()
			}
		}
		
		public function collideBullets(bullet:Bullet, i:int, arr:Array):Boolean {
			var hit:Boolean = false
			for (var i:int = 0; i < asteroids.length; i++) {
				hit = bullet.ChkCollide(asteroids[i])
				if (hit) {
					
					var asteroid:I_Asteroid = (asteroids[i] as I_Asteroid)
					if (asteroid.canSplit()) {
						// Split the Asteroid
						var dir:Vector2D = new Vector2D(bullet.velocity.x, bullet.velocity.y)
						dir.rotateByDegree(90)
						dir.makeUnitVector()
						dir.scale((asteroid as Asteroid).width/5)
						for (var j:int = 0; j < 2; j++) {
							var temp:Asteroid = asteroid.split(dir)
							addChildAt(temp,0)
							asteroids.push(temp)
							dir.rotateByDegree(180)
						}
					}
					removeChild(asteroids[i])
					asteroids.splice(i, 1)
					removeChild(bullet)
					return false
				}
			}
			return true
		}
		
		var tickResolution:Number = .05
		
		/// filter func for Bullets tick
		public function tickBullets(bullet:Bullet, i:int, arr:Array):Boolean {
			if (bullet.Dead) {
				this.removeChild(bullet)
				return false
			}else {
				bullet.tick(tickResolution)
				return true
			}
		}
		
		/// forEach func for asteroids tick
		public function tickAsteroids(asteroid:Asteroid, i:int, arr:Array):Boolean {
			asteroid.tick(tickResolution)
			return true
		}
		
		// For mouse based Targeting
		var mouseCoords:Vector2D = new Vector2D()
		private function updateFacing(e:MouseEvent):void {
			mouseCoords.setVector2D(e.stageX, e.stageY)
			//ship.updateFacing(mouseCoords)
		}
		
		public function enableAllEvents():void{
			//btnStart.addEventListener(MouseEvent.CLICK, gotoGameScreen);
			FormManager.theStage.addEventListener(Event.ENTER_FRAME, tick)
			FormManager.theStage.addEventListener(KeyboardEvent.KEY_UP, keyUp)
			FormManager.theStage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown)
			FormManager.theStage.addEventListener(MouseEvent.MOUSE_MOVE, updateFacing)
			stage.focus = stage
		}
		
		public function disableAllEvents():void{
			FormManager.theStage.removeEventListener(Event.ENTER_FRAME, tick)
			FormManager.theStage.removeEventListener(KeyboardEvent.KEY_UP, keyUp)
			FormManager.theStage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown)
			FormManager.theStage.removeEventListener(MouseEvent.MOUSE_MOVE, updateFacing)
		}
				
		/// Stores the Index in the FormManager's Array of This Form
		static private var _id:int;
		static public function get id():int { return _id; }
				
		public function set index(p_val:int):void{
			_id = p_val;
		}
	}	
}