package gCode {
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
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
		
		const hitTestRes:Number = .5
		public function ChkCollide(entity:Entity):Boolean {
			if (hitTestObject(entity)) {
				var overlapRect:Rectangle = getBounds(stage).intersection(entity.getBounds(stage))
				var meHit:Boolean = false
				var paramHit:Boolean = false
				for (var horz:Number = 0; horz <= overlapRect.width; horz += hitTestRes) {
					for (var vert:Number = 0; vert <= overlapRect.height; vert += hitTestRes) {
						meHit = hitTestPoint(overlapRect.left + horz, overlapRect.top + vert, true)
						paramHit = hitTestPoint(overlapRect.left + horz, overlapRect.top + vert, true)
						if (meHit && paramHit) {
							return true
						}
					}
				}
			}
			return false
		}
	}
	
}