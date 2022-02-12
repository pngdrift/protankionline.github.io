package protanki.launcher.controls.selector
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import protanki.launcher.Locale;
	import protanki.launcher.controls.LocalizedControl;
	import protanki.launcher.controls.selector.flagbutton.FlagButton;
	import protanki.launcher.makeup.MakeUp;
	import flash.net.SharedObject;
	
	public class LocalizationSelector extends LocalizedControl
	{
		
		private static var panel:Class = selectorpanelWinter_png$188d409c39d472c6f6e8a83519a1da9e1716093543;
		
		private static var panelOld:Class = selectorpanelOld_png;
		
		private static var panelData:BitmapData = (new panel() as Bitmap).bitmapData;
		
		private static var panelDataOld:BitmapData = (new panelOld() as Bitmap).bitmapData;
		
		private static var drop:Class = dropWhite_png$19a52dc9d218f6db17116913f4475eed1680717623;
		
		private static var WIDTH:Number = 78;
		
		private static var HEIGHT:Number = 48;
		
		private var _localesList:LocalesList;
		
		private var _flag:FlagButton;
		
		private var _triangle:Bitmap;
		
		private var _triangleOpen:Bitmap;
		
		private var _panel:Shape;
		
		public function LocalizationSelector()
		{
			super();
			_panel = new Shape();
			_triangle = new drop();
			_triangleOpen = new drop();
			if (SharedObject.getLocal("launcherStorage").data["LAST_THEME"] == "ny")
			{
				
				_triangleOpen.transform.colorTransform = MakeUp.ICON_COLOR_TRANSFORM;
				
			}
			else
			{
				_triangleOpen.transform.colorTransform = MakeUp.ICON_COLOR_TRANSFORM_OLD;
				
			}
			
			_triangle.x = 47;
			_triangle.y = 18;
			_triangleOpen.x = _triangle.x;
			_triangleOpen.y = _triangle.y;
			createEvents();
		}
		
		private function createEvents():void
		{
			addEventListener("selection", addFlag);
			addEventListener("click", click);
			addEventListener("mouseOver", function(e:MouseEvent):void
			{
				Mouse.cursor = "button";
			});
			addEventListener("mouseOut", function(e:MouseEvent):void
			{
				Mouse.cursor = "auto";
			});
		}
		
		override protected function onResize(e:Event):void
		{
			x = stage.stageWidth - WIDTH - 7;
			y = 3;
			drawPanel();
			addChild(_panel);
			addChild(_triangle);
			addFlag();
		}
		
		private function drawPanel():void
		{
			
			var i:int = 0;
			var top:* = NaN;
			var j:int = 0;
			var rect:Rectangle = new Rectangle(9, 9, 26, 26);
			var gridX:Array = [rect.left, rect.right, panelData.width];
			var gridY:Array = [rect.top, rect.bottom, panelData.height];
			_panel.graphics.clear();
			var left:* = 0;
			for (i = 0; i < 3; )
			{
				top = 0;
				for (j = 0; j < 3; )
				{
					if (SharedObject.getLocal("launcherStorage").data["LAST_THEME"] == "ny")
					{
						
						_panel.graphics.beginBitmapFill(panelData);
						
					}
					else
					{
						_panel.graphics.beginBitmapFill(panelDataOld);
						
					}
					
					_panel.graphics.drawRect(left, top, gridX[i] - left, gridY[j] - top);
					_panel.graphics.endFill();
					top = Number(gridY[j]);
					j++;
				}
				left = Number(gridX[i]);
				i++;
			}
			_panel.scale9Grid = rect;
			_panel.scaleX = WIDTH / panelData.width;
			_panel.scaleY = HEIGHT / panelData.height;
		}
		
		public function redrawPanel():void
		{
			removeChild(_panel);
			
			var i:int = 0;
			var top:* = NaN;
			var j:int = 0;
			var rect:Rectangle = new Rectangle(9, 9, 26, 26);
			var gridX:Array = [rect.left, rect.right, panelData.width];
			var gridY:Array = [rect.top, rect.bottom, panelData.height];
			
			var left:* = 0;
			for (i = 0; i < 3; )
			{
				top = 0;
				for (j = 0; j < 3; )
				{
					if (SharedObject.getLocal("launcherStorage").data["LAST_THEME"] == "ny")
					{
						_panel.graphics.clear();
						_panel.graphics.beginBitmapFill(panelData);
						
					}
					else
					{
						_panel.graphics.clear();
						_panel.graphics.beginBitmapFill(panelDataOld);
						
					}
					
					_panel.graphics.drawRect(left, top, gridX[i] - left, gridY[j] - top);
					_panel.graphics.endFill();
					top = Number(gridY[j]);
					j++;
				}
				left = Number(gridX[i]);
				i++;
			}
			_panel.scale9Grid = rect;
			_panel.scaleX = WIDTH / panelData.width;
			_panel.scaleY = HEIGHT / panelData.height;
			addChild(_panel);
		}
		
		public function closeList():void
		{
			removeChildren();
			
			addChild(_panel);
			
			addChild(_flag);
			addChild(_triangle);
		}
		
		private function click(e:MouseEvent):void
		{
			if (numChildren > 3)
			{
				closeList();
			}
			else
			{
				addChild(_triangleOpen);
				localesList.addFlags();
				addChild(localesList);
			}
		}
		
		private function get localesList():LocalesList
		{
			if (_localesList == null)
			{
				_localesList = new LocalesList();
			}
			return _localesList;
		}
		
		private function addFlag(e:LocaleSelectionEvent = null):void
		{
			var locale:* = null;
			for each (var flag in localesList.flags)
			{
				locale = e == null ? Locale.current : e.locale;
				if (flag.locale == locale)
				{
					_flag = flag;
					_flag.x = 14;
					_flag.y = 15;
					_flag.selectorItem = true;
					_flag.redraw(false);
					addChild(flag);
					break;
				}
			}
		}
	}
}
