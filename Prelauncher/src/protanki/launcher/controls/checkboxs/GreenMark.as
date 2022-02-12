package protanki.launcher.controls.checkboxs
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import protanki.launcher.Locale;
	import protanki.launcher.makeup.MakeUp;
	import flash.net.SharedObject;
	
	public class GreenMark extends Checkbox
	{
		
		private static var button:Class = checkboxNone_png;
		
		private static var buttonYes:Class = checkboxYes_png;
		
		private static var buttonNo:Class = checkboxNo_png;
		
		public function GreenMark(onClick:Function)
		{
			
			super(onClick, new button(), new buttonYes(), new buttonNo());
		}
		
		override public function switchLocale(locale:Locale):void
		{
			textField.defaultTextFormat.font = MakeUp.getFont(locale);
			textField.text = "UNLOCKED FPS";
			textFieldToCenter();
			
			textField.textColor = 16777215;
		}
		
		override protected function onResize(e:Event):void
		{
			x = 50;
			y = (stage.stageHeight >> 1) + 200;
		}
	}
}
