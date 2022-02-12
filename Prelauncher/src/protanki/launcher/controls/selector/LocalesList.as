package protanki.launcher.controls.selector
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import protanki.launcher.Locale;
	import protanki.launcher.LocalesFactory;
	import protanki.launcher.controls.selector.flagbutton.FlagButton;
	import protanki.launcher.locales.Locales;
	
	public class LocalesList extends Sprite
	{
		
		private static var flagsPng:Class = flags_png$5ee0c120779329acf355861867b192b8354139204;
		
		private static var flagsBitmapData:BitmapData = (new flagsPng() as Bitmap).bitmapData;
		
		private static var panel:Class = panel_png$e67b3782353f75555851b480ca538f72352815433;
		
		private static var panelData:BitmapData = (new panel() as Bitmap).bitmapData;
		
		public var flags:Vector.<FlagButton>;
		
		private var _panel:Shape;
		
		public function LocalesList()
		{
			flags = new Vector.<FlagButton>();
			super();
			y = panelData.height + 30;
			x = 4;
			_panel = new Shape();
			drawPanel();
			createFlags();
			addEventListener("selection", localeSelected);
		}
		
		private function drawPanel():void
		{
			var i:int = 0;
			var top:* = NaN;
			var j:int = 0;
			var rect:Rectangle = new Rectangle(9, 9, 1, 1);
			var gridX:Array = [rect.left, rect.right, panelData.width];
			var gridY:Array = [rect.top, rect.bottom, panelData.height];
			_panel.graphics.clear();
			var left:* = 0;
			for (i = 0; i < 3; )
			{
				top = 0;
				for (j = 0; j < 3; )
				{
					_panel.graphics.beginBitmapFill(panelData);
					_panel.graphics.drawRect(left, top, gridX[i] - left, gridY[j] - top);
					_panel.graphics.endFill();
					top = Number(gridY[j]);
					j++;
				}
				left = Number(gridX[i]);
				i++;
			}
			_panel.scale9Grid = rect;
			_panel.scaleX = 70 / panelData.width;
			_panel.scaleY = (Locales.list.length - 1) * 36 / panelData.height;
		}
		
		public function createFlags():void
		{
			var i:int = 0;
			var size:* = null;
			var bmpData:* = null;
			var fb:* = null;
			var locales:Array = Locales.list;
			for (i = 0; i < locales.length; )
			{
				size = new Point(flagsBitmapData.width / locales.length, flagsBitmapData.height);
				bmpData = new BitmapData(size.x, size.y);
				bmpData.copyPixels(flagsBitmapData, new Rectangle(size.x * i, 0, size.x, size.y), new Point(0, 0));
				fb = new FlagButton(bmpData, LocalesFactory.getLocale(locales[i]));
				flags.push(fb);
				i++;
			}
		}
		
		public function addFlags():void
		{
			var i:int = 0;
			var fb:* = null;
			addChild(_panel);
			var j:int = 0;
			for (i = 0; i < flags.length; )
			{
				fb = flags[i];
				if (fb.locale != Locale.current)
				{
					fb.x = 10;
					fb.y = 26 * j + 11;
					fb.selectorItem = false;
					fb.redraw(false);
					addChild(fb);
					j++;
				}
				i++;
			}
		}
		
		private function localeSelected(e:LocaleSelectionEvent):void
		{
			removeChildren();
		}
	}
}
