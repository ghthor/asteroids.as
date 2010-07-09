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
		
		var _X:Number
		
		public function get X():Number { return _X; }
		
		public function set X(value:Number):void {
			_X = value;
			x = _X
		}
		var _Y:Number
		
		public function get Y():Number { return _Y; }
		
		public function set Y(value:Number):void {
			_Y = value;
			y = _Y
		}
		
		public function WrapAround() {
			if (X > GameScreen.StageWidth) {
				X = X - GameScreen.StageWidth
			}else if (X < 0) {
				X = GameScreen.StageWidth + X
			}
			
			if (Y > GameScreen.StageHeight) {
				Y = Y - GameScreen.StageHeight
			}else if (Y < 0) {
				Y = GameScreen.StageHeight + Y
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