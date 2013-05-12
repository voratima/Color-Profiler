package com.hunterdouglas.photogallery
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	
	import fl.transitions.*;
	import fl.transitions.easing.*;
	import com.hunterdouglas.common.Box;
	
	public class HDComboBox extends Sprite {
		private var list:Box;
		private var block:Box;
		private var content:MovieClip;
		private var title:HDComboBoxTitle;
		private var scroll:BrowseScroll;
		private var direction:String;
		private var data:XMLList;
		private var itemArray:Array;
		private var selectedProductID:int = -1;
		private var isOver:Boolean = false;
		public static var DROP_UP:String = "up";
		public static var DROP_DOWN:String = "down";
		
	
		public function HDComboBox()// _data:XMLList, _itemArray:Array, _prop:Object = undefined)
		{
		}
		public function init( _data:XMLList, _itemArray:Array, _prop:Object = undefined, _font:String = "")
		{
			//trace("HDComboBox : ");
			data = _data;
			itemArray = _itemArray;
			
			//BLOCK INIT
			block = new Box(stage.stageWidth, stage.stageHeight, 0xFFCC00, 0);
			block.x = _prop.blockProp.x;
			block.y = _prop.blockProp.y;
			block.addEventListener(MouseEvent.CLICK, blockClickHandler);
			addChild(block);
			
			//TITLE INIT
			title = new HDComboBoxTitle(_prop.direction, _prop.titleProp, "Myriad Pro");
			title.addEventListener(MouseEvent.CLICK, titleUpHandler);
			//title.addEventListener(MouseEvent.MOUSE_DOWN, titleDownHandler);
			title.addEventListener(MouseEvent.MOUSE_OUT, titleOutHandler);
			title.addEventListener(MouseEvent.MOUSE_OVER, titleOverHandler);
			addChild(title);
			
			//CONTENT INIT
			content = new MovieClip();
			for (var i:int=0 ; i< itemArray.length;i++)
			{
				//var ci:HDComboBoxElement = new HDComboBoxElement(itemArray[i],itemArray.length-1-i,_prop.itemProp);
				var ci:HDComboBoxElement = new HDComboBoxElement(itemArray[i],i,_prop.itemProp);
				ci.addEventListener(HDComboBoxEvent.SELECTED, selectElementHandler);
				content.addChild(ci);
			}
			//LIST INIT
			if (content.height < _prop.backgroundHeight)
			{
				list = new Box(_prop.backgroundWidth, content.height , _prop.backgroundColor, _prop.backgroundAlpha, _prop.border, _prop.borderColor, _prop.borderAlpha);
			}else{		
				list = new Box(_prop.backgroundWidth, _prop.backgroundHeight, _prop.backgroundColor, _prop.backgroundAlpha, _prop.border, _prop.borderColor, _prop.borderAlpha);
			}
			if(_prop.direction == DROP_UP)
			{
				list.y = -list.height;
			}
			list.addChild(content);
			addChild(list);
			
			hideList();
			
			scroll = new BrowseScroll(content, _prop);
			list.addChild(scroll);
			
		}
		private function blockClickHandler(e:MouseEvent):void
		{
			if(list.visible && !isOver)
			{
				hideList();
				//trace("\t#2 hideList :"+this.onMouseUp);
			}
		}
		private function titleOverHandler(e:MouseEvent)
		{
			//trace("HDComboBox : titleOverHandler :"+list.visible);
			isOver = true;
		}
		private function titleOutHandler(e:MouseEvent)
		{
			//trace("HDComboBox : titleOutHandler :"+list.visible);
			isOver = false;
		}
		
		private function titleUpHandler(e:MouseEvent)
		{
			////trace("HDComboBox : titleUpHandler :"+list.visible);
			if(!list.visible)
			{
				////trace("\t#1 showList :");
				dispatchEvent(new HDComboBoxEvent(HDComboBoxEvent.ACTIVE, true, false));
				showList();
				//this.stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseUpHandler);
			}else if(isOver){
				//trace("\t#2 hideList :");
				hideList();
			}
		}
		/*
		private function stageMouseUpHandler(e:MouseEvent):void
		{
			////trace("HDComboBox : stageMouseUpHandler : "+list.visible);
			if(list.visible && !isOver)//&& isShow)
			{
				////trace("\t#2 hideList :");
				hideList();
				this.stage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseUpHandler);
			}
		}*/
		private function hideList():void
		{
			list.visible = false;
			block.visible = false;
		}
		private function showList():void
		{
			list.visible = true;
			block.visible = true;
		}
		private function selectElementHandler(e:HDComboBoxEvent)
		{
			//trace("HDComboBox : selectElementHandler :");
			hideList();//NOT USED ANYMORE. MOVED TO STAGE MOUSE UP INSTEAD
			if(selectedProductID != e.id)
			{
				dispatchEvent(new HDComboBoxEvent(HDComboBoxEvent.CHANGE, true, false, e.label, e.id));
				selectedProductID = e.id;
			}
		}
		public function resetTitle():void
		{
			selectedProductID = -1;
			title.resetTitle();
		}
		public function setTitle(_id:int):void
		{
			//trace("HDComboBox : setTitle");
			for (var i:int=0 ; i< itemArray.length;i++)
			{
				//trace(i+": "+itemArray[i].id+" "+itemArray[i].label);
				if(itemArray[i].id == _id)
				{
					title.setTitle(itemArray[i].label);
					break;
				}
			}
		}
	}
}