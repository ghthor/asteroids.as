package gCode {
	import flash.display.MovieClip;
	import gCode.Form.GameScreen;
	import qEngine.qMath.Vector2D;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Bullet extends Entity {
		
		
		var MaxTravelDistance:Number = (new Vector2D(GameScreen.StageWidth, GameScreen.StageHeight)).length
		var DistanceTraveled:Number = 0
		
		public var Dead:Boolean = false
		public function tick() {
			x = x + velocity.x
			y = y + velocity.y
			
			DistanceTraveled += velocity.length
			if (DistanceTraveled >= MaxTravelDistance) { Dead = true }			
			WrapAround()
		}
	}
	
}