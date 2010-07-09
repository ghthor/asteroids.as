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
		public var facing:Vector2D = new Vector2D(0, -1)
		public var turretFacing:Vector2D = new Vector2D(0, -1)
		
		public function Ship() {
			stop()
		}
		
		public function tick() {
			//velocity.addVector2D(acceleration)
			x += velocity.x
			y += velocity.y
			
			// Apply Drag
			if (velocity.length <= Math.abs(GameScreen.Drag) || velocity.length == 0) {
				velocity.scale(0)
				//trace(velocity, "Scaled by Zero")
			}else {
				var v:Vector2D = velocity.toUnitVector()
				v.Invert()
				v.makeLength(Math.abs(GameScreen.Drag))
				velocity.addVector2D(v)
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
			//trace(x, y)
		}
		
		// Accelerate Foward
		public function accelForward() {
			var dir:Vector2D = facing.toUnitVector()
			dir.scale(GameScreen.Acceleration)
			velocity.addVector2D(dir)
			if (velocity.length > GameScreen.MaxSpeed) {
				velocity.makeLength(GameScreen.MaxSpeed)
			}
		}
		
		// Accelerate Backwards
		public function accelBackwards() {
			var dir:Vector2D = facing.toUnitVector()
			dir.Invert()
			dir.scale(GameScreen.Acceleration)
			velocity.addVector2D(dir)
			if (velocity.length > GameScreen.MaxSpeed) {
				velocity.makeLength(GameScreen.MaxSpeed)
			}
		}
		
		public function rotate(deg:Number) {
			facing.rotateByDegree(deg)
			rotation = rotation + deg
		}
		
		// This is for mouse based targeting
		public function updateTurrentFacing(mouseCoord:Vector2D) {
			var loc:Vector2D = new Vector2D(x, y)
			var newFacing:Vector2D = loc.OffsetTo(mouseCoord)
			if (newFacing.length == 0 || isNaN(newFacing.x) || isNaN(newFacing.y)) {
				return
			}
			turretFacing = newFacing.toUnitVector()
			//var deg:Number = turretFacing.toDegrees()
			//rotation = deg + 90
		}
		
		public function initialize() {
			bulletSpawnPt = BulletSpawnPt
			//velocity.setVector2D(.5,-1)
		}
		
	}
	
}