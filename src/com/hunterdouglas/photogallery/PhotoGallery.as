package com.hunterdouglas.photogallery{
	import flash.text.*;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.Timer;
	import flash.geom.Point;
	import fl.motion.Color;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	import caurina.transitions.*;
	
	import com.hunterdouglas.*;
	import com.hunterdouglas.common.HDLoader;
	import com.hunterdouglas.common.Debugger;
	import com.hunterdouglas.common.HDText;
	import com.hunterdouglas.common.TextLabel;
	import com.hunterdouglas.common.model.PhotoGalleryImageSetInfo;
	import com.hunterdouglas.common.PhotoCaption2Box;
	import com.hunterdouglas.common.ui.panels.thumbpanel.ThumbPanelEvent;
	import com.hunterdouglas.common.PopupLinkUtils;
	import com.hunterdouglas.common.TextUtils;
	import flash.xml.XMLDocument;
	
	//import necessary swfaddress classes;
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	import com.asual.swfaddress.SWFAddressSpecial;
	import com.asual.swfaddress.SWFAddressSpecialEvent;
	//
	import com.hunterdouglas.productdetail.PDMainInfo
	public class PhotoGallery extends Sprite {
		// FOLLOWING DEFINED IN .FLA FILE:
		
		private var firstTime:Boolean = true;
		
		private var loaderProductList:HDLoader;
		private var loaderRoomList:HDLoader;
		private var loaderStyleList:HDLoader;
		private var loaderNav:HDLoader;
		private var loaderGallery:HDLoader;
		private var xmlNav:XML;

		private var myriadSemibold:String = "Myriad Pro Light";
		private var _menu:PGMenu;
		
		// Copied from Product Detail
		private static const MAIN_PANEL_Y_ALL_THE_WAY_DOWN:Number = 494;
		private static const MAIN_PANEL_Y_PHOTO_GALLERY_TAB_DOWN:Number = 457;// MAIN_PANEL_Y_ALL_THE_WAY_DOWN - 37;
		private static const MAIN_PANEL_Y_PHOTO_GALLERY_TAB_UP:Number = 377;
		
		private static const PHOTO_GALLERY_COLOR:Number = 0x716D6A;
		
		private var _mainPanelMc:PGMainPanel;
		private var _mainPanelBackgroundMc:Sprite;
		private var _mainPanelMaskMc:Sprite;
		
		//private var _tabBarPhotoGalleryMc:PGTab;
		
		private var _initOverlaySwfHolderMc:MovieClip;
		private var _initOverlaySwfLoader:Loader = new Loader();
		private var _initOverlaySwfMc:MovieClip;
		private var _initOverlaySwfAlreadyShownOnce:Boolean = false;
		
		private var _largeImgHolderMc:Sprite;
		private var _largeImgLoader:Loader = new Loader();	
		private var _largeImgLoadingMc:MovieClip;
		private var _largeImgPrevBtn:SimpleButton;
		private var _largeImgNextBtn:SimpleButton;
		
		private var _photoCaption2Box:PhotoCaption2Box;

		private var _productMainInfo:PDMainInfo;
		private var _photoGalleryCurrentImageArrayIndex:int = -1;
		private var _photoGalleryImageInfoArr:Array = new Array();
		
		private var _photoGalleryTabPanelIsUp:Boolean = true;

		//private var timerToRespondToMouseRollOut:Timer = new Timer(1000, 1);
		private var timerToRespondToMouseRollOut:Timer = new Timer(1500, 1);
		private var timerToCheckIfMouseOverPhotoGalleryTab:Timer = new Timer(2000, 1);
				
		private var _productMainImageUrl:String = '';
		
		private var _swfAddressFirstTimeInFlag = true;
		private var _font4Loader:Loader = new Loader();
		private var _font4LoaderInfo:LoaderInfo = _font4Loader.contentLoaderInfo;
		private var _font5Loader:Loader = new Loader();
		private var _font5LoaderInfo:LoaderInfo = _font5Loader.contentLoaderInfo;
		// End Copied from Product Detail
		public var debugger:Debugger;

		public function PhotoGallery() {
			//trace('this.parent=' + this.parent);
			//myriadSemibold = new MyriadSemibold().fontName;
			
			// Copied from Product Detail
			_mainPanelMc = main_panel_mc;
			_mainPanelBackgroundMc = main_panel_mc.background_mc;
			_mainPanelMc.y = MAIN_PANEL_Y_ALL_THE_WAY_DOWN;
			_mainPanelMaskMc = main_panel_mask_mc;
			_mainPanelMc.mask = _mainPanelMaskMc;
			
			_largeImgHolderMc = large_img_holder_mc;
			_largeImgLoadingMc = large_img_loading_mc;
			//_largeImgLoadingMc.visible = false;
			
			_largeImgPrevBtn = large_img_prev_btn;
			_largeImgNextBtn = large_img_next_btn;
			_largeImgPrevBtn.visible = false;
			_largeImgNextBtn.visible = false;
			
			_largeImgPrevBtn.addEventListener(MouseEvent.CLICK, largeImgPrevBtnClickListener);
			_largeImgNextBtn.addEventListener(MouseEvent.CLICK, largeImgNextBtnClickListener);
			
			_photoCaption2Box = photo_caption2_mc;
			_photoCaption2Box.hide();
			
			_initOverlaySwfHolderMc = init_overlay_holder_mc;
			_initOverlaySwfHolderMc.visible = false;
			
			// End Copied from Product Detail
			_menu = menu;
			_menu.visible = false;
			_menu.addEventListener(HDComboBoxEvent.CHANGE, handlerMenuChange);
			
			this.addEventListener(Event.ADDED_TO_STAGE, thisAddedToStageListener);
						
			this.addEventListener(HDMyWorkbookEvent.MY_WORKBOOK_SAVE_ITEM, changeToMyWorkbookEventListener, true);
			this.addEventListener(HDMyWorkbookEvent.MY_WORKBOOK_CLEAR_SAVED_ITEM, changeToMyWorkbookEventListener, true);
		}
		
		private function thisAddedToStageListener(e:Event) {
			//startLoadXML();
			//Load Set of Fonts
			_font4LoaderInfo.addEventListener(Event.COMPLETE, onFont4Loaded);
			_font4Loader.load(new URLRequest(Path.FONT4));
			
		}
		private function onFont4Loaded(e:Event)
		{
			//trace("onFontLoaded:");
			_font5LoaderInfo.addEventListener(Event.COMPLETE, onFont5Loaded);
			_font5Loader.load(new URLRequest(Path.FONT5));
			
		}
		private function onFont5Loaded(e:Event)
		{
			//trace("onFontLoaded:");
			var info:LoaderInfo = e.currentTarget as LoaderInfo;
			var loader:Loader = info.content as Loader;
			var embeddedFonts:Array = Font.enumerateFonts(false);
			//trace('##############FONTS LOADED####################');
			for(var i:Number = 0; i < embeddedFonts.length; i++){
				var item:Font = embeddedFonts[i];
				//trace("[" + i + "] name:" + item.fontName + ", style: " + item.fontStyle + ", type: " + item.fontType);
			}
			//trace('##############################################');
			startLoadXML();
			
		}
		private function startLoadXML() {
			//trace('PhotoGallery startMain');

			dispatchEvent(new HDMainEvent(HDMainEvent.HIDE_LOADING_SIMPLE_MC));
			loaderProductList = new HDLoader(Path.PRODUCT_LIST);//"xml/photogallery-feed.xml");//xml/productfacetsearchprods-en.xml");
			loaderProductList.addEventListener(Event.COMPLETE,handlerProductListLoaded);
		}
		
		private function handlerProductListLoaded(e:Event):void
		{
			//trace("handlerProductListLoaded:");
			_menu.initProductList(e.target.data.Product);
			
			loaderRoomList = new HDLoader(Path.ROOM_LIST);
			loaderRoomList.addEventListener(Event.COMPLETE,handlerRoomListLoaded);
		}
	
		private function handlerRoomListLoaded(e:Event):void
		{
			//trace("handlerRoomListLoaded:");
			_menu.initRoomList(e.target.data.GalleryRoom);
			
			loaderStyleList = new HDLoader(Path.STYLE_LIST);
			loaderStyleList.addEventListener(Event.COMPLETE, handlerStyleListLoaded);
		}
		private function handlerStyleListLoaded(e:Event):void
		{
			//trace("handlerStyleListLoaded:");
			_menu.initStyleList(e.target.data.GalleryStyle);
			
			finalInit();
		}
		private function finalInit():void
		{
			var iMagineBtn:IMagineButton = new IMagineButton({x:759, y:3});//498});
			iMagineBtn.addEventListener(MouseEvent.CLICK, iMagineButtonClickListener);
			_menu.addChildAt(iMagineBtn, 1);
			_menu.visible = true;
			if (!_initOverlaySwfAlreadyShownOnce) { 
				loadInitOverlaySwf();
			}
			//debugger = new Debugger(this, 50, 50, 250, 200, true);
			//addChild(debugger);
		}
		private function iMagineButtonClickListener(e:MouseEvent) {
			//trace("iMagineButtonClickListener: ");
			//trace("\tindex: "+_photoGalleryCurrentImageArrayIndex);
			if(_photoGalleryCurrentImageArrayIndex>-1){
				var tmpPhotoGalleryImageSetInfoArr:Array = _photoGalleryImageInfoArr;
				var _tmpImageInfo:PhotoGalleryImageSetInfo = PhotoGalleryImageSetInfo(tmpPhotoGalleryImageSetInfoArr[_photoGalleryCurrentImageArrayIndex]);
				//trace("\tproductID: "+_tmpImageInfo.getProductId());
				PopupLinkUtils.iMagineProductPopupLink(_tmpImageInfo.getProductId());
			}else{
				PopupLinkUtils.iMaginePopupLink();
			}
		}
		private function handlerMenuChange(e:HDComboBoxEvent)
		{
			//trace("> PhotoGallery : handlerMenuChange: ");
			//trace("\t id: "+e.id +" : "+e.target.name);
			//SWFAddress.setValue(e.target.name+"/"+e.id); //adding swfaddress
			SWFAddress.setValue("/" + e.target.name + "/" + e.id + "/" + TextUtils.convertEntityCharsAndRemoveNonAlphaNumericCharacters(e.label) + "/"); //adding swfaddress. make sure that it always start with "/" otherwise SWF address will make a request call twice.
		}
		// Functions copied from Product Detail
		private function loadGalleryXML(id:int, refObject:String) {
			//trace("#5 loadGalleryXML "); 
			var url:String = Path.CONTENT+"object=GalleryImage&id="+ id + "&refobject="+refObject;
			loaderGallery = new HDLoader(url);
			loaderGallery.addEventListener(Event.COMPLETE,galleryXmlLoaderCompleteListener);
		}
		private function galleryXmlLoaderCompleteListener(e:Event) {
			//trace("#6 galleryXmlLoaderCompleteListener "); 
			loaderGallery.removeEventListener(Event.COMPLETE,galleryXmlLoaderCompleteListener);

			_photoGalleryImageInfoArr = new Array();
			
			var _xml:XML = new XML(e.target.data);
			var prodDesc:String = '';
			
			for each (var item:XML in _xml.*) {
				var imgUrl:String = item.GalleryImage.@url;
				if (imgUrl != null && imgUrl != '') {
					// POPULATE IMAGE URL FOR MAIN IMAGE USED ON PRODUCT SPECIFICATIONS TAB
					//trace("\timgUrl: "+imgUrl);
					//if (_productMainImageUrl == '') _productMainImageUrl = imgUrl + "&width=280&height=154";
					//var imgId:int = item.GalleryImage.@assetid;
					var imgId:int = item.@id
					var imgDescription:String = item.Caption;
					var productId:int = item.ProductID;
					//trace("\tproductId: "+productId+" "+imgDescription);
					var imgPhotoCaption2:String = item.Caption2;
					_photoGalleryImageInfoArr.push(new PhotoGalleryImageSetInfo( imgId, Path.ROOT+imgUrl + "&width=962&height=528", Path.ROOT+imgUrl + "&width=100&height=55", imgDescription, false, productId, imgPhotoCaption2));
				}
			}
			

			if (_photoGalleryImageInfoArr.length > 0) {
				// HAS GALLERY IMAGE(S) TO LOAD
			} else {
				// TODO: NEED TO HANDLE PRODUCTS WITHOUT GALLERY IMAGES	
				// NO GALLERY IMAGE TO LOAD
				_photoGalleryImageInfoArr.push(new PhotoGalleryImageSetInfo( -1, "missing-image-962x528.jpg", "missing-image-100x55.jpg", ""));
			}

			// CHECK IF IMAGE URL FOR MAIN IMAGE USED ON PRODUCT SPECIFICATIONS TAB HAS BEEN POPULATED
			if (_productMainImageUrl == '') _productMainImageUrl = "missing-image-280x154.jpg";

			_mainPanelMc.resetPanelContent();
			showPhotoGalleryTab();
			loadFirstPhotoGalleryImage();
		}
		private function loadFirstPhotoGalleryImage() {
			//trace("#7 loadFirstPhotoGalleryImage "); 
			//trace("\t img len:"+_photoGalleryImageInfoArr.length);
			// MAKE SURE ARRAY OF IMAGES HAVE AT LEAST ONE IMAGE
			if (_photoGalleryImageInfoArr.length > 0) {
				dispatchEvent(new HDFlashTrackEvent(HDFlashTrackEvent.FLASH_TRACK_ACTION, true, false, 'PhotoGalleryViewPGImage_Default','ImageIndex0',SWFAddress.getValue()));
				loadLargeImageByPhotoGalleryImageInfoArrIndex(0);
			} else {
			// TODO : ERROR 
			}
		}
		private function largeImgPrevBtnClickListener(e:MouseEvent) {
			//trace("largeImgPrevBtnClickListener:");
			var _targetPhotoGalleryImageArrayIndex:int = _photoGalleryCurrentImageArrayIndex - 1;
			if (_targetPhotoGalleryImageArrayIndex < 0) _targetPhotoGalleryImageArrayIndex = _photoGalleryImageInfoArr.length - 1;
			dispatchEvent(new HDFlashTrackEvent(HDFlashTrackEvent.FLASH_TRACK_ACTION, true, false, 'PhotoGalleryViewPGImage_PrevButtonClick','ImageIndex' + _targetPhotoGalleryImageArrayIndex,SWFAddress.getValue()));
			loadLargeImageByPhotoGalleryImageInfoArrIndex(_targetPhotoGalleryImageArrayIndex);
		}
		private function largeImgNextBtnClickListener(e:MouseEvent) {
			//trace("largeImgPrevBtnClickListener:");
			var _targetPhotoGalleryImageArrayIndex:int = _photoGalleryCurrentImageArrayIndex + 1;
			if (_targetPhotoGalleryImageArrayIndex >= _photoGalleryImageInfoArr.length) _targetPhotoGalleryImageArrayIndex =  0;
			dispatchEvent(new HDFlashTrackEvent(HDFlashTrackEvent.FLASH_TRACK_ACTION, true, false, 'PhotoGalleryViewPGImage_NextButtonClick','ImageIndex' + _targetPhotoGalleryImageArrayIndex,SWFAddress.getValue()));
			loadLargeImageByPhotoGalleryImageInfoArrIndex(_targetPhotoGalleryImageArrayIndex);
		}
		private function loadLargeImageByPhotoGalleryImageInfoArrIndex(arrayIndexToLoad:Number) {
			dispatchEvent(new HDFlashTrackEvent(HDFlashTrackEvent.FLASH_TRACK_ACTION, true, false, 'PhotoGalleryViewPGImage','ImageIndex'+arrayIndexToLoad,SWFAddress.getValue()));
			//trace("#8 loadLargeImageByPhotoGalleryImageInfoArrIndex:");
			_largeImgLoadingMc.background.visible = false;
			_largeImgLoadingMc.visible = true;
			_largeImgLoader = new Loader();
			_photoGalleryCurrentImageArrayIndex = arrayIndexToLoad;
			//CHAD REQUEST. MOVED FROM largeImgLoaded function.
			renderPhotoGalleryHeaderForCurrentLargeImage();
			var _tmpFirstImageInfo:PhotoGalleryImageSetInfo = PhotoGalleryImageSetInfo(_photoGalleryImageInfoArr[_photoGalleryCurrentImageArrayIndex]);
			_largeImgLoader.load(new URLRequest(_tmpFirstImageInfo.getLargeImgUrl()));
			_largeImgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, largeImgLoaded);
		}
		private function largeImgLoaded(e:Event) {
			//debugger.trace("largeImgLoaded:");
			//trace("#9 largeImgLoaded:");
			_largeImgLoadingMc.visible = false;
			var _tmpNewImg:DisplayObject = _largeImgLoader.content;
			if (_tmpNewImg == null) {
				//trace('#### _tmpNewImg is NULL.  MUST HAVE BEEN OVERRIDDEN WITH NEW LOAD OF LARGE IMAGE');
			} else {
				_tmpNewImg.alpha = 0;
				_largeImgHolderMc.addChild(_tmpNewImg);
				
				if (_largeImgHolderMc.numChildren > 1) {
					var _tmpOldImg:DisplayObject = _largeImgHolderMc.getChildAt(_largeImgHolderMc.numChildren - 2);
					Tweener.addTween(_tmpNewImg, { time:3.5, alpha:1, onComplete:largeImgFadeInComplete } );
					Tweener.addTween(_tmpOldImg, { time:3.5, alpha:0} );
				} else {
					Tweener.addTween(_tmpNewImg, { time:1.5, alpha:1, onComplete:largeImgFadeInComplete} );
					//CHAD REQUEST. MOVED TO showPhotoGalleryTab. Roll down thumbpanel everytime it's rolled up and time out instead of when the largeimage is loaded.
					//timerStart();
				}
				//CHAD REQUEST. MOVED TO loadLargeImageByPhotoGalleryImageInfoArrIndex function.
				//renderPhotoGalleryHeaderForCurrentLargeImage();
				
				var _currentImageInfo:PhotoGalleryImageSetInfo = PhotoGalleryImageSetInfo(_photoGalleryImageInfoArr[_photoGalleryCurrentImageArrayIndex]);
				var photoCaption2:String = _currentImageInfo.getPhotoCaption2();
				if (photoCaption2 != null && photoCaption2 != '') {
					_photoCaption2Box.initializeAndMakeVisible(photoCaption2, _photoGalleryCurrentImageArrayIndex);
				} else {
					_photoCaption2Box.hide();
				}
			}
		}
		private function largeImgUnloaded():void
		{
			//trace("#16 largeImgUnloaded:");
			_largeImgLoadingMc.visible = false;
			//trace("\tnumChild:"+_largeImgHolderMc.numChildren);
			if (_largeImgHolderMc.numChildren > 0) {
				var _tmpOldImg:DisplayObject = _largeImgHolderMc.getChildAt(_largeImgHolderMc.numChildren - 1);
				//trace("\t_tmpOldImg:"+_tmpOldImg);
				Tweener.addTween(_tmpOldImg, { time:3.5, alpha:0} );
			}
			
		}
		private function backToHome():void
		{
			//trace("#15 backToHome:");
			largeImgUnloaded();
			//_menu.resetSelection();
			_largeImgPrevBtn.visible = false;
			_largeImgNextBtn.visible = false;
			Tweener.addTween(_mainPanelMc, { time:0.3, y:MAIN_PANEL_Y_ALL_THE_WAY_DOWN} );
			//Tweener.addTween(backgroundImage, { time:3.5, alpha:1} );
			backgroundImage.visible = true;
			_initOverlaySwfMc.visible = true;
			
		}
		private function loadInitOverlaySwf() {
			//trace("#11 loadInitOverlaySwf");
			_initOverlaySwfLoader = new Loader();
			_initOverlaySwfLoader.load(new URLRequest(Path.PG_OVERLAY));
			_initOverlaySwfLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, initOverlaySwfLoaded);
		}
		private function initOverlaySwfLoaded(e:Event) {
			//trace("#12 initOverlaySwfLoaded");
			_initOverlaySwfAlreadyShownOnce = true;
			initImageAndOverlayDoneLoading();
		}
		private function initImageAndOverlayDoneLoading() {
			//trace("#13 initImageAndOverlayDoneLoading");
			// HIDE STANDARD SIMPLE LOADING MOVIE CLIP
			
			_initOverlaySwfHolderMc.visible = true;
			_largeImgLoadingMc.visible = false
			
			_initOverlaySwfMc = MovieClip(_initOverlaySwfLoader.content);
			_initOverlaySwfMc.gotoAndStop(1);
			_initOverlaySwfHolderMc.addChild(_initOverlaySwfMc);
			_initOverlaySwfMc.gotoAndPlay(1);
			
			if (firstTime) {
				dispatchEvent(new HDMainEvent(HDMainEvent.HIDE_LOADING_SIMPLE_MC));
				firstTime = false;
			}
			// NOTE: ONLY LOAD SWFADDRESS LISTENER AFTER ALL PRODUCT MAIN XML DATA IS LOADED IN
			//create listener object for swfaddress
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, SWFAddressHandler);			
		}
		private function largeImgFadeInComplete() {
			//trace("------------------------------ largeImgFadeInComplete:");
			backgroundImage.visible = false;
			_initOverlaySwfMc.visible = false;
			removeAllDisplayChildrenExceptTopmost(_largeImgHolderMc);
		}
		private function removeAllDisplayChildrenExceptTopmost(contentMc:Sprite) {
			for (var a:uint=contentMc.numChildren-1; contentMc.numChildren > 1; a--) {
				contentMc.removeChildAt(a-1);
			}
		}
		private function renderPhotoGalleryHeaderForCurrentLargeImage() {
			//trace("#10 renderPhotoGalleryHeaderForCurrentLargeImage:");
			var _tmpImageInfo:PhotoGalleryImageSetInfo = PhotoGalleryImageSetInfo(_photoGalleryImageInfoArr[_photoGalleryCurrentImageArrayIndex]);
			var _tmpPaginationStr:String = (_photoGalleryCurrentImageArrayIndex + 1) + ' of ' + (_photoGalleryImageInfoArr.length) + ' Photos';
			_mainPanelMc.setHeaderText(_tmpImageInfo.getDescriptionText(), _tmpPaginationStr);
			_mainPanelMc.updatePhotoGallerySelectedThumbnail(_photoGalleryCurrentImageArrayIndex);			
// TODO: NEED TO PROPERLY INITIALIZE AND SET THE SAVE TO MY WORKBOOK BUTTON IN MAIN PANEL
			_mainPanelMc.updateSaveToMyWorkbookButton(_tmpImageInfo.isSavedToMyWorkbook(), _tmpImageInfo.getProductId(), _tmpImageInfo.getImageId());
			
		}
		private function changeToMyWorkbookEventListener(hDMyWorkbookEvent:HDMyWorkbookEvent) {
			//trace("---- changeToMyWorkbookEventListener:");
			var eventInfo:HDMyWorkbookEventInfo = hDMyWorkbookEvent.hdMyWorkbookEventInfo;
			var tmpImageId:int = -1;
			if (eventInfo.imageId != null && eventInfo.imageId != '') {
				tmpImageId = int(eventInfo.imageId);
				if (isNaN(tmpImageId)) tmpImageId = -1
			}
			if (hDMyWorkbookEvent.type == HDMyWorkbookEvent.MY_WORKBOOK_SAVE_ITEM) {
				if (tmpImageId > 0) {
					updateImageSavedToMyWorkbook(tmpImageId, true);
				} else {
					_productMainInfo.setIsSavedToMyWorkbook(true);
				}
			} else if (hDMyWorkbookEvent.type == HDMyWorkbookEvent.MY_WORKBOOK_CLEAR_SAVED_ITEM) {
				if (tmpImageId > 0) {
					updateImageSavedToMyWorkbook(tmpImageId, false);
				} else {
					_productMainInfo.setIsSavedToMyWorkbook(false);
				}
			}
		}
		private function updateImageSavedToMyWorkbook(imgId:int, isSaved:Boolean) {
			//trace("---- updateImageSavedToMyWorkbook:");
			var tmpPhotoGalleryImageSetInfoArr:Array = _photoGalleryImageInfoArr;
			var _tmpImageInfo:PhotoGalleryImageSetInfo = PhotoGalleryImageSetInfo(tmpPhotoGalleryImageSetInfoArr[_photoGalleryCurrentImageArrayIndex]);
			if (_tmpImageInfo.getImageId() == imgId) {
				_tmpImageInfo.setTsSavedToMyWorkbook(isSaved);
			} else {
				// FOR SOME REASON THE CURRENT IMAGE IS NOT THE ONE THAT WAS SAVED. SO LOOP THRU ARRAY TO FIND PROPER IMAGE
				for each (var imageSetInfo:PhotoGalleryImageSetInfo in tmpPhotoGalleryImageSetInfoArr) {
					if (imageSetInfo.getImageId() == imgId) {
						imageSetInfo.setTsSavedToMyWorkbook(isSaved);
						break;
					}
				}
			}
		}
		
		private function showPhotoGalleryTab() {
			//trace("#11 showPhotoGalleryTab:");
			
			// load PhotoGallery Pane
			var colorInfo:Color = new Color();
			colorInfo.setTint(PHOTO_GALLERY_COLOR, 1);
			_mainPanelBackgroundMc.transform.colorTransform = colorInfo;
			// animate Pane open (y=377)
			Tweener.addTween(_mainPanelMc, { time:0.7, y:MAIN_PANEL_Y_PHOTO_GALLERY_TAB_UP} );
			//CHAD REQUEST. MOVED FROM largeImgLoaded. Roll down thumbpanel everytime it's rolled up and time out instead of when the largeimage is loaded.
			timerStart();
			_photoGalleryTabPanelIsUp = true;
			_mainPanelMc.addEventListener(MouseEvent.ROLL_OUT, photoGalleryPanelRollOutListener);
			_mainPanelMc.addEventListener(MouseEvent.ROLL_OVER, photoGalleryPanelRollOverListener);
				
			_largeImgPrevBtn.visible = true;
			_largeImgNextBtn.visible = true;
				
			// load PhotoGallery Thumbnail images
			_mainPanelMc.showPhotoGalleryContent(_photoGalleryImageInfoArr, _photoGalleryCurrentImageArrayIndex);
			_mainPanelMc.addEventListener( ThumbPanelEvent.ON_THUMB_CLICK, photoGalleryThumbnailClickHandler, true );
		}
		private function photoGalleryTabRollOverListener(e:MouseEvent) {
			//trace('photoGalleryTabRollOverListener');
			//_tabBarPhotoGalleryMc.setBackgroundColor(PHOTO_GALLERY_COLOR);
		}
		private function photoGalleryTabRollOutListener(e:MouseEvent) {
			//trace('photoGalleryTabRollOutListener');
			//_tabBarPhotoGalleryMc.resetBackgroundColor();
		}
		private function photoGalleryTabClickListener(e:MouseEvent) {
			//trace('photoGalleryTabClickListener');
			//SWFAddress.setValue('/PG/');
		}
		private function timerCheckIfMouseOverPhotoGalleryTabListener(e:TimerEvent) {
			//trace('timerCheckIfMouseOverPhotoGalleryTabListener');
			//trace('this.mouseX=' + this.mouseX + '\t\tthis.mouseY=' + this.mouseY);
			
			var currentMousePointLocal:Point = new Point(this.mouseX, this.mouseY);
			var currentMouseX:Number = this.localToGlobal(currentMousePointLocal).x;
			var currentMouseY:Number = this.localToGlobal(currentMousePointLocal).y;
			//if (!(currentMouseY < (494+23) && _mainPanelMc.hitTestPoint(currentMouseX, currentMouseY, false)) && !_tabBarPhotoGalleryMc.hitTestPoint(currentMouseX, currentMouseY, false)) {
				rollPhotoGalleryTabDown();
			//}
    //trace("display object coordinates:", currentMousePointLocal);
    //trace("LOCAL TO GLOBAL MOUSE coordinates:", this.localToGlobal(currentMousePointLocal));
//
			//
			//trace('_tabBarPhotoGalleryMc.mouseX=' + _tabBarPhotoGalleryMc.mouseX + '\t\t_tabBarPhotoGalleryMc.mouseY=' + _tabBarPhotoGalleryMc.mouseY);
			//trace('this.parent.mouseX=' + this.parent.mouseX + '\t\tthis.parent.mouseY=' + this.parent.mouseY);
			//trace('_mainPanelMc.hitTestPoint ' + _mainPanelMc.hitTestPoint(this.localToGlobal(currentMousePointLocal).x, this.localToGlobal(currentMousePointLocal).y, true));
			//trace('_tabBarPhotoGalleryMc.hitTestPoint ' + _tabBarPhotoGalleryMc.hitTestPoint(this.localToGlobal(currentMousePointLocal).x, this.localToGlobal(currentMousePointLocal).y, false));
			//
			//
			//trace('test1=' + (currentMouseY < 494 && _mainPanelMc.hitTestPoint(currentMouseX, currentMouseY, false)));
			//trace('test2=' + _tabBarPhotoGalleryMc.hitTestPoint(currentMouseX, currentMouseY, false));
			
		}
		
		/*private function photoGalleryPanelRollOutListener(e:MouseEvent) {
			if (timerToCheckIfMouseOverPhotoGalleryTab.running) {
				timerToCheckIfMouseOverPhotoGalleryTab.stop();
				timerToCheckIfMouseOverPhotoGalleryTab.reset();
			}
			
			timerToRespondToMouseRollOut.reset();
			timerToRespondToMouseRollOut.addEventListener(TimerEvent.TIMER, timerMouseOutListener);
			timerToRespondToMouseRollOut.start();
		}	*/
		private function photoGalleryPanelRollOutListener(e:MouseEvent) {
			timerStart();
		}
		private function timerStart():void {
			//debugger.trace("timerStart:");
			
			if (timerToCheckIfMouseOverPhotoGalleryTab.running) {
				timerToCheckIfMouseOverPhotoGalleryTab.stop();
				timerToCheckIfMouseOverPhotoGalleryTab.reset();
			}
			
			timerToRespondToMouseRollOut.reset();
			timerToRespondToMouseRollOut.addEventListener(TimerEvent.TIMER, timerMouseOutListener);
			timerToRespondToMouseRollOut.start();
		}
		private function timerMouseOutListener(e:TimerEvent) {
			//debugger.trace("TIME OUT:----");
			if (timerToCheckIfMouseOverPhotoGalleryTab.running) {
				timerToCheckIfMouseOverPhotoGalleryTab.stop();
				timerToCheckIfMouseOverPhotoGalleryTab.reset();
			}
			
			timerToRespondToMouseRollOut.stop();
			timerToRespondToMouseRollOut.reset();
			
			if (_photoGalleryTabPanelIsUp) {			
				rollPhotoGalleryTabDown();
			}
		}
		private function photoGalleryPanelRollOverListener(e:MouseEvent) {
			if (timerToRespondToMouseRollOut.running) {
				timerToRespondToMouseRollOut.stop();
				timerToRespondToMouseRollOut.reset();
			}
			if (!_photoGalleryTabPanelIsUp) {	
				rollPhotoGalleryTabUp();
			}
			//_mainPanelMc.addEventListener(MouseEvent.ROLL_OUT, photoGalleryPanelRollOutListener);
			//_tabBarPhotoGalleryMc.addEventListener(MouseEvent.ROLL_OUT, photoGalleryPanelRollOutListener);
		}
		
		private function rollPhotoGalleryTabUp() {
			//trace('rollPhotoGalleryTabUp');
			_photoGalleryTabPanelIsUp = true;
			Tweener.addTween(_mainPanelMc, { time:0.5, y:MAIN_PANEL_Y_PHOTO_GALLERY_TAB_UP } );
			
		}
		private function rollPhotoGalleryTabDown() {
			//trace('rollPhotoGalleryTabDown');
			_photoGalleryTabPanelIsUp = false;
			Tweener.addTween(_mainPanelMc, { time:0.8, y:MAIN_PANEL_Y_PHOTO_GALLERY_TAB_DOWN } );
		}		
		private function photoGalleryThumbnailClickHandler( event:ThumbPanelEvent ):void {
			//trace( "PhotoGallery : thumbClickHandler: ");
			//trace("\tlargeImageURL: " + event.thumbData.getLargeImgUrl());
			//trace("\tname: " + event.target.name);
			//var id:int = event.thumbData.getImageId();
			//trace("\tid: " + id);
			
			// Load Large Image based on selected thumb array index
			dispatchEvent(new HDFlashTrackEvent(HDFlashTrackEvent.FLASH_TRACK_ACTION, true, false, 'PhotoGalleryViewPGImage_ThumbPanelClick','ImageIndex' + event.thumbArrayIndex,SWFAddress.getValue()));
			this.loadLargeImageByPhotoGalleryImageInfoArrIndex(event.thumbArrayIndex);
		}
		
		// MASTER SWFAddress Handler
		private function SWFAddressHandler(e:SWFAddressEvent) {
			//trace("> PhotoGallery : SWFAddressHandler :");
			var address:String = SWFAddress.getValue();
			dispatchEvent(new HDFlashTrackEvent(HDFlashTrackEvent.FLASH_TRACK_ACTION, true, false, 'SWFAddressEvent','',address));
			processSWFAddress(address);				
			_swfAddressFirstTimeInFlag = false;
		}
		private function processSWFAddress(swfAddressStr:String) {
			//trace("> PhotoGallery : processSWFAddress :");
			_menu.resetSelection();
			if (swfAddressStr == '' || swfAddressStr == '/') {
				backToHome();
			} else {
				//trace('processSWFAddress : swfAddressStr:' + swfAddressStr);
				var paramsArr:Array = swfAddressStr.split("/");
				var mode:String = paramsArr[1].toString();
				var id:int 		= paramsArr[2];
				//var imageID:String	= paramsArr[3].toString();
				//trace('\t mode:' + mode + ' id:' + id);
				loadGalleryXML(id, mode);
				_menu.setSelection(id, mode);
			}
			
			
		}
		// End Functions copied from Product Detail		
		
		/*private function setTitle(_xml:XML):void
		{
			title.autoSize = "left";
			title.embedFonts = true;
			title.htmlText = _xml;
			
			var newFormat:TextFormat = new TextFormat();
			newFormat.font = helveticaThin;
			//newFormat.letterSpacing = -2.4;
			//newFormat.size = 66;
			
			title.setTextFormat(newFormat);
			
			if(_xml.@x != undefined)
			{	title.x = _xml.@x;
			}
			if(_xml.@y != undefined)
			{	title.y = _xml.@y;
			}
		}
		
		private function thisAddedToStageListener(e:Event) {
			//trace('HomeTheater added to Stage.  this.parent=' + this.parent);
			if (firstTime) {
			// SHOW STANDARD SIMPLE LOADING MOVIE CLIP
				dispatchEvent(new HDMainEvent(HDMainEvent.SHOW_LOADING_SIMPLE_MC));
			}
		}
		*/
		
		
		
	}
}