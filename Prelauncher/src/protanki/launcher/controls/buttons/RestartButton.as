package protanki.launcher.controls.buttons
{
   import flash.events.Event;
   import protanki.launcher.Locale;
   import protanki.launcher.makeup.MakeUp;
   
   public class RestartButton extends Button
   {
      
      private static var buttonBlue:Class = buttonBlue_png;
      private static var buttonBlueOver:Class = buttonBlueOver_png;
       
      
      public function RestartButton(onClick:Function)
      {
         super(onClick,new buttonBlue(),new buttonBlueOver());
         addEventListener("addedToStage", addedToStage);
		  scaleX = scaleY = 1;
      }
      
      private function addedToStage(e:Event) : void
      {
         textField.textColor = 6681343;
      }
      
      override public function switchLocale(locale:Locale) : void
      {
         textField.text = " ";
         textFieldToCenter();
      }
      
      override protected function onResize(e:Event) : void
      {
         x = 50;
         y = (stage.stageHeight >> 1) + 255;
      }
   }
}
