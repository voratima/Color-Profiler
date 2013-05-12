package com.hunterdouglas.common
{
	import flash.display.Sprite;
	import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;

	public class Debugger extends Sprite
	{
        public var label:TextField;

		public function Debugger(dx:int=0, dy:int=0, w:int=100, h:int=50, showMe:Boolean = true, showBG:Boolean = false)
		{
			x = dx;
			y = dy;

			label = new TextField();
            label.width = w;
            label.height = h;
			label.background = showBG;
            label.border = true;
			label.wordWrap	= true;
			label.visible = showMe;

            var format:TextFormat = new TextFormat();
            format.font = "Verdana";
            format.color = 0x006699;
            format.size = 10;
			
            label.defaultTextFormat = format;
            addChild(label);
			
			label.htmlText = "DEBUGGER AS3";
			output("--------------------------------");
		}
		public function output(txt:String = "")
		{
			label.appendText("\n"+txt);
			trace(txt);
			label.scrollV = label.maxScrollV;
		}
	}
}