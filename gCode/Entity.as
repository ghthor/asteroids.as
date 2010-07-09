package gCode {
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import gCode.Form.GameScreen;
	import qEngine.qMath.Vector2D;
	import qEngine.qRender.Canvas;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Entity extends MovieClip {
		public var velocity:Vector2D = new Vector2D()
		public var facing:Vector2D = new Vector2D()
		public static var canvas:Canvas
		
		public function Entity() {
			stop()
		}
		
		// This is to fix the truncation bug when using normal x,y of displayobject
		var _X:Number
		var _Y:Number
		public function get X():Number { return _X; }
		public function set X(value:Number):void {
			_X = value;
			x = _X
		}
				
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
		
		// 1 = pixel checking
		// .5 = 1/2 pixel resolution
		const hitTestRes:Number = 1
		public function ChkCollide(entity:Entity):Boolean {
			if (hitTestObject(entity)) {
				var overlapRect:Rectangle = getBounds(stage).intersection(entity.getBounds(stage))
				
				var meHit:Boolean = false
				var paramHit:Boolean = false
				
				// Check all the points inside the overlapRect against both objects
				// Inefficent but it works
				for (var horz:Number = 0; horz <= overlapRect.width; horz += hitTestRes) {
					for (var vert:Number = 0; vert <= overlapRect.height; vert += hitTestRes) {
						
						meHit = hitTestPoint(overlapRect.left + horz, overlapRect.top + vert, true)
						paramHit = entity.hitTestPoint(overlapRect.left + horz, overlapRect.top + vert, true)
						
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