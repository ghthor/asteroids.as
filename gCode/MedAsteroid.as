package gCode {
	import qEngine.qMath.Vector2D;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MedAsteroid extends Asteroid implements I_Asteroid {
		
		public function MedAsteroid() {
			var dev:Number = ((Math.random() * .1 * 2) - .1) // min/max .4/.6
			scaleX = .5 + dev
			scaleY = .5 + dev
		}
		
		public override function canSplit():Boolean{
			return true
		}
		
		public function randomSmallFrom(dir:Vector2D):Asteroid {
			var small:SmallAsteroid = new SmallAsteroid()
			small.X = X + dir.x
			small.Y = Y + dir.y
			small.randomColor()
			small.randomSpin()
			small.velocity.setByVector2D(velocity)
			small.velocity.scale(Math.random() + .1)
			small.velocity.rotateByDegree((Math.random() * degOffsetMax * 2) - degOffsetMax)
			return small
		}
		
		
		public override function split(dir:Vector2D):Asteroid{
			return randomSmallFrom(dir)
		}
	}
	
}