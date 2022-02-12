package protanki.launcher.controls.bottompanel.LinkField
{
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	import protanki.launcher.Locale;
	import protanki.launcher.makeup.MakeUp;
	
	public class LinkField extends TextField
	{
		
		public static const ABOUT:String = "aboutCompany";
		
		public static const TECHSUPPORT:String = "techSupport";
		
		public static const EMAIL:String = "email";
		
		public static const RULES:String = "rules";
		
		public static const KITS:String = "kits";
		
		public static const CONTACTS:String = "contacts";
		
		public static const CONFIDENT:String = "confidentialityPolicy";
		
		public static const LICENSE:String = "license";
		
		private const TEXT_COLOR:uint = 16777215;
		
		private var textFormat:TextFormat;
		
		private var link:String;
		
		private var fieldType:String;
		
		public function LinkField(type:String, _locale:Locale = null)
		{
			textFormat = new TextFormat();
			super();
			var locale:Locale = _locale == null ? Locale.current : _locale;
			if (locale[type] == null)
			{
				return;
			}
			textFormat.font = MakeUp.getFont(locale);
			textFormat.size = 13;
			fieldType = type;
			autoSize = "left";
			selectable = false;
			textColor = 16777215;
			embedFonts = true;
			if (locale[type].link != "")
			{
				textFormat.underline = true;
				link = locale[type].link;
				addEventListener("click", onMouseClick);
				addEventListener("mouseOver", onMouseOver);
				addEventListener("mouseOut", onMouseOut);
			}
			defaultTextFormat = textFormat;
			text = locale[type].text;
		}
		
		private function onMouseOver(e:MouseEvent):void
		{
			Mouse.cursor = "button";
		}
		
		private function onMouseOut(e:MouseEvent):void
		{
			Mouse.cursor = "auto";
		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			navigateToURL(new URLRequest(link));
		}
	}
}
