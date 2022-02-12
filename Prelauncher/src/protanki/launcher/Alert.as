package protanki.launcher
{
   import flash.html.HTMLLoader;
   
   public class Alert
   {
      
      private static const html:String = "<!DOCTYPE html><html><head><meta charset=\'utf-8\'><title>ProTanki</title><script></script></head><body></body></html>";
      
      private static var htmlLoader:HTMLLoader;
       
      
      public function Alert()
      {
         super();
      }
      
      public static function showMessage(message:String) : void
      {
         if(htmlLoader == null)
         {
            htmlLoader = new HTMLLoader();
            htmlLoader.loadString("<!DOCTYPE html><html><head><meta charset=\'utf-8\'><title>ProTanki</title><script></script></head><body></body></html>");
         }
         htmlLoader.window.alert(message);
      }
   }
}
