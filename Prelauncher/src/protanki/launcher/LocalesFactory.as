package protanki.launcher
{
   import flash.utils.Dictionary;
   import protanki.launcher.locales.EN.LocaleEn;
   import protanki.launcher.locales.RU.LocaleRU;
      import protanki.launcher.locales.BR.LocaleBR;
   
   public class LocalesFactory
   {
      
      private static var locales:Dictionary = new Dictionary();
      
      {
         locales["ru"] = new LocaleRU();
         locales["en"] = new LocaleEn();
		 locales["br"] = new LocaleBR();
      }
      
      public function LocalesFactory()
      {
         super();
      }
      
      public static function getLocale(locale:String) : Locale
      {
         if(locales[locale] == null)
         {
            return locales["ru"];
         }
         return locales[locale];
      }
   }
}
