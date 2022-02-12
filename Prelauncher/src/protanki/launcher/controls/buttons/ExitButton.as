package protanki.launcher.controls.buttons
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	import protanki.launcher.Locale;
	import protanki.launcher.makeup.MakeUp;
	
	public class ExitButton extends Button
	{
		
		private static var buttonRedOld:Class = buttonRedOld_png;
		
		private static var buttonRedOverOld:Class = buttonRedOverOld_png;
		
		public function ExitButton()
		{
			super(function():*
			{
				var exitPressed:Function;
				return exitPressed = function(e:MouseEvent):void
				{
					NativeApplication.nativeApplication.exit();
				};
			}(), new buttonRedOld(), new buttonRedOverOld());
		}
		
		override public function switchLocale(locale:Locale):void
		{
			textField.defaultTextFormat.font = MakeUp.getFont(locale);
			
			
			textField.text = locale.exitText;
			textField.width += 5;
			textFieldToCenter();
			textField.textColor = 16751998;
		}
		
		override protected function onResize(e:Event):void
		{
			x = stage.stageWidth >> 1;
			y = (stage.stageHeight >> 1) + 150;
		}
	}
}
