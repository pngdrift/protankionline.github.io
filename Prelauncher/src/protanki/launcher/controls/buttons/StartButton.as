package protanki.launcher.controls.buttons
{
	import flash.events.Event;
	import protanki.launcher.Locale;
	import protanki.launcher.makeup.MakeUp;
	import flash.net.SharedObject;
	
	public class StartButton extends Button
	{
		
		private static var buttonGreenOld:Class = buttonGreenOld_png;
		
		private static var buttonGreenOverOld:Class = buttonGreenOverOld_png;
		
		public function StartButton(onClick:Function)
		{
			
			super(onClick, new buttonGreenOld(), new buttonGreenOverOld());
			addEventListener("addedToStage", addedToStage);
		}
		
		private function addedToStage(e:Event):void
		{
			textField.textColor = 15073125;
		}
		
		override public function switchLocale(locale:Locale):void
		{
			textField.defaultTextFormat.font = MakeUp.getFont(locale);
			textField.text = locale.playText;
			textFieldToCenter();
		}
		
		override protected function onResize(e:Event):void
		{
			x = stage.stageWidth >> 1;
			y = (stage.stageHeight >> 1) + 80;
		}
	}
}
