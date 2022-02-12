package protanki.launcher.controls.selector
{
   import flash.events.Event;
   import protanki.launcher.Locale;
   
   public class LocaleSelectionEvent extends Event
   {
      
      public static const SELECTION:String = "selection";
       
      
      public var locale:Locale;
      
      public function LocaleSelectionEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}
