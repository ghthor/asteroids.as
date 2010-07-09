package gCode {
	import flash.events.MouseEvent;
	import qEngine.qMath.Vector2D;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import gCode.Form.GameScreen;
	import gCode.I_Asteroid;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Asteroid extends Entity implements I_Asteroid {
		
		// Bounds for random generation
		public static const MaxSpeed:Number = 4
		public static const MaxSpin:Number = 3 // degrees per tick
		
		// Rotation in degree's per tick
		var degPerTick:Number = 0
		
		public function tick(time:Number) {
			if (debug) { 
				trace(X, Y)
				trace(velocity.x * time, velocity.y * time)
				trace(X + (velocity.x * time), Y + (velocity.y * time))
			}
			X = X + (velocity.x * time)
			Y = Y + (velocity.y * time)
			if (debug) { trace(x, X, y, Y); debug = false }
			
			rotation = rotation + (degPerTick * time)
			WrapAround()
		}
		
		public function Asteroid() {
			stop()
			addEventListener(MouseEvent.CLICK, debugBug)
		}
		
		var debug:Boolean = false
		private function debugBug(e:MouseEvent):void {
			trace(velocity)
			debug = true
		}
		
		public function randomize():Asteroid {
			randomSpin()
			
			X = Math.random() * GameScreen.StageWidth
			Y = Math.random() * GameScreen.StageHeight
			
			randomVelocity()
			randomColor()
			
			return this
		}
		
		public function randomSpin() {
			degPerTick = (Math.random() * MaxSpin * 2) - (MaxSpin)
		}
		
		public function randomColor() {
			transform.colorTransform = new ColorTransform(1, 1, 1, 1, (uint)(Math.random() * 255), (uint)(Math.random() * 255), (uint)(Math.random() * 255))
		}
		
		public function randomVelocity() {
			velocity.x = (Math.random() * 2) - 1
			velocity.y = (Math.random() * 2) - 1
			if (velocity.length <= .25) {
				randomVelocity()
			}
			velocity.makeLength(Math.random() * MaxSpeed)
		}
		
		const degOffsetMax:Number = 20
		
		public function randomMedFrom(dir:Vector2D):Asteroid {
			var med:MedAsteroid = new MedAsteroid()
			med.X = X + dir.x
			med.Y = Y + dir.y
			med.randomColor()
			med.randomSpin()
			med.velocity.setByVector2D(velocity)
			med.velocity.scale(Math.random() + .5)
			med.velocity.rotateByDegree((Math.random() * degOffsetMax * 2) - degOffsetMax)
			return med
		}
		
		/* INTERFACE gCode.I_Asteroid */
		
		public function canSplit():Boolean{
			return true
		}
		
		public function split(dir:Vector2D):Asteroid{
			return randomMedFrom(dir)
		}
	}
	
}