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
		
		var _X:Number
		
		public function Entity() {
			stop()
		}
		
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
		
		const hitTestRes:Number = 1
		public function ChkCollide(entity:Entity):Boolean {
			if (hitTestObject(entity)) {
				var overlapRect:Rectangle = getBounds(stage).intersection(entity.getBounds(stage))
				//canvas.graphics.clear()
				//canvas.defaults()
				//canvas.graphics.drawRect(overlapRect.left, overlapRect.top, overlapRect.width, overlapRect.height)
				//var bounds:Rectangle = getBounds(stage)
				//canvas.graphics.drawRect(bounds.left, bounds.top, bounds.width, bounds.height)
				//bounds = entity.getBounds(stage)
				//canvas.graphics.drawRect(bounds.left, bounds.top, bounds.width, bounds.height)
				var meHit:Boolean = false
				var paramHit:Boolean = false
				//canvas.graphics.moveTo(overlapRect.left, overlapRect.top)
				for (var horz:Number = 0; horz <= overlapRect.width; horz += hitTestRes) {
					for (var vert:Number = 0; vert <= overlapRect.height; vert += hitTestRes) {
						
						meHit = hitTestPoint(overlapRect.left + horz, overlapRect.top + vert, true)
						paramHit = entity.hitTestPoint(overlapRect.left + horz, overlapRect.top + vert, true)
						//trace(meHit, paramHit)
						if (meHit && paramHit) {
							//canvas.graphics.lineStyle(1, 0xFF0000)
							//canvas.graphics.lineTo(overlapRect.left + horz, overlapRect.top + vert)
							return true
						}
						//canvas.graphics.lineTo(overlapRect.left + horz, overlapRect.top + vert)
					}
				}
			}
			return false
		}
	}
	
}