package protanki.launcher.controls.selector.flagbutton
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import protanki.launcher.Locale;
	import protanki.launcher.controls.selector.LocaleSelectionEvent;
	
	public class FlagButton extends Sprite
	{
		
		public var locale:Locale;
		
		private var _selectorItem:Boolean = false;
		
		public function FlagButton(bmpData:BitmapData, locale:Locale)
		{
			super();
			this.locale = locale;
			var shape:Shape = new Shape();
			shape.graphics.clear();
			shape.graphics.beginBitmapFill(bmpData);
			shape.graphics.drawRect(0, 0, bmpData.width, bmpData.height);
			shape.graphics.endFill();
			addChild(shape);
			addEventListener("click", click);
			addEventListener("mouseOver", onMouseOver);
			addEventListener("mouseOut", onMouseOut);
			redraw(false);
		}
		
		public function redraw(mouseOver:Boolean):void
		{
			graphics.clear();
			if (selectorItem)
			{
				return;
			}
			graphics.beginFill(0, 0);
			graphics.drawRect(-8, -5, 66, 26);
			graphics.endFill();
			if (!mouseOver)
			{
				return;
			}
			graphics.beginFill(0, 1);
			graphics.drawRect(-8, -5, 66, 26);
			graphics.endFill();
		}
		
		public function set selectorItem(value:Boolean):void
		{
			_selectorItem = value;
		}
		
		public function get selectorItem():Boolean
		{
			return _selectorItem;
		}
		
		private function click(e:MouseEvent):void
		{
			var ev:LocaleSelectionEvent = new LocaleSelectionEvent("selection", true, false);
			ev.locale = locale;
			dispatchEvent(ev);
		}
		
		private function onMouseOver(e:MouseEvent):void
		{
			if (!selectorItem)
			{
				Mouse.cursor = "button";
			}
			redraw(true);
		}
		
		private function onMouseOut(e:MouseEvent):void
		{
			Mouse.cursor = "auto";
			redraw(false);
		}
	}
}
