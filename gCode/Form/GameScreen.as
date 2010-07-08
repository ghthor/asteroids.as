package gCode.Form
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import gCode.Ship;
	import qEngine.Console;
	import qEngine.qForm.Form;
	import qEngine.qForm.FormManager;
	import qEngine.qForm.I_Form;
	import qEngine.qMath.Vector2D;
	import qEngine.qRender.Canvas;
	/**
	 * ...
	 * @author ...
	 */
	public class GameScreen extends Form implements I_Form
	{
		var canvas:Canvas = new Canvas();
		
		var ship:Ship = new Ship()
		
		var maxSpeed:Number = 10 // pixels per Frame
		
		public static const StageWidth:Number = 800
		public static const StageHeight:Number = 600
		public static const FPS:Number = 60
		public static const Acceleration:Number = .25 // pixels per frame
		public static const MaxSpeed:Number = 10 // pixels per frame
		public static const Drag:Number = -.015
		
		public function GameScreen() {
			stop();			
		}
		
		/// Run After All Forms Have Been Created
		public function initialize():void {
			
			canvas.x = 0;
			canvas.y = 0;
			addChild(canvas);
			
			addChild(Console.display)
			Console.display.y = 100
			
			ship.initialize()
			addChild(ship)
			ship.x = 800 / 2
			ship.y = 600 / 2
		}
		
		var forward:Boolean = false
		var backward:Boolean = false
		
		private function keyDown(e:KeyboardEvent):void {
			trace("Key Down: " + e.keyCode)
			switch (e.keyCode) {
				case 65:
					forward = true
					break
				case 90:
					backward = true
					break
				default:
					trace("Key Down: " + e.keyCode)
			}
		}
		
		private function keyUp(e:KeyboardEvent):void {
			switch(e.keyCode) {
				case 65:
					forward = false
					break
				case 90:
					backward = false
					break
				default:
					trace("Key Up: " + e.keyCode)
			}
		}
		
		private function tick(e:Event):void {
			
			if (forward) {
				ship.accelForward()
			}
			if (backward) {
				ship.accelBackwards()
			}
			ship.tick()
			// The Game Loop
		}
		
		// Right now I'm using mouse based targeting
		private function updateFacing(e:MouseEvent):void {
			ship.updateFacing(new Vector2D(e.localX, e.localY))
		}
		
		public function enableAllEvents():void{
			//btnStart.addEventListener(MouseEvent.CLICK, gotoGameScreen);
			FormManager.theStage.addEventListener(Event.ENTER_FRAME, tick)
			FormManager.theStage.addEventListener(KeyboardEvent.KEY_UP, keyUp)
			FormManager.theStage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown)
			FormManager.theStage.addEventListener(MouseEvent.MOUSE_MOVE, updateFacing)
		}
		
		public function disableAllEvents():void{
			FormManager.theStage.removeEventListener(Event.ENTER_FRAME, tick)
			FormManager.theStage.removeEventListener(KeyboardEvent.KEY_UP, keyUp)
			FormManager.theStage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown)
			FormManager.theStage.removeEventListener(MouseEvent.MOUSE_MOVE, updateFacing)
		}
				
		/// Stores the Index in the FormManager's Array of This Form
		static private var _id:int;
		static public function get id():int { return _id; }
				
		public function set index(p_val:int):void{
			_id = p_val;
		}
	}	
}