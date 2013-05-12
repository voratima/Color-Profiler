package com.enlighten.common
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import com.hunterdouglas.common.*;
	
	public class ENLToolTip extends Sprite
	{
		private var css:StyleSheet;
		private var label:TextField;
		public var background:Box;
		public var rollOutBox:Box;
		//private var isOver:Boolean	= false;
		
		public static const EDIT:String		= "edit";
		public static const SELECT:String	= "select";
		public static const DELETE:String	= "delete";
		
		public function ENLToolTip(_css:StyleSheet):void
		{
			css			= _css;
			
			hide();
			//mouseChildren	= false;
			//addEventListener(MouseEvent.MOUSE_OUT, handlerMouseOut);
			
			addEventListener(Event.ADDED_TO_STAGE, handlerAddedToStage);
			
		}
		private function handlerAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, handlerAddedToStage);
			rollOutBox	= new Box(stage.stageWidth, stage.stageHeight, 0x330099, 0);
			rollOutBox.addEventListener(MouseEvent.ROLL_OVER, handlerMouseOut);
			addChildAt(rollOutBox, 0);
			
			initLabel();
			
		}
		private function handlerMouseOut(e:MouseEvent):void
		{
			hide();
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
			label.mouseEnabled	= false;
			addChild(label);
		}
		public function setLabel(_str:String):void
		{
			label.htmlText		= _str;
			
			if(background!=null)
			{
				removeChild(background);
			}
			background	= new Box(label.width, label.height, 0xFFFFFF, 1, 1, 0xa3a3a3, 0.7);
			addChildAt(background, 1);
			
			var target:*	= this;
			
			var newX:int	= x;
			var newY:int	= y;
			while(target != stage)
			{
				target		= target.parent;
				if(target == null || target == this)
				{
					break;
				}else{
					newX	+= target.x;
					newY	+= target.y;
				}
			}
			rollOutBox.x	= -newX;
			rollOutBox.y	= -newY;
			
			show();
		}
		public function show():void
		{
			visible	= true;
		}
		public function hide():void
		{
			//if(!isOver)
			//{
				visible	= false;
			//}
		}
	}
}