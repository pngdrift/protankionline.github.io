package protanki.launcher.storage
{
   import flash.filesystem.File;
   import flash.filesystem.FileStream;
   import protanki.launcher.storage.Storage;
   import protanki.launcher.Locale;
   import protanki.launcher.LocalesFactory;
   import flash.net.SharedObject;
   import protanki.launcher.locales.Locales;
   
   public class Storage
   {
      
      private static const DISPLAY_STATE:String = "display.bin";
      
      private static const LAST_LOCALE:String = "LAST_LOCALE";
      
      private static const LAST_SERVER:String = "LAST_SERVER";
      
      private static const DEFAULT_STATE:DisplayState = new DisplayState(100,100,1024,768,false);
      
      private static var sharedObject:SharedObject = SharedObject.getLocal("launcherStorage");
       
      
      public function Storage()
      {
         super();
      }
      
      private static function getProperty(name:String) : Object
      {
         return !!sharedObject.data.hasOwnProperty(name) ? sharedObject.data[name] : null;
      }
      
      public static function set lastSessionLocale(value:int) : void
      {
         sharedObject.data["LAST_LOCALE"] = value;
         sharedObject.flush();
      }
	        public static function set lastSessionTheme(value:String) : void
      {
         sharedObject.data["LAST_THEME"] = value;
         sharedObject.flush();
      }
      
      public static function setBattleServer(value:int) : void
      {
         sharedObject.data["LAST_SERVER"] = value;
         sharedObject.flush();
      }
      
      public static function setDisplayState(x:int, y:int, width:int, height:int, isInFullscreen:Boolean) : void
      {
         var fileStream:* = null;
         var file:File = File.applicationStorageDirectory.resolvePath("display.bin");
         try
         {
            (fileStream = new FileStream()).open(file,"write");
            fileStream.writeInt(x);
            fileStream.writeInt(y);
            fileStream.writeInt(width);
            fileStream.writeInt(height);
            fileStream.writeBoolean(isInFullscreen);
            fileStream.close();
         }
         catch(e:Error)
         {
            trace(e.message);
         }
      }
      
      public static function getLastSessionLocale(defaultLocale:Locale) : Locale
      {
         var localeIndex:Object = getProperty("LAST_LOCALE");
         return localeIndex == null ? defaultLocale : LocalesFactory.getLocale(Locales.list[int(localeIndex)]);
      }
      
      public static function getDisplayState() : DisplayState
      {
         var fileStream:* = null;
         var file:File = File.applicationStorageDirectory.resolvePath("display.bin");
         if(!file.exists)
         {
            return DEFAULT_STATE;
         }
         var state:DisplayState = null;
         try
         {
            fileStream = new FileStream();
            fileStream.open(file,"read");
            state = new DisplayState(fileStream.readInt(),fileStream.readInt(),fileStream.readInt(),fileStream.readInt(),fileStream.readBoolean());
            fileStream.close();
         }
         catch(e:Error)
         {
            state = DEFAULT_STATE;
         }
         finally
         {
            return state;
         }
      }
   }
}
