package com.hunterdouglas.common {

	/**
	 * CLASS NAME ::
	 * <p>DESCRIPTION :: </p>
	 */
	public class TextUtils {
		
		
		public static function removeNewlineChars(textToPrep:String):String {			
			textToPrep = textToPrep.replace('\n', '');
			return textToPrep;
		}
		
		public static function convertNonAlphaNumericCharacters(textToPrep:String, replacementString:String):String {
			var regExpToReplace:RegExp = /[^A-z0-9]/g
			textToPrep = textToPrep.replace(regExpToReplace, replacementString);	
			return textToPrep;
		}
		
		public static function convertEntityCharsAndRemoveNonAlphaNumericCharacters(textToPrep:String):String {
			textToPrep = prepTextForTextField(textToPrep);
			textToPrep = convertNonAlphaNumericCharacters(textToPrep, '_');
			return textToPrep;
		}
		
		public static function convertHtmlToCharsForRegularTextField(textToPrep:String):String {
			var regExpToReplace:RegExp = /<br>/gi
			textToPrep = textToPrep.replace(regExpToReplace, '\n');	
			regExpToReplace = /<br\/>/gi
			textToPrep = textToPrep.replace(regExpToReplace, '\n');	
			regExpToReplace = /<br \/>/gi
			textToPrep = textToPrep.replace(regExpToReplace, '\n');	
			return textToPrep;
		}
		
		public static function convertAmpersands(textToPrep:String):String {
			var regExpToReplace:RegExp = /&amp;/gi
			textToPrep = textToPrep.replace(regExpToReplace, '&');	
			return textToPrep;
		}
		
		public static function prepTextForAlphabeticalSort(textToPrep:String):String {
			textToPrep = prepTextForTextField(textToPrep);
			
			textToPrep = textToPrep.replace(String.fromCharCode(160), ' ');
			textToPrep = textToPrep.replace('é', 'e');
			
			return textToPrep;
		}
		
		public static function prepTextForTextField(textToPrep:String):String {
// TODO: NEED TO LOOK IN OPTIMIZING THIS FUNCTION

			// STRINGS TO CONVERT
			//&#8217;						TO '
			//&quot;	&#34;				TO "
			//&#174;    &reg;				TO 	®
			//&#8482;    &#153;    &trade; &#x2122;	TO	String.fromCharCode(8482)
			//&#233;    					TO	é
			//&eacute;						TO  é
			//&#151;						TO  —
			//&mdash;						TO  String.fromCharCode(8212)
			//&#160;	&nbsp;				TO  String.fromCharCode(160) "NON-BREAKING SPACE CHARACTER"

			var regExpToReplace:RegExp = /&reg;/g			
			textToPrep = textToPrep.replace(regExpToReplace, '®');
			regExpToReplace = /&#174;/g
			textToPrep = textToPrep.replace(regExpToReplace, '®');
			
			regExpToReplace = /&#8217;/g
			textToPrep = textToPrep.replace(regExpToReplace, "'");
			
			regExpToReplace = /&quot;/g
			textToPrep = textToPrep.replace(regExpToReplace, '"');
			regExpToReplace = /&#34;/g
			textToPrep = textToPrep.replace(regExpToReplace, '"');
			
			regExpToReplace = /&#233;/g
			textToPrep = textToPrep.replace(regExpToReplace, 'é');
			regExpToReplace = /&eacute;/g
			textToPrep = textToPrep.replace(regExpToReplace, 'é');
			
			regExpToReplace = /&#151;/g
			textToPrep = textToPrep.replace(regExpToReplace, '—');
			
			regExpToReplace = /&mdash;/g
			textToPrep = textToPrep.replace(regExpToReplace, String.fromCharCode(8212));
			
			regExpToReplace = /&trade;/gi
			textToPrep = textToPrep.replace(regExpToReplace, String.fromCharCode(8482));
			regExpToReplace = /&#8482;/g
			textToPrep = textToPrep.replace(regExpToReplace, String.fromCharCode(8482));
			regExpToReplace = /&#153;/g
			textToPrep = textToPrep.replace(regExpToReplace, String.fromCharCode(8482));
			regExpToReplace = /&#x2122;/gi
			textToPrep = textToPrep.replace(regExpToReplace, String.fromCharCode(8482));
			
			regExpToReplace = /&nbsp;/gi
			textToPrep = textToPrep.replace(regExpToReplace, String.fromCharCode(160));
			regExpToReplace = /&#160;/g
			textToPrep = textToPrep.replace(regExpToReplace, String.fromCharCode(160));
			
			return textToPrep;
			
		}
		public static function convertToTitleCase(_str:String):String
		{
			_str			= _str.toLowerCase();
			var a:String	= _str.slice(0, 1);
			var b:String	= _str.slice(1, _str.length);
			
			return a.toUpperCase()+b;
		}
		public static function isWhitespace( ch:String ):Boolean {
		  return ch == '\r' || 
				 ch == '\n' ||
				 ch == '\f' || 
				 ch == '\t' ||
				 ch == ' '; 
		}
		
		public static function trim( original:String ):String 
		{
		
		  var characters:Array = original.split( "" );
		
		  for ( var i:int = 0; i < characters.length; i++ ) {
			if ( isWhitespace( characters[i] ) ) {
			  characters.splice( i, 1 );
			  i--;
			} else {
			  break;
			}
		  }
		  return characters.join("");
		}
		
	}
}