package gCode {
	import flash.display.MovieClip;
	import gCode.Form.GameScreen;
	import qEngine.qMath.Vector2D;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Ship extends MovieClip {
		
		public var bulletSpawnPt:MovieClip
		var velocity:Vector2D = new Vector2D()
		public var facing:Vector2D = new Vector2D(0,-1)
		
		public function Ship() {
			stop()
		}
		
		public function tick() {
			//velocity.addVector2D(acceleration)
			x += velocity.x
			y += velocity.y
			
			if (velocity.length <= Math.abs(GameScreen.Drag)) {
				velocity.scale(0)
			}else {
				velocity.addLength(GameScreen.Drag)
			}
			
			// Wrap Around Code
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
		
		// Accelerate Foward
		public function accelForward() {
			var dir:Vector2D = facing.toUnitVector()
			dir.scale(GameScreen.Acceleration)
			velocity.addVector2D(dir)
		}
		
		// Accelerate Backwards
		public function accelBackwards() {
			var dir:Vector2D = facing.toUnitVector()
			dir.Invert()
			dir.scale(GameScreen.Acceleration)
			velocity.addVector2D(dir)
		}
		
		// This is for mouse based targeting
		public function updateFacing(mouseCoord:Vector2D) {
			var loc:Vector2D = new Vector2D(x, y)
			facing = loc.OffsetTo(mouseCoord)
			facing.makeUnitVector()
			var deg:Number = facing.toDegrees()
			rotation = deg + 90
		}
		
		public function initialize() {
			bulletSpawnPt = BulletSpawnPt
			//velocity.setVector2D(.5,-1)
		}
		
	}
	
}