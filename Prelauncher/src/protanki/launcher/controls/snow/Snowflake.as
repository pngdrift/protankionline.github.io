package protanki.launcher.controls.snow
{
   import flash.display.Sprite;
   
   public class Snowflake extends Sprite
   {
      
      private static var snow:Class = snowflake_png$31c20b36f0f6e286899f9387513dd6371091902523;
       
      
      public var xSpeed:Number;
      
      public var velocity:Number;
      
      public function Snowflake()
      {
         super();
         addChild(new snow());
      }
   }
}
