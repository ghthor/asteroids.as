package gCode.Form {
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import qEngine.qForm.I_Form;
	
	/**
	 * ...
	 * @author ...
	 */
	public class OptionsDialog extends MovieClip {
		
		private var gui_Acceleration:TextField
		private var gui_MaxSpeed:TextField
		private var gui_Drag:TextField
		private var gui_RotationPerTick:TextField
		
		private var btnSave:SimpleButton
		
		public function OptionsDialog() {
			stop()
		}
		
		public function initialize() {
			// Link to instance names in the fla
			gui_Acceleration = _gui_Acceleration
			gui_MaxSpeed = _gui_MaxSpeed
			gui_Drag = _gui_Drag
			gui_RotationPerTick = _gui_RotationPerTick
			
			btnSave = _btnSave
		}

		/// Set .text to the current setting in GameScreen
		public function update() {
			gui_Acceleration.text = GameScreen.Acceleration.toString()
			gui_MaxSpeed.text = GameScreen.MaxSpeed.toString()
			gui_Drag.text = GameScreen.Drag.toString()
			gui_RotationPerTick.text = GameScreen.RotationPerTick.toString()
		}
		
		private function saveSettings(e:MouseEvent):void {
			_saveSettings()
		}
		public function _saveSettings() {
			trace("Accel val:", Number(gui_Acceleration.text))
			GameScreen.Acceleration = Number(gui_Acceleration.text)
			
			trace("Speed val:", Number(gui_MaxSpeed.text))
			GameScreen.MaxSpeed = Number(gui_MaxSpeed.text)
			
			trace("Drag val:", Number(gui_Drag.text))
			GameScreen.Drag = Number(gui_Drag.text)
			
			trace("Rotation val:", Number(gui_RotationPerTick.text))
			GameScreen.RotationPerTick = Number(gui_RotationPerTick.text)
		}
		
		public function enableAllEvents():void{
			btnSave.addEventListener(MouseEvent.CLICK, saveSettings)
		}
		
		public function disableAllEvents():void{
			btnSave.removeEventListener(MouseEvent.CLICK, saveSettings)
		}
	}
	
}