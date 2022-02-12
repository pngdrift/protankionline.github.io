package protanki.launcher.controls.logo
{
   import flash.events.Event;
   import protanki.launcher.Locale;
   import protanki.launcher.controls.LocalizedControl;
   	  import flash.net.SharedObject;

	  

   public class Logo extends LocalizedControl
   {
      
      private static var logo:Class = winterLogo_png$15a1fedf0de435ebeb95af041dfab70137682485;
	  
	  private static var logoOld:Class = logo_png;
	  
	    private static var sharedObject:SharedObject = SharedObject.getLocal("launcherStorage");
       
      
      public function Logo()
      {
         super();
      }
      
      override public function switchLocale(locale:Locale) : void
      {
            	  	           if (sharedObject.data["LAST_THEME"] == "ny")
		 {
	
			   removeChildren();
         addChildToCenter(new logo());

		 }
		 else{
			 	   removeChildren();
         addChildToCenter(new logoOld());

		 }
      }
	  
	      public function switchTheme() : void
      {
     	  	           if (sharedObject.data["LAST_THEME"] == "ny")
		 {
	
			   removeChildren();
         addChildToCenter(new logoOld());

		 }
		 else{
			 	   removeChildren();
         addChildToCenter(new logo());

		 }
		 }
		 
   
      
      
      override protected function onResize(e:Event) : void
      {
         x = stage.stageWidth >> 1;
         y = stage.stageHeight / 3.5;
      }
   }
}
