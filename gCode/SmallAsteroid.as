package gCode {
	import qEngine.qMath.Vector2D;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SmallAsteroid extends Asteroid implements I_Asteroid {
		
		public function SmallAsteroid() {
			scaleX = .25
			scaleY = .25
		}
		public override function canSplit():Boolean{
			return false
		}
		
		public override function split(vector:Vector2D):Asteroid{
		}
	}
	
}