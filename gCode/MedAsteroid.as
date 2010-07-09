package gCode {
	import qEngine.qMath.Vector2D;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MedAsteroid extends Asteroid implements I_Asteroid {
		
		public function MedAsteroid() {
			scaleX = .5
			scaleY = .5
		}
		
		public override function canSplit():Boolean{
			return false
		}
		
		public override function split(vector:Vector2D):Asteroid{
			return randomMedFrom()
		}
	}
	
}