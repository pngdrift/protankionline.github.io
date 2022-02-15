package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author AIvaz
	 */
	public class Main extends Sprite
	{
		      private var textField:TextField;
		
		public function Main()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			this.textField = new TextField();
			this.textField.embedFonts = true;
			
			this.textField.textColor = 0;
			this.textField.text = "trd";
			addChild(this.textField);
		}
	
	}

}