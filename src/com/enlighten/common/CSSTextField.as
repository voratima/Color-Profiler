package com.enlighten.common{
	import flash.text.*;
	//
	import com.enlighten.utils.XmlUtils;
	//
	//
	public class CSSTextField extends TextField {
		//
		public static var defaultStyle:StyleSheet;
		private var xml:*;
		//
		//
		public function CSSTextField(	_css:StyleSheet,
										_text:*				= "",
										_anti:String		= AntiAliasType.ADVANCED,
										_embed:Boolean		= true,
										_multi:Boolean		= true,
										_mouse:Boolean		= false,
										_select:Boolean		= false,
										_condWhite:Boolean	= false,
										_wrap:Boolean		= true
									) {
			//
			super();
			styleSheet		= _css;
			antiAliasType	= _anti;
			embedFonts		= _embed;
			multiline		= _multi;
			selectable		= _select;
			mouseEnabled	= _mouse;
			condenseWhite	= _condWhite;
			wordWrap		= _wrap;
			xml				= _text;
			//border			= true;
			//
			if(typeof(xml)=="xml" && String(xml.@cssClass).length>0)
			{
				//trace("XML: "+xml.@cssClass+" css: "+xml);
				htmlText 		= '<p class="'+xml.@cssClass+'">'+xml+'</p>'; 			
			}else{
				htmlText 		= xml; 			
			}
		}
		//
		public function setHtmlText( text:String ):void {
			htmlText = text;
		}
		//
		public function alignTextToXML( xml:XML, defaultWidth:Number ):void {
			// Adjust width of text block if there is an override (defaults to button background width)
			if ( XmlUtils.paramExists( xml.@width ) ) {			// SET WIDTH OVERRIDE IF EXISTS
				width = Number( xml.@width );
				
			}
			else if ( defaultWidth > 0 ) {						// ELSE SET WIDTH TO DEFAULT WIDTH
				width =  defaultWidth;
			}
			// Adjust vertical position
			if ( XmlUtils.paramExists( xml.@baselineShift ) ) {	// SET Y OFFSET IF EXISTS
				y = Number( xml.@baselineShift );
			}
			// Apply Align param (has to be done after other adjustments)
			if ( XmlUtils.paramExists( xml.@align ) ) {
				switch ( String( xml.@align ).toLowerCase() ) {
					case TextFieldAutoSize.LEFT:
					case TextFieldAutoSize.CENTER:
					case TextFieldAutoSize.RIGHT:
					case TextFieldAutoSize.NONE:				// SET ALIGN TO XML PARAM
						wordWrap		= false;
						autoSize = String( xml.@align ).toLowerCase();
						break;
					default:									// IF PARAM CANT BE INTERPRETED DEFAULT TO CENTER
						autoSize = TextFieldAutoSize.CENTER;
						break;
				}
			}
			else {
				autoSize = TextFieldAutoSize.LEFT;				// IF NO PARAM, DEFAULT TO CENTER
			}
			// Adjust horizontal position
			if ( XmlUtils.paramExists( xml.@x ) ) {				// SET X OFFSET IF EXISTS
				x = Number( xml.@x );
			}
			// Adjust vertical position
			if ( XmlUtils.paramExists( xml.@y ) ) {				// SET X OFFSET IF EXISTS
				y = Number( xml.@y );
			}
		}
		public function setSharpness(_sharpness:Number, _thickness:Number):void
		{
			sharpness	= _sharpness;
			thickness	= _thickness;
		}
		public function set selected(_val:Boolean):void
		{
			if(typeof(xml)=="xml" && String(xml.@cssClass).length>0)
			{
				var style:Object;
				if(_val)
				{
					style	= styleSheet.getStyle("."+xml.@cssClass+"Selected");				
					htmlText 		= '<p class="'+xml.@cssClass+'Selected">'+xml+'</p>';
				}else{
					style	= styleSheet.getStyle("."+xml.@cssClass);
					htmlText 		= '<p class="'+xml.@cssClass+'">'+xml+'</p>'; 			
				}
				setSharpness(style.sharpness, style.thickness);
			}
			
		}
		/*
		public function set over(_val:Boolean):void
		{
			var style:Object	= styleSheet.getStyle("."+xml.@cssClass+"Over");
			if(typeof(xml)=="xml" && String(xml.@cssClass).length>0 && style.color!=undefined)
			{
				if(_val)
				{
					trace("STYEEEEEEEEEEEEE "+style.color);
					textColor	= style.color;
					//htmlText 		= '<p class="'+xml.@cssClass+'Over">'+xml+'</p>';
				}else{
					style	= styleSheet.getStyle("."+xml.@cssClass);
					textColor	= style.color;
					//htmlText 		= '<p class="'+xml.@cssClass+'">'+xml+'</p>'; 			
				}
				//setSharpness(style.sharpness, style.thickness);
			}
			
		}*/
	}
}