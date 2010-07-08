package gCode.Form
{
	import flash.events.MouseEvent;
	import qEngine.qForm.Form;
	import qEngine.qForm.I_Form;
	/**
	 * ...
	 * @author Will Walthall
	 */
	public class TitleScreen extends Form implements I_Form
	{		
		var btnStart:SimpleButton;
		
		public function TitleScreen() {
			stop();			
		}		
		/* INTERFACE qEngine.qForm.I_Form */
		
		/// Run After All Forms Have Been Created
		public function initialize():void {
			btnStart = _btnStart
			switchToForm(TitleScreen.id)
		}
		
		public function enableAllEvents():void{
			btnStart.addEventListener(MouseEvent.CLICK, gotoGameScreen);
		}
		
		public function disableAllEvents():void{
			btnStart.removeEventListener(MouseEvent.CLICK, gotoGameScreen);
		}
		
		private function gotoGameScreen(e:MouseEvent):void {
			switchToForm(GameScreen.id);
		}
		
		/// Stores the Index in the FormManager's Array of This Form
		static private var _id:int;
		static public function get id():int { return _id; }
				
		public function set index(p_val:int):void{
			_id = p_val;
		}
	}	
}