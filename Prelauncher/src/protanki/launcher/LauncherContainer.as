package protanki.launcher
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class LauncherContainer extends Sprite
   {
       
      
      private var prelauncher:Prelauncher;
      
      public function LauncherContainer(tanksLauncher:DisplayObject, prelauncher:Prelauncher)
      {
         super();
         this.prelauncher = prelauncher;
         addChild(tanksLauncher);
      }
      
      public function closeLauncher() : void
      {
         prelauncher.closeLauncher();
      }
   }
}
