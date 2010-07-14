package gCode.Form
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import qEngine.qForm.Form;
	import qEngine.qForm.I_Form;
	/**
	 * ...
	 * @author Will Walthall
	 */
	public class OptionsScreen extends Form implements I_Form
	{		
		var btnTitleScreen:SimpleButton
		var options:OptionsDialog
		
		public function OptionsScreen() {
			stop()
		}
		/* INTERFACE qEngine.qForm.I_Form */
		
		/// Run After All Forms Have Been Created
		public function initialize():void {
			btnTitleScreen = _btnTitleScreen
			options = _optionsDialog
			options.initialize()
			options.update()
		}
		
		public function enableAllEvents():void{
			btnTitleScreen.addEventListener(MouseEvent.CLICK, gotoTitleScreen)
			options.enableAllEvents()
		}
		
		public function disableAllEvents():void{
			btnTitleScreen.removeEventListener(MouseEvent.CLICK, gotoTitleScreen)
			options.disableAllEvents()
		}
		
		private function gotoTitleScreen(e:MouseEvent):void {
			switchToForm(TitleScreen.id);
		}
		
		/// Stores the Index in the FormManager's Array of This Form
		static private var _id:int;
		static public function get id():int { return _id; }
				
		public function set index(p_val:int):void{
			_id = p_val;
		}
	}	
}