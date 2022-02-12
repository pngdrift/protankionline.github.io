package protanki.launcher.controls.background
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
     import protanki.launcher.storage.Storage;
	  import flash.net.SharedObject;

  
		
  
   
   public class Background extends Sprite
   {
      
      private static var background:Class = background_ny_png$400d91fcc7fd6ddbb7d11764bc4d663a857417216;
	  
	  private static var backgroundOld:Class = background_old_png;
	  
	  
	   private var bitmap:Bitmap;
	   
	   private var bitmapOld:Bitmap;
          private static var sharedObject:SharedObject = SharedObject.getLocal("launcherStorage");
		 
      
      public function Background()
      {
         super();
         addEventListener("addedToStage",addedToStage);
      }
      
      private function addedToStage(e:Event) : void
      {
		 
         this.bitmap = new Bitmap(new background().bitmapData);
		  this.bitmapOld = new Bitmap(new backgroundOld().bitmapData);
         this.bitmap.scaleX = stage.stageWidth / bitmap.width;
         this.bitmap.scaleY = bitmap.scaleX;
		 this.bitmapOld.scaleX = stage.stageWidth / bitmap.width;
         this.bitmapOld.scaleY = bitmap.scaleX;
		 var themecash:String =  sharedObject.data["LAST_THEME"];
		 if (themecash == "ny")
	  {
         addChild(this.bitmap);
		 sharedObject.data["LAST_THEME"] = "ny";
	  }
	  else if (themecash == "old")
	  {
		   addChild(this.bitmapOld);
		   sharedObject.data["LAST_THEME"] = "old";
	  }
	  else
	  {
         addChild(this.bitmap);
		 sharedObject.data["LAST_THEME"] = "ny";
	  }
	  removeEventListener("addedToStage",addedToStage);
         addEventListener("removedFromStage",removedFromStage);
      }
      
      private function removedFromStage(e:Event) : void
      {
         removeEventListener("removedFromStage",removedFromStage);
         addEventListener("addedToStage",addedToStage);
      }
	        public function changeTheme() : void
      {
         if (sharedObject.data["LAST_THEME"] == "ny")
		 {
	
			 addChild(this.bitmapOld);
			 removeChild(this.bitmap);
			 sharedObject.data["LAST_THEME"] = "old";
		 }
		 else if (sharedObject.data["LAST_THEME"] == "old")
		 {
			  sharedObject.data["LAST_THEME"] = "ny";
			  removeChild(this.bitmapOld);
			 	 addChild(this.bitmap);

				
			 			
      }
   }
}
}