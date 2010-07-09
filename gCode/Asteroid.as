package gCode {
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
		
		public static const MaxSpeed:Number = 8
		public static const MaxSpin:Number = 3 // degrees per tick
		
		var degPerTick:Number = 0
		
		public function tick(time:Number) {
			x = x + (velocity.x * time)
			y = y + (velocity.y * time)
			
			rotation = rotation + (degPerTick * time)
			WrapAround()
		}
		
		public function Asteroid() {
			stop()
		}
		
		public function randomize():Asteroid {
			randomSpin()
			
			x = Math.random() * GameScreen.StageWidth
			y = Math.random() * GameScreen.StageHeight
			
			randomVelocity()
			
			velocity.makeLength(Math.random() * MaxSpeed)
			
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
		}
		
		const degOffsetMax:Number = 20
		
		public function randomMedFrom(dir:Vector2D):Asteroid {
			var med:MedAsteroid = new MedAsteroid()
			med.x = x + dir.x
			med.y = y + dir.y
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