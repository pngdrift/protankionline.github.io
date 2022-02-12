package protanki.launcher.controls.snow
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.ColorTransform;
   import flash.utils.Timer;
              import flash.net.SharedObject;

		 
   public class Snow extends MovieClip
   {
       
      
      private var speed:int;
      
      private var flakes:Vector.<Snowflake>;
      
      private var timer:Timer;
      
      public function Snow(speed:int = 3, flakesNumber:* = 100)
      {
         var i:int = 0;
         var flake:* = null;
         flakes = new Vector.<Snowflake>();
         timer = new Timer(2000);
         super();
         this.speed = speed;
         for(i = 0; i < flakesNumber; )
         {
            flake = new Snowflake();
            configureFlake(flake);
            addChild(flake);
            flakes.push(flake);
            i++;
         }
         addEventListener("addedToStage",addedToStage);
         addEventListener("enterFrame",fall);
         addEventListener("removedFromStage",removedFromStage);
         timer.addEventListener("timer",changeMovement);
         timer.start();
      }
      
      private function addedToStage(e:Event) : void
      {
         removeEventListener("addedToStage",addedToStage);
         onResize(null);
      }
      
      private function removedFromStage(e:Event) : void
      {
         removeEventListener("enterFrame",fall);
         removeEventListener("removedFromStage",removedFromStage);
      }
      
      private function configureFlake(flake:Snowflake) : void
      {
         flake.velocity = Math.random() * speed;
         flake.xSpeed = Math.random();
         flake.scaleX = flake.scaleY = Math.random();
		 			 		   		 	 					       	  	           if (SharedObject.getLocal("launcherStorage").data["LAST_THEME"] == "ny")
		 {
	
     var alpha:Number = Math.random() + 0.2;
		 

		 }
		 else{
     var alpha:Number = 0;
		
     
         }
    
         flake.transform.colorTransform = new ColorTransform(0,0,0,alpha,255,255,255,0);
      }

      private function fall(e:Event) : void
      {
         for each(var flake in flakes)
         {
            flake.x += flake.xSpeed;
            flake.y += flake.velocity;
            if(flake.y > stage.stageHeight)
            {
               flake.x = Math.random() * stage.stageWidth;
               flake.y = -flake.height;
               configureFlake(flake);
            }
         }
      }
      
      private function changeMovement(e:TimerEvent) : void
      {
         for each(var flake in flakes)
         {
            flake.xSpeed *= -Math.random();
         }
      }
      
      private function onResize(e:Event) : void
      {
         for each(var flake in flakes)
         {
            flake.x = Math.random() * stage.stageWidth;
            flake.y = Math.random() * stage.stageHeight;
         }
      }
   }

}