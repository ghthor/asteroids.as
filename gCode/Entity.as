package gCode {
	import flash.display.MovieClip;
	import gCode.Form.GameScreen;
	import qEngine.qMath.Vector2D;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Entity extends MovieClip {
		public var velocity:Vector2D = new Vector2D()
		public var facing:Vector2D = new Vector2D()
		
		
		public function WrapAround() {
			if (x > GameScreen.StageWidth) {
				x = x - GameScreen.StageWidth
			}else if (x < 0) {
				x = GameScreen.StageWidth + x
			}
			
			if (y > GameScreen.StageHeight) {
				y = y - GameScreen.StageHeight
			}else if (y < 0) {
				y = GameScreen.StageHeight + y
			}
		}
	}
	
}