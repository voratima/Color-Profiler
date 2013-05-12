package com.hunterdouglas.photogallery{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.text.*;
	//import flash.display.MovieClip;
	//
	
	import flash.events.*;
	/*import flash.net.*;
	import flash.utils.Timer;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	import caurina.transitions.*;
	import fl.motion.Color;
	
	
	import com.hunterdouglas.*;
	import com.hunterdouglas.common.ui.combobox.ComboBoxOpenDirection;
	import com.hunterdouglas.common.TextUtils;
	*/
	
	import com.hunterdouglas.common.ui.combobox.*;
	import com.hunterdouglas.common.TextUtils;
	
	public class PGMenu extends MovieClip {
		// FOLLOWING DEFINED IN .FLA FILE:
		// menu
		private static const COMBO_Y:Number = 7;
		// PRODUCT, ROOM, AND STYLE values much match refobject's name from JSP call.
		private static const PRODUCT:String	= "Product";
		private static const ROOM:String	= "GalleryRoom";
		private static const STYLE:String	= "GalleryStyle";
		
		private var xmlProductList:XMLList;
		private var xmlRoomList:XMLList;
		private var xmlStyleList:XMLList;
		
		private var cbList:Array;
		private var mode:String;

		private var textFormatUp:TextFormat;
		private var textFormatOver:TextFormat;
		private var overColor:uint = 0xFFFFFF;
		private var outColor:uint = 0x212121;
		private var selectColor:uint = 0x4D9DB9;
		
		public function PGMenu() {
			//trace("PGMenu : ");
			cbList = new Array();
		}
		public function initProductList(xml:XMLList):void
		{
			//trace("PRODUCT LIST LENGTH: "+xmlProductList.length());
			xmlProductList = xml;
			var dp:Array = new Array();
			for (var i:int = 0;i<xmlProductList.length(); i++)
			{
				//trace(xmlProductList[i].@id +": "+xmlProductList[i].ProductTradeName);
				dp[i] = new HDComboBoxItem({id:xmlProductList[i].@id, text:xmlProductList[i].ProductTradeName});
			}
			var itemProp:Object = {backgroundWidth:225, backgroundHeight:19, backgroundColor:0xFFFFFF, backgroundAlpha:1, border:0, borderColor:0x00ff33, borderAlpha:0, padding:0};
			var titleProp:Object = {backgroundWidth:245, backgroundHeight:20, backgroundColor:0xFFFFFF, backgroundAlpha:1, border:1, borderColor:0xb8b7af, borderAlpha:1, text:"Select Product"};
			var blockProp:Object = {y:-y-COMBO_Y};
			//var cb:HDComboBox = new HDComboBox(xmlProductList,  dp, {direction:HDComboBox.DROP_UP, backgroundWidth:245, backgroundHeight:300, backgroundColor:0xFFFFFF, backgroundAlpha:1, border:1, borderColor:0xb8b7af, borderAlpha:0.5, itemProp:itemProp, titleProp:titleProp});
			var cb:HDComboBox = new HDComboBox();
			addChild(cb);
			cb.x = 87;
			cb.y = COMBO_Y;
			cb.name = PRODUCT;
			//cb.addEventListener(HDComboBoxEvent.CHANGE, changeHandler);
			cb.addEventListener(HDComboBoxEvent.ACTIVE, activeHandler);
			cb.init(xmlProductList,  dp.sortOn("nameForAlphabeticalSort"), {direction:HDComboBox.DROP_UP, backgroundWidth:245, backgroundHeight:300, backgroundColor:0xFFFFFF, backgroundAlpha:1, border:1, borderColor:0xb8b7af, borderAlpha:0.5, itemProp:itemProp, titleProp:titleProp, blockProp:blockProp});
			
			cbList.push(cb);
			
		}
		
		public function initRoomList(xml:XMLList):void
		{
			//trace("ROOM LIST LENGTH: "+xmlRoomList.length());
			xmlRoomList = xml;
			var dp:Array = new Array();
			for (var i:int = 0;i<xmlRoomList.length(); i++)
			{
				//trace(xmlRoomList[i].@id +": "+xmlRoomList[i].RoomName);
				dp[i] = new HDComboBoxItem({id:xmlRoomList[i].@id, text:xmlRoomList[i].RoomName});
			}
			var itemProp:Object = {backgroundWidth:203, backgroundHeight:19, backgroundColor:0xFFFFFF, backgroundAlpha:1, border:0, borderColor:0x00ff33, borderAlpha:0, padding:0};
			var titleProp:Object = {backgroundWidth:203, backgroundHeight:20, backgroundColor:0xFFFFFF, backgroundAlpha:1, border:1, borderColor:0xb8b7af, borderAlpha:1, text:"Select Room Type"};
			var blockProp:Object = {y:-y-COMBO_Y};
			var cb:HDComboBox = new HDComboBox();
			addChild(cb);
			cb.x = 367;
			cb.y = COMBO_Y;//501;
			cb.name = ROOM;
			//cb.addEventListener(HDComboBoxEvent.CHANGE, changeHandler);
			cb.addEventListener(HDComboBoxEvent.ACTIVE, activeHandler);
			cb.init(xmlRoomList,  dp.sortOn("nameForAlphabeticalSort"), {direction:HDComboBox.DROP_UP, backgroundWidth:203, backgroundHeight:300, backgroundColor:0xFFFFFF, backgroundAlpha:0.5, border:1, borderColor:0xb8b7af, borderAlpha:0.5, itemProp:itemProp, titleProp:titleProp, blockProp:blockProp});
			cbList.push(cb);
		}	
		public function initStyleList(xml:XMLList):void
		{
			//trace("STYLE LIST LENGTH: "+xmlStyleList.length());
			xmlStyleList = xml;
			var dp:Array = new Array();
			for (var i:int = 0;i<xmlStyleList.length(); i++)
			{
				//trace(xmlStyleList[i].@id +": "+xmlStyleList[i].StyleName);
				dp[i] = new HDComboBoxItem({id:xmlStyleList[i].@id, text:xmlStyleList[i].StyleName});
			}
			var itemProp:Object = {backgroundWidth:145, backgroundHeight:19, backgroundColor:0xFFFFFF, backgroundAlpha:1, border:0, borderColor:0x00ff33, borderAlpha:0, padding:0};
			var titleProp:Object = {backgroundWidth:145, backgroundHeight:20, backgroundColor:0xFFFFFF, backgroundAlpha:1, border:1, borderColor:0xb8b7af, borderAlpha:0, text:"Select Decorating Style"};
			var blockProp:Object = {y:-y-COMBO_Y};
			var cb:HDComboBox = new HDComboBox();
			addChild(cb);
			cb.x = 605;
			cb.y = COMBO_Y;//501;
			cb.name = STYLE;
			//cb.addEventListener(HDComboBoxEvent.CHANGE, changeHandler);
			cb.addEventListener(HDComboBoxEvent.ACTIVE, activeHandler);
			cb.init(xmlStyleList,  dp.sortOn("nameForAlphabeticalSort"), {direction:HDComboBox.DROP_UP, backgroundWidth:145, backgroundHeight:300, backgroundColor:0xFFFFFF, backgroundAlpha:1, border:1, borderColor:0xb8b7af, borderAlpha:0, itemProp:itemProp, titleProp:titleProp, blockProp:blockProp});
			cbList.push(cb);
		}
		private function changeHandler(e:HDComboBoxEvent)
		{
			//trace("changeHandler: "+e.id +" : "+e.target.name);
			//mode = e.target.name;
			/*for(var i:uint=0; i<cbList.length; i++)
			{
				if(cbList[i].name != mode)
				{
					cbList[i].resetTitle();
				}
			}*/
		}
		private function activeHandler(e:HDComboBoxEvent)
		{
			//trace("activeHandler : "+e.target.name);
			setChildIndex(HDComboBox(e.target), numChildren-1);
		}
		public function hideAllList():void
		{
			for(var i:uint=0; i<cbList.length; i++)
			{
				cbList[i].hideList();
			}
		}
		public function resetSelection():void
		{
			for(var i:uint=0; i<cbList.length; i++)
			{
				cbList[i].resetTitle();
			}
		}
		public function setSelection(_id:int, _mode:String):void
		{
			mode = _mode;
			for(var i:uint=0; i<cbList.length; i++)
			{
				//trace("cb :"+ cbList[i].name+" = "+_mode);
				if(cbList[i].name==_mode)
				{
					cbList[i].setTitle(_id);
					break;
				}
			}
		}
	}
}