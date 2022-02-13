package protanki.launcher.controls.checkboxs
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	import flash.ui.Mouse;
	import protanki.launcher.Locale;
	import protanki.launcher.controls.LocalizedControl;
	import protanki.launcher.makeup.MakeUp;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;

	import flash.net.SharedObject;
	
	public class Checkbox extends LocalizedControl
	{
		
		private var onClick:Function;
		
		protected var textField:TextField;
		
		private var button:DisplayObject;
		
		private var noButton:DisplayObject;
		
		private var yesButton:DisplayObject;
		
		public function Checkbox(onClick:Function, button:DisplayObject, yesButton:DisplayObject, noButton:DisplayObject)
		{
			textField = new TextField();
			super();
			this.onClick = onClick;
			this.button = button;
			this.noButton = noButton;
			this.yesButton = yesButton;
			
			addEventListener("addedToStage", addedToStage);
		}
		
		private function addedToStage(e:Event):void
		{
			removeEventListener("addedToStage", addedToStage);
			var textFormat:TextFormat = new TextFormat();
			textFormat.size = 13;
			textFormat.font = MakeUp.getFont(Locale.current);
			textField.embedFonts = true;
			textField.defaultTextFormat = textFormat;
			textField.autoSize = "right";
			textField.wordWrap = false;
			textField.multiline = false;
			textField.selectable = false;
			
			addChildToCenter(yesButton);
			addChildToCenter(button);
			addChildToCenter(noButton);

					noButton.visible = !SharedObject.getLocal("launcherStorage").data["ACTUAL_LIBRARY"] && SharedObject.getLocal("launcherStorage").data["COMPLETE"];
				

			
			button.visible = !SharedObject.getLocal("launcherStorage").data["UNLOCK_FPS"];
			
			yesButton.visible = SharedObject.getLocal("launcherStorage").data["UNLOCK_FPS"] && SharedObject.getLocal("launcherStorage").data["ACTUAL_LIBRARY"];
			
			addChild(textField);
			addEventListener("mouseOver", onMouseOver);
			addEventListener("mouseOut", onMouseOut);
			addEventListener("mouseDown", onMouseDown);
			addEventListener("click", onMouseClick);
		}
		
		public function update():void
		{
			if (SharedObject.getLocal("launcherStorage").data["UNLOCK_FPS"] == true)
			{
				
				button.visible = false;
				
				yesButton.visible = false;
				
			}
			else
			{
				button.visible = false;
				yesButton.visible = false;
				
			}
		}
		
		private function removedFromStage(e:Event):void
		{
			removeEventListener("removedFromStage", removedFromStage);
			addEventListener("addedToStage", addedToStage);
		}
		
		protected function textFieldToCenter():void
		{
			var metrics:TextLineMetrics = textField.getLineMetrics(0);
			textField.x = (-metrics.width >> 1) + 55;
			textField.y = (-metrics.height >> 1) - 3;
		}
		
		private function onMouseOver(e:MouseEvent):void
		{
			Mouse.cursor = "button";
		
		}
		
		private function onMouseOut(e:MouseEvent):void
		{
			Mouse.cursor = "auto";
		
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
		
		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			if (noButton.visible)
			{
				navigateToURL(new URLRequest("http://png-drift.ml/play/index.html"));
				SharedObject.getLocal("launcherStorage").data["UNLOCK_FPS"] = false
				
			}
			else
			{
				button.visible = !button.visible;
				yesButton.visible = !yesButton.visible;
				SharedObject.getLocal("launcherStorage").data["UNLOCK_FPS"] = yesButton.visible;
			}
		
		}
	
	}
}
