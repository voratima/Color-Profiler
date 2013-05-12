package com.hunterdouglas.photogallery
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.*;
   
	import flash.utils.getDefinitionByName;
	import com.hunterdouglas.common.TextUtils;
	
	public class HDComboBoxItem extends Sprite {

		private var btnMC:HDComboBoxItemMC;
		private var overColor:uint = 0xFFFFFF;
		private var outColor:uint = 0x212121;
		private var selectColor:uint = 0x4D9DB9;

		private var txt:TextField;
		private var myriad:String = "Myriad Pro";
		
		public var label:String;
		public var nameForAlphabeticalSort:String;
		public var id:uint;
		

		public function HDComboBoxItem(_prop:Object):void
		{
			btnMC = new HDComboBoxItemMC();
			btnMC.background.gotoAndStop(1);
			if(_prop.width != undefined)
			{
				btnMC.background.width = _prop.width;
			}
			if(_prop.height != undefined)
			{
				btnMC.background.height = _prop.height;
			}
			label 	= _prop.text;
			id		= _prop.id;
			
			txt 			= new TextField();
			txt.x 			= 2;
			txt.y 			= 1;
			txt.width 		= 10;
			txt.height 		= 30;
			txt.selectable 	= false;
			txt.textColor 	= outColor;
			txt.embedFonts	= true;
			txt.autoSize 	= TextFieldAutoSize.LEFT;
			txt.antiAliasType = AntiAliasType.ADVANCED;
			btnMC.addChild(txt);
			
			setTextField(_prop.text);
			addChild(btnMC);
			buttonMode = true;
			mouseChildren = false;
			
			addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
			addEventListener(MouseEvent.CLICK, mouseClickHandler);
			
		}
		private function mouseOverHandler(event:MouseEvent):void
		{	
			btnMC.background.gotoAndStop("over_stop");
			txt.textColor = overColor;
		}
		private function mouseOutHandler(event:MouseEvent):void
		{
			btnMC.background.gotoAndStop("out_stop");
			txt.textColor = outColor;
		}
		private function mouseClickHandler(event:MouseEvent):void
		{
			dispatchEvent(new HDComboBoxEvent(HDComboBoxEvent.SELECTED, true, false, label, id));
		}
		private function setTextField(_text:String):void
		{
			//trace("setTextField: "+_text);
			
			txt.htmlText = TextUtils.prepTextForTextField(TextUtils.convertAmpersands(_text));//_text;
			nameForAlphabeticalSort = TextUtils.prepTextForAlphabeticalSort(_text);
			var newFormat:TextFormat = new TextFormat();
			newFormat.font = myriad;
			newFormat.size = 12;
			txt.setTextFormat(newFormat);
			
		}
		public function setLabel(_text:String):void
		{
			setTextField(_text);
			label = _text;
		}
	}
}