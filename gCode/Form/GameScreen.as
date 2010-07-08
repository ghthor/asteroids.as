package gCode.Form
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import qEngine.Console;
	import qEngine.qForm.Form;
	import qEngine.qForm.FormManager;
	import qEngine.qForm.I_Form;
	import qEngine.qRender.Canvas;
	/**
	 * ...
	 * @author ...
	 */
	public class GameScreen extends Form implements I_Form
	{
		var canvas:Canvas = new Canvas();
		
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
			
		}
		
		private function keyDown(e:KeyboardEvent):void {
			trace("Key Down: " + e.keyCode)
			switch (e.keyCode) {
				default:
					trace("Key Down: " + e.keyCode)
			}
		}
		
		private function keyUp(e:KeyboardEvent):void {
			switch(e.keyCode) {
				default:
					trace("Key Up: " + e.keyCode)
			}
		}
		
		private function tick(e:Event):void {
			
			// The Game Loop
		}
		
		public function enableAllEvents():void{
			//btnStart.addEventListener(MouseEvent.CLICK, gotoGameScreen);
			FormManager.theStage.addEventListener(Event.ENTER_FRAME, tick)
		}
		
		public function disableAllEvents():void{
			FormManager.theStage.removeEventListener(Event.ENTER_FRAME, tick)
		}
				
		/// Stores the Index in the FormManager's Array of This Form
		static private var _id:int;
		static public function get id():int { return _id; }
				
		public function set index(p_val:int):void{
			_id = p_val;
		}
	}	
}