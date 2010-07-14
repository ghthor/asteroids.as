package gCode.Form {
	
	import flash.events.Event;
	import qEngine.Console;
	import qEngine.qForm.FormManager
	/**
	 * ...
	 * @author ...
	 */
	public class Asteroids extends FormManager {
		
		public function Asteroids() {
			addEventListener(Event.ENTER_FRAME, load)
		}
		
		public function load(e:Event):void {
			removeEventListener(Event.ENTER_FRAME, load)
			super.initialize()
			
			// Add Forms to Managed Array
			Console.initialize()
			addForm(new TitleScreen())
			addForm(new GameScreen())
			addForm(new OptionsScreen())
			
			// initialize Each Form and Lock the Array from more Additions
			initializeAndLock()
		}
	}
	
}