package com.enlighten.common {
	import flash.text.*;
	import flash.display.*;
	import flash.events.*;

	public class Utils {
		
		
		public static function removeAllDisplayChildren(contentMc:MovieClip) {
			if (contentMc != null && contentMc.numChildren > 0) {
				for (var a:uint=contentMc.numChildren; contentMc.numChildren > 0; a--) {
					contentMc.removeChildAt(a-1);
				}
			}
		}
		
		
		public static function formatTextField(txtField:TextField, fontName:String, fontSize:Number, fontColor:Number, makeBold:Boolean = false, useAdvancedAntiAliasSetting:Boolean = true, textFormatAlign:String = "left", specialLetterSpacing:Number = 0.0, multilineParam:Boolean = true) {
			txtField.selectable = false;
			txtField.textColor = fontColor;
			txtField.embedFonts = true;
			if (useAdvancedAntiAliasSetting) txtField.antiAliasType = AntiAliasType.ADVANCED;
			
			txtField.multiline = multilineParam;
			txtField.wordWrap = multilineParam;
			
			var newTextFormat:TextFormat = new TextFormat();
			newTextFormat.font = fontName;
			newTextFormat.size = fontSize;
			newTextFormat.align = textFormatAlign;
			newTextFormat.bold = makeBold;
			newTextFormat.letterSpacing = specialLetterSpacing;
			
			if (useAdvancedAntiAliasSetting) {
				var myAntiAliasSettings:CSMSettings = new CSMSettings(fontSize, 0.7, -0.7);
				var myAliasTable:Array = new Array(myAntiAliasSettings);
				if (makeBold) TextRenderer.setAdvancedAntiAliasingTable(fontName, FontStyle.BOLD, TextColorType.DARK_COLOR, myAliasTable);
				else TextRenderer.setAdvancedAntiAliasingTable(fontName, FontStyle.REGULAR, TextColorType.DARK_COLOR, myAliasTable);	
			}
			
			txtField.defaultTextFormat = newTextFormat;
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
			
			
			//&trade &#8482; &#153; &#x2122;	TO 	™
			//<sup>&reg;</sup>				TO 	®
			//&#150;						TO  –

			var regExpToReplace:RegExp = /<sup>&reg;<\/sup>/g			
			textToPrep = textToPrep.replace(regExpToReplace, '®');
			regExpToReplace = /&reg;/g
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
			
			regExpToReplace = /&#150;/g
			textToPrep = textToPrep.replace(regExpToReplace, '–');
			
			return textToPrep;
			
		}
		public static function randRange(minNum:Number, maxNum:Number):Number
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
	}
}