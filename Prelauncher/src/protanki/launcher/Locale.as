package protanki.launcher
{
	import protanki.launcher.locales.TextLinkPair;
	
	public class Locale
	{
		
		public static var current:Locale;
		
		public var partners:Array;
		
		public var playText:String;
		
		public var exitText:String;
		
		public var rules:TextLinkPair;
		
		public var kits:TextLinkPair;
		
		public var game:TextLinkPair;
		
		public var materials:TextLinkPair;
		
		public var tournaments:TextLinkPair;
		
		public var forum:TextLinkPair;
		
		public var wiki:TextLinkPair;
		
		public var ratings:TextLinkPair;
		
		public var contacts:TextLinkPair;
		
		public var help:TextLinkPair;
		
		public var name:String;
		
		public function Locale()
		{
			partners = [];
			super();
		}
	}
}
