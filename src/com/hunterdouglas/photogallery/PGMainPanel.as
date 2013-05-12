package com.hunterdouglas.photogallery{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.text.*;
	
	import flash.events.*;
	import flash.net.*;
	import flash.utils.Timer;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	import caurina.transitions.*;
	import fl.motion.Color;
	
	
	import com.hunterdouglas.*;
	import com.hunterdouglas.common.ui.combobox.ComboBoxOpenDirection;
	import com.hunterdouglas.common.TextUtils;
	
	public class PGMainPanel extends Sprite {
		// FOLLOWING DEFINED IN .FLA FILE:
		// save_to_workbook_btn_mc


		private var _mainHeaderTextField:TextField = new TextField();
		private var _mainHeaderDynFontName:String = "Myriad Pro";// "Frutiger LT 57 Cn Edit";// "Frutiger LT Std 57 Cn";//"HelveticaNeue MediumCond";//"Arial";
		private var _mainHeaderDynFontSize:Number = 12;
		private var _mainHeaderTextColor:uint = 0xFFFFFF;
		private var _mainHeaderTextXCoordForStandard:Number = 10;
		private var _mainHeaderTextXCoordForPhotoGallery:Number = 65;


		private var _photoGalleryPaginationStatusTextField:TextField = new TextField();
		private var _photoGalleryPaginationStatusTextDynFontName:String = "Myriad Pro";//"Frutiger LT 57 Cn Edit";// "Frutiger LT Std 57 Cn";//"HelveticaNeue MediumCond";////"Arial";
		private var _photoGalleryPaginationStatusTextDynFontSize:Number = 12;

		public static  const PANEL_TYPE_STANDARD:int = 1;
		public static  const PANEL_TYPE_PHOTOGALLERY:int = 2;

		private static const DIVIDER_SPACE:Number = 12.5;

		private var _mainPanelType:int = PANEL_TYPE_PHOTOGALLERY;
		
		private var myriad:String;
		private var myriadSemibold:String = "Myriad Pro Light";

		private var _mainPanelContent:Sprite = new Sprite();
		private var _mainPanelContentPGPGThumbPanel:PGPGThumbPanel;


		function PGMainPanel() {
			//trace("PGMainPanel :" + this.numChildren);
			this.addChildAt(_mainPanelContent, 1);

			save_to_workbook_btn_mc.visible = false;
			status_divider_mc.visible = false;

			initializeMainHeaderText();
			initializePhotoGalleryPaginationStatusText();
		}
		private function initializeMainHeaderText() {
			_mainHeaderTextField = new TextField();
			_mainHeaderTextField.width = 565;
			_mainHeaderTextField.height = 30;
			_mainHeaderTextField.selectable = false;
			_mainHeaderTextField.textColor = _mainHeaderTextColor;
			_mainHeaderTextField.embedFonts = true;
			_mainHeaderTextField.multiline = false;
			_mainHeaderTextField.autoSize = TextFieldAutoSize.LEFT;
			_mainHeaderTextField.antiAliasType = AntiAliasType.ADVANCED;

			var newTextFormat:TextFormat = new TextFormat();
			newTextFormat.font = _mainHeaderDynFontName;
			newTextFormat.size = _mainHeaderDynFontSize;
			newTextFormat.align = TextFormatAlign.LEFT;

			this.addChild(_mainHeaderTextField);
			_mainHeaderTextField.x = _mainHeaderTextXCoordForStandard;
			_mainHeaderTextField.y = 7;
			_mainHeaderTextField.visible = true;

		}
		private function initializePhotoGalleryPaginationStatusText() {
			_photoGalleryPaginationStatusTextField = new TextField();
			_photoGalleryPaginationStatusTextField.width = 10;
			_photoGalleryPaginationStatusTextField.height = 10;
			_photoGalleryPaginationStatusTextField.selectable = false;
			_photoGalleryPaginationStatusTextField.textColor = _mainHeaderTextColor;
			_photoGalleryPaginationStatusTextField.embedFonts = true;
			//_photoGalleryPaginationStatusTextField.border = true;
			//_photoGalleryPaginationStatusTextField.background = true;
			_photoGalleryPaginationStatusTextField.multiline = false;
			_photoGalleryPaginationStatusTextField.autoSize = TextFieldAutoSize.LEFT;
			_photoGalleryPaginationStatusTextField.antiAliasType = AntiAliasType.ADVANCED;
			
			this.addChild(_photoGalleryPaginationStatusTextField);
			_photoGalleryPaginationStatusTextField.x = 20;//5;
			_photoGalleryPaginationStatusTextField.y = 7;
			_photoGalleryPaginationStatusTextField.alpha = 0;
			_photoGalleryPaginationStatusTextField.visible = false;
		}
		
		public function setHeaderText(mainText:String, statusText:String = '') {
			//trace('PGMainPanel : ' + mainText + ' [' + statusText+']');
			// TODO: I AM TEMPORARILY USING convertAmpersands(...) UNTIL IT IS FIXED IN THE XML
			_mainHeaderTextField.htmlText = TextUtils.prepTextForTextField(TextUtils.convertAmpersands(mainText));//mainText;
			
			var newFormat:TextFormat = new TextFormat();
			newFormat.font = myriadSemibold;
			newFormat.size = 12.5;
			newFormat.bold = true;
			_mainHeaderTextField.setTextFormat(newFormat);
			
			
			var statusFormat:TextFormat = new TextFormat();
			statusFormat.font = myriadSemibold;
			statusFormat.size = 12;
			statusFormat.bold = true;
			
			_photoGalleryPaginationStatusTextField.htmlText = statusText;
			_photoGalleryPaginationStatusTextField.setTextFormat(statusFormat);
			
			status_divider_mc.x = _photoGalleryPaginationStatusTextField.x + _photoGalleryPaginationStatusTextField.width + DIVIDER_SPACE;
			_mainHeaderTextField.x = status_divider_mc.x + status_divider_mc.width + DIVIDER_SPACE;
			
			// CHECK IF WE NEED TO FADE IN _photoGalleryPaginationStatusTextField 
			if (_photoGalleryPaginationStatusTextField.visible == false) {
				//trace('PGMainPanel NEED TO FADE IN _photoGalleryPaginationStatusTextField');
				_photoGalleryPaginationStatusTextField.visible = true;
				_photoGalleryPaginationStatusTextField.alpha = 0.6;
			}
			status_divider_mc.visible = true;
		}
		
		
		public function resetPanelContent() {
			//trace("> PGMainPanel : resetPanelContent :");
			if(_mainPanelContentPGPGThumbPanel != null)
				_mainPanelContentPGPGThumbPanel.visible = false;// = null;
			if(_mainPanelContent != null)
				this.removeChild(_mainPanelContent);
			_mainPanelContent = new Sprite();
			this.addChildAt(_mainPanelContent,1);
		}
		public function showPhotoGalleryContent(thumbImageInfoArray:Array, initialSelectedThumbArrayIndex:Number = 0) {
			//trace("> PGMainPanel : showPhotoGalleryContent :");
			this.removeChild(_mainPanelContent);
			_mainPanelContentPGPGThumbPanel = new PGPGThumbPanel(thumbImageInfoArray, initialSelectedThumbArrayIndex);
			_mainPanelContentPGPGThumbPanel.visible = true;
			_mainPanelContent = _mainPanelContentPGPGThumbPanel;
			this.addChildAt(_mainPanelContent,1);
			_mainPanelContent.x = 17;
			_mainPanelContent.y = 50;

		}
		public function updatePhotoGallerySelectedThumbnail(thumbnailArrayIndex:Number) {
			//trace("PGMainPanel : updatePhotoGallerySelectedThumbnail: "+thumbnailArrayIndex);
			//if (_mainPanelType == PANEL_TYPE_PHOTOGALLERY) {
				if (_mainPanelContentPGPGThumbPanel != null) {
					_mainPanelContentPGPGThumbPanel.updateSelectedThumbnail(thumbnailArrayIndex);
				} else {
					// TODO: ERROR
					//trace('@@@@@@@@@@@@@ FOR SOME REASON _mainPanelContentPGPGThumbPanel == null @@@@@@@@@@@@');
				}
			//}
		}
		public function updateSaveToMyWorkbookButton(isAlreadySaved:Boolean, productId:int, imageId:int = -1) {
			//trace("PGMainPanel : updateSaveToMyWorkbookButton: ");
			//trace("\tproductId:"+productId+" imageId: "+imageId+" isAlreadySaved:"+isAlreadySaved);
			save_to_workbook_btn_mc.visible = true;
			// Position AND Initialize SAVE TO MY WORKBOOK Button
			//save_to_workbook_btn_mc.setTextSizeAndColors(13, 0xFFFFFF, 0xFFFFFF, 0x206879);
			if (imageId <= 0) {
				save_to_workbook_btn_mc.setSaveObjectText('Product');
				save_to_workbook_btn_mc.setHDMyWorkbookEventInfo(new HDMyWorkbookEventInfo(escape('id=' + productId.toString()), productId.toString()));
			} else {
				save_to_workbook_btn_mc.setSaveObjectText('Image');
				save_to_workbook_btn_mc.setHDMyWorkbookEventInfo(new HDMyWorkbookEventInfo(escape('ProductID=' + productId.toString() + '&ImageID=' + imageId.toString()), productId.toString(), '', imageId.toString()));
			}
			save_to_workbook_btn_mc.setIsSavedToMyWorkbook(isAlreadySaved);

		}
		/*private function setTextField(_text:String):void
		{
			btnMC.txt.autoSize = "left";
			btnMC.txt.embedFonts = true;
			btnMC.txt.htmlText = _text;
			
			var newFormat:TextFormat = new TextFormat();
			//myriadSemibold = new MyriadSemibold().fontName;
			myriad = new Myriad().fontName;
			newFormat.font = myriad;
			newFormat.size = 12;
			
			btnMC.txt.setTextFormat(newFormat);
			
		}*/
	}
}