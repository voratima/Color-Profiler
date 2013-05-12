package com.hunterdouglas.common{
	import flash.text.*;
	import flash.display.Sprite;
	
	public class Box extends Sprite 
	{
		private var labelTxt:TextField;
		
		public var border:int = 0;
		public var borderColor:uint = 0xFFFFFF;
		public var borderAlpha:Number = 0;
		
		public var color:uint = 0xFFFFFF;
		public var alp:Number = 0;

		private var w:Number;
		private var h:Number;
		
		public function Box(_w:uint=0, _h:uint=0, _color:uint=0xFFFFFF, _alp:Number=0, _bdr:int = 0, _bdrColor:Number = 0x000000, _bdrAlpha:Number=0) 
		{
			w = _w;
			h = _h;
			color = _color;
			border = _bdr;
			borderColor = _bdrColor;
			borderAlpha = _bdrAlpha;
			alp = _alp;
			draw();
			
		}
		public function draw():void {
			graphics.lineStyle(border,borderColor, borderAlpha);
			graphics.beginFill(color, alp );
			graphics.drawRect(0,0,w,h);
			graphics.endFill();
		}
		public function set label(_str:String):void
		{
			if(labelTxt == null)
			{
				labelTxt = new TextField();
				labelTxt.width		= w;
				labelTxt.height	= h;
				labelTxt.wordWrap	= true;
				labelTxt.autoSize	= "left";
				labelTxt.selectable	= false;
				
				var format:TextFormat = new TextFormat();
				format.font = "Verdana";
				format.color = borderColor;
				format.size = 10;
				
				labelTxt.defaultTextFormat = format;
	            addChild(labelTxt);
			}
			labelTxt.htmlText = _str;
		}
	}
}