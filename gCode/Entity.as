package gCode {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import gCode.Form.GameScreen;
	import qEngine.qMath.EndPt;
	import qEngine.qMath.Vector2D;
	import qEngine.qMath.VectorLine;
	import qEngine.qRender.Canvas;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Entity extends MovieClip {
		public var velocity:Vector2D = new Vector2D()
		public var facing:Vector2D = new Vector2D()
		public static var canvas:Canvas
		
		public var hmap:Array = new Array()
		
		public function Entity() {
			stop()
		}
		
		public function initialize() {
			var temp:DisplayObject
			for (var i:int = 0; i < numChildren; i++) {
				temp = getChildAt(i)
				if (temp is EndPt) {
					hmap.push(temp)
				}
			}
			hmap.sortOn("name", Array.CASEINSENSITIVE)
			//for (var i:int = 0; i < hmap.length; i++) {
				//trace(i, ":", hmap[i].name)
			//}
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
				var meBounds:Rectangle = getBounds(stage)
				var paramBounds:Rectangle = entity.getBounds(stage)
				var overlapRect:Rectangle = getBounds(stage).intersection(entity.getBounds(stage))
				
				var meHit:Boolean = false
				var paramHit:Boolean = false
				var hit:Boolean = false
				
				for (var i:int = 0; i < hmap.length; i++) {
					var pt:Point = localToGlobal(new Point(hmap[i].x, hmap[i].y))
					if (overlapRect.containsPoint(pt)) {
						hit = entity.hitTestPoint(pt.x, pt.y, true)
						if (hit) { return true }
					}
				}
				
				for (var i:int = 0; i < entity.hmap.length; i++) {
					var pt:Point = entity.localToGlobal(new Point(entity.hmap[i].x, entity.hmap[i].y))
					if (overlapRect.containsPoint(pt)) {
						hit = hitTestPoint(pt.x, pt.y, true)
						if (hit) { return true }
					}
				}
				return hit
			}
			return false
		}
		
	}
	
}