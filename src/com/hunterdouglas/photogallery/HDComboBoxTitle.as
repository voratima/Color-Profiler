package com.hunterdouglas.photogallery
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import flash.text.*;
	
	import com.hunterdouglas.common.Box;
	import com.hunterdouglas.common.TextUtils;
	
	public dynamic class HDComboBoxTitle extends Sprite {
		private const BTN_X_OFFSET:uint = 2;
		private const BTN_Y_OFFSET:uint = 2;
		
		private var title:Box;
		private var btn:MovieClip;
		private var titleItem:HDComboBoxTitleMC;//HDComboBoxItem;
		
		private var label:String;
		private var defaultTitle:String;
		private var txt:TextField;
		private var myriadSemibold:String = "Myriad Pro Light";
		private var overColor:uint = 0xFFFFFF;
		private var outColor:uint = 0x212121;
		private var selectColor:uint = 0x4D9DB9;
		
		public function HDComboBoxTitle(_direction:String, _prop:Object = undefined, _font:String = "Myriad Pro Light")//container:MovieClip, 
		{
			//	trace("HDComboBoxTitle:");
			//TITLE INIT
			defaultTitle = _prop.text;
			
			title = new Box(_prop.backgroundWidth, _prop.backgroundHeight, _prop.backgroundColor, _prop.backgroundAlpha, _prop.border, _prop.borderColor, _prop.borderAlpha);
			if(_direction == HDComboBox.DROP_UP){
				btn = new HDComboBoxTitleUp();
			}
			else
			{
				btn = new HDComboBoxTitleDown();
			}
			
			//titleItem = new HDComboBoxItemMC();
			titleItem = new HDComboBoxTitleMC();
			titleItem.gotoAndStop(1);
			//titleItem.background.width = _prop.backgroundWidth-2;
			//titleItem.background.height = _prop.backgroundHeight-2;
			//titleItem.x = 1;
			//titleItem.y = 1;
			
			label = _prop.text;
			
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
			titleItem.addChild(txt);
			setTextField(_prop.text, outColor, _font);
			
			btn.x = title.width - btn.width - BTN_X_OFFSET;
			btn.y = BTN_Y_OFFSET;
			
			buttonMode = true;
			mouseChildren = false;
			
			addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
			
			title.addChild(titleItem);			

			addChild(title);
			addChild(btn);
			
		}
		public function setTitle(_text:String, _font:String="Myriad Pro Light"):void
		{
			//trace("HDComboBoxTitle : setTitle : "+_text);
			label = _text;
			setTextField(_text, selectColor, _font);
		}
		public function resetTitle():void
		{
			label = defaultTitle;
			setTextField(defaultTitle, outColor, myriadSemibold);
		}
		private function setTextField(_text:String, _clr:uint, _font:String):void
		{
			txt.htmlText = TextUtils.prepTextForTextField(TextUtils.convertAmpersands(_text));//_text;
			
			var newFormat:TextFormat = new TextFormat();
			if(_font == "")
			{
				newFormat.font = myriadSemibold;
			}else{
				newFormat.font = _font;
			}
			newFormat.size = 12;
			newFormat.color = _clr;
			
			txt.setTextFormat(newFormat);
		}
		private function mouseOverHandler(event:MouseEvent):void
		{	
			btn.gotoAndStop("over_stop");
			//titleItem.background.gotoAndStop("over_stop");
			//txt.textColor = overColor;
		}
		private function mouseOutHandler(event:MouseEvent):void
		{
			btn.gotoAndStop("out_stop");
			//titleItem.background.gotoAndStop("out_stop");
			if(label == defaultTitle)
			{
				txt.textColor = outColor;
			}else{
				txt.textColor = selectColor;
			}
		}
	}
}