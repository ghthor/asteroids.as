package gCode {
	import flash.display.MovieClip;
	import flash.geom.Point;
	import gCode.Form.GameScreen;
	import qEngine.qMath.Vector2D;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Ship extends Entity {
		
		public var bulletSpawnPt:MovieClip
		
		public var turretFacing:Vector2D = new Vector2D()
		
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
			WrapAround()
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
			turretFacing.rotateByDegree(deg)
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
		
		private function getBulletSpawnPt():Point {
			var spawnPt:Point = new Point(bulletSpawnPt.x, bulletSpawnPt.y)
			//trace(spawnPt, "local")
			var pt:Point = localToGlobal(spawnPt)
			//trace(pt, "global")
			return pt
		}
		
		public function spawnBullet():Bullet {
			var b:Bullet = new Bullet()
			b.facing = turretFacing
			b.velocity = new Vector2D(b.facing.x, b.facing.y)
			b.velocity.makeLength(GameScreen.BulletSpeed)
			var pt:Point = getBulletSpawnPt()
			b.x = pt.x
			b.y = pt.y
			return b
		}
		
		public function initialize() {
			bulletSpawnPt = BulletSpawnPt
			facing.setVector2D(0, -1)
			turretFacing.setByVector2D(facing)
		}
		
	}
	
}