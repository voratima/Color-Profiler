/**
 * @author Rick Witten
 * Useful functions for xml processing
 */
package com.enlighten.utils {
	//
	public class XmlUtils {
		public function XmlUtils():void {
			
		}
		static public function tagExists( xml:XMLList ):Boolean {
			return ( xml[0] && (( xml[0] > "" ) || ( xml[0].attributes().length() > 0 )));
		}
		static public function paramExists( testParam:String ):Boolean {
			//trace( "XmlUtils: paramExists: " + testParam + " : " + ( testParam > "" ));
			return ( testParam > "" );
		}
		static public function textWithoutTags( textStr:String, startToken:String = "![CDATA[", endToken:String = "]]" ):String {
			var start:int	= textStr.indexOf( startToken ) + startToken.length;
			var end:int		= textStr.indexOf( endToken );
			textStr	= textStr.substring( start, end );
			var result:String = "";
			var isTag:Boolean = false;
			//
			for (var i:int = 0; i < textStr.length; i++) {
				if		( !isTag && textStr.substr( i, 1 ) == "<"	)	{	isTag = true;						}
				else if (  isTag && textStr.substr( i, 1 ) == ">"	)	{	isTag = false;						}
				else if ( !isTag 									)	{	result += textStr.substr( i, 1 );	}
			}
			return result;
		}
		static public function htmlTagFromCdata( textStr:String, startToken:String = "![CDATA[", endToken:String = "]]" ):String {
			var result:String = "";
			//
			/* Trim search string to CData or user-supplied token */
			var start:int	= textStr.indexOf( startToken ) + startToken.length;
			var end:int		= textStr.indexOf( endToken );
			textStr			= textStr.substring( start, end );
			//
			var cssClass:String = null;
			var face:String = null;
			var size:String = null;
			var color:String = null;
			//
			var classes:Array = textStr.match(/class\s*=\s*["'](.[^"']*)["']/);
			// array is null if no matches found:
			if ( classes != null ) cssClass = classes[1];
			//
			var faces:Array = textStr.match(/face\s*=\s*["'](.[^"']*)["']/)
			if ( faces != null ) face = faces[1];
			//
			var sizes:Array = textStr.match(/size\s*=\s*["'](\d{1,})["']/);
			if ( sizes != null ) size = sizes[1];
			//
			var colors:Array = textStr.match(/color\s*=\s*["'](.[^"']*)["']/);
			if ( colors != null ) color = colors[1];
			//
			return cssClass;
		}
		static public function setFilterParams( params:XML, defaultObj:Object = null ):Object {
			var result:Object= (defaultObj != null ) ? defaultObj:new Object();
			result.color	= (paramExists(params.@color ))		? uint( params.@color )		:((defaultObj!=null) ? defaultObj.color	: 0x000000);
			result.alpha	= (paramExists(params.@alpha ))		? Number( params.@alpha )	:((defaultObj!=null )? defaultObj.alpha	: 1);
			result.blurX	= (paramExists(params.@blurX ))		? Number( params.@blurX )	:((defaultObj!=null )? defaultObj.blurX	: 1);
			result.blurY	= (paramExists(params.@blurY ))		? Number( params.@blurY )	:((defaultObj!=null )? defaultObj.blurY	: 1);
			result.strength	= (paramExists(params.@strength))	? Number( params.@strength ):((defaultObj!=null )? defaultObj.strength:3);
			result.quality	= (paramExists(params.@quality ))	? int( params.@quality )	:((defaultObj!=null) ? defaultObj.quality:3);
			result.inner	= (paramExists(params.@inner )) 	? ( params.@inner)			:((defaultObj!=null )? defaultObj.inner	: false);
			result.knockout	= (paramExists(params.@knockout))	? ( params.@knockout)		:((defaultObj!=null )? defaultObj.knockout:false);
			//
			return result;
		}
	}
}