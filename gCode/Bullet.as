package gCode {
	import flash.display.MovieClip;
	import gCode.Form.GameScreen;
	import qEngine.qMath.Vector2D;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Bullet extends Entity {
		
		
		var MaxTravelDistance:Number = (new Vector2D(GameScreen.StageWidth, GameScreen.StageHeight)).length / 3
		var DistanceTraveled:Number = 0
		
		public var Dead:Boolean = false
		public function tick(time:Number) {
			x = x + (velocity.x * time)
			y = y + (velocity.y * time)
			
			DistanceTraveled += (velocity.length * time)
			if (DistanceTraveled >= MaxTravelDistance) { Dead = true }		
			WrapAround()
		}
	}
	
}