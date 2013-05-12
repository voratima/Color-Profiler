package com.enlighten.common
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
/*
	import com.enlighten.utils.AssetsManager;
	
	import com.hunterdouglas.imagine.*;
	import com.hunterdouglas.imagine.assets.HDIMagineThumbnail;	
	import com.hunterdouglas.imagine.ui.XmlButton;
	import com.hunterdouglas.imagine.events.UIEvent;
	import com.hunterdouglas.imagine.views.HDIMagineInfoPanelButton;*/
	/*	import com.hunterdouglas.common.*;
import com.hunterdouglas.imagine.ui.HDIMagineVScroll;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	*/
	
	public class ENLTextField extends Sprite
	{
		private var value:String;
		private var cssOpenTag:String;
		private var cssCloseTag:String;
		private var css:StyleSheet;
		private var label:TextField;
		public var background:Box;
		//public var w0:int;
		public var maxChars:int;
		
		var overColor:uint	= 0x5b5b5b;
		var outColor:uint	= 0x80541e;
		var downColor:uint	= 0xFFFFFF;
		
		public static const EDIT:String		= "edit";
		public static const SELECT:String	= "select";
		public static const DELETE:String	= "delete";
		
		public function ENLTextField(_css:StyleSheet, _value:String, _cssOpenTag:String, _cssCloseTag:String, _maxChars:int=20):void
		{
			css				= _css;
			value			= _value;
			cssOpenTag		= _cssOpenTag;
			cssCloseTag		= _cssCloseTag;
			//w0			= _wo;
			maxChars	= _maxChars;
			
			initLabel();
			
			background = new Box(label.width, label.height, 0x3399ff, 0);
			addChild(background);
			
			mouseChildren	= false;
			
			//addEventListener(MouseEvent.MOUSE_UP, handlerMouseUp);
			//addEventListener(MouseEvent.MOUSE_DOWN, handlerMouseDown);
		}
		public function set textColor(_color:uint):void
		{
			label.textColor	= _color;
		}
		private function handlerMouseOver(e:MouseEvent):void
		{
			dispatchEvent(new ENLToolTipEvent(ENLToolTipEvent.SHOW_TOOLTIP, true, true, 
				{
						label:cssOpenTag + value + cssCloseTag
					,	x:x
					,	y:y
				}));
		}
		private function handlerMouseOut(e:MouseEvent):void
		{
			//dispatchEvent(new ENLToolTipEvent(ENLToolTipEvent.HIDE_TOOLTIP, true, true));
		}
		private function initLabel():void
		{
			label				= new TextField();
			label.styleSheet	= css;
			//label.border		= true;
			label.embedFonts 	= true;
			label.autoSize		= TextFieldAutoSize.LEFT;
			label.antiAliasType	= AntiAliasType.ADVANCED;
			//label.sharpness	= -200;
			//label.thickness	= 100;
			label.selectable	= false;
			
			setContent(value);

			addChild(label);
		}
		public function setContent(_value:String):void
		{
			value				= TextUtils.prepTextForTextField(_value);
			
			var str:String		=  value;
			var i:int			= -1;
			
			setLabel(str);
			if(label.width>maxChars)
			{
				str	= "";
				setLabel(str);
				while(label.width<maxChars)
				{
					i++;
					str	+= value.charAt(i);
					setLabel(str);
				}
				setLabel(str.slice(0, str.length-1)+"...");
				
				buttonMode		= true;			
				addEventListener(MouseEvent.MOUSE_OVER, handlerMouseOver);
				addEventListener(MouseEvent.MOUSE_OUT, handlerMouseOut);			
			}else{
				setLabel(str);
				buttonMode		= false;
				removeEventListener(MouseEvent.MOUSE_OVER, handlerMouseOver);
				removeEventListener(MouseEvent.MOUSE_OUT, handlerMouseOut);
			}
		}
		public function setLabel(_str:String):void
		{
			//label.htmlText		= '<p class="uploadPhotoName"><b>'+_str+'</b></p>';
			label.htmlText			= cssOpenTag + _str + cssCloseTag;
		}
	}
}