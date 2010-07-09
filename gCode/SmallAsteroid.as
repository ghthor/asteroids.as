package gCode {
	import qEngine.qMath.Vector2D;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SmallAsteroid extends Asteroid implements I_Asteroid {
		
		public function SmallAsteroid() {
			var dev:Number = ((Math.random() * .05 * 2) - .05) // min/max .2/.3
			scaleX = .25 + dev
			scaleY = .25 + dev
		}
		public override function canSplit():Boolean{
			return false
		}
		
		public override function split(dir:Vector2D):Asteroid {
			return randomMedFrom(dir)
		}
	}
	
}