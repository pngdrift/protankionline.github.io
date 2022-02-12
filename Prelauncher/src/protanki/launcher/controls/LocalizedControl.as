package protanki.launcher.controls
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import protanki.launcher.Locale;
   
   public class LocalizedControl extends Sprite
   {
       
      
      public function LocalizedControl()
      {
         super();
         addEventListener("addedToStage",addedToStage);
      }
      
      private function addedToStage(e:Event) : void
      {
         removeEventListener("addedToStage",addedToStage);
         addEventListener("removedFromStage",removedFromStage);
         addEventListener("resize",onResize);
         onResize(null);
      }
      
      private function removedFromStage(e:Event) : void
      {
         removeEventListener("removedFromStage",removedFromStage);
         removeEventListener("resize",onResize);
      }
      
      protected function onResize(e:Event) : void
      {
      }
      
      public function switchLocale(locale:Locale) : void
      {
      }
      
      protected function addChildToCenter(child:DisplayObject) : void
      {
         addChild(child);
         child.x = -child.width >> 1;
         child.y = -child.height >> 1;
      }
   }
}
