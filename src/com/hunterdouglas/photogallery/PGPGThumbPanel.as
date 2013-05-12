package com.hunterdouglas.photogallery{
	import flash.text.*;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.Timer;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	import caurina.transitions.*;
	import fl.motion.Color;
	
	
	import com.hunterdouglas.*;
	import com.hunterdouglas.common.ui.panels.thumbpanel.ThumbPanel;
	import com.hunterdouglas.common.ui.panels.thumbpanel.ThumbPanelEvent;	
	
	public class PGPGThumbPanel extends Sprite {
		// FOLLOWING DEFINED IN .FLA FILE:
		
		private var thumbsArray:Array;
		private var thumbPanel:ThumbPanel;
		private var currentThumbIndex:Number = 0;
		
		function PGPGThumbPanel(thumbImageInfoArray:Array, initialSelectedThumbArrayIndex:Number = 0) {
			//trace('PGPGThumbPanel 1');
			
			currentThumbIndex = initialSelectedThumbArrayIndex;
			
			thumbsArray = thumbImageInfoArray;
			
			//trace('PGPGThumbPanel 2');
			thumbPanel = new ThumbPanel( thumbsArray, SimpleLoadingAnimation, 937, 0 );
			
			thumbPanel.selectThumbByArrayIndex( currentThumbIndex );
			
			thumbPanel.x = -5;
			thumbPanel.y = 0;
			
			//trace('PGPGThumbPanel 3');
			//thumbPanel.addEventListener( ThumbPanelEvent.ON_THUMB_CLICK, thumbClickHandler );
			
			//trace('PGPGThumbPanel 4');
			this.addChild( thumbPanel );
			
			//trace('PGPGThumbPanel 5');
			// setup testing buttons
			var _btnPrev:SimpleButton = this.getChildByName( "btnPrev" ) as SimpleButton;
			var _btnNext:SimpleButton = this.getChildByName( "btnNext" ) as SimpleButton;
			
			//trace('PGPGThumbPanel 6');
			//_btnPrev.addEventListener( MouseEvent.MOUSE_DOWN, handlePrev );
			//_btnNext.addEventListener( MouseEvent.MOUSE_DOWN, handleNext );
			//trace('PGPGThumbPanel 7');
		}
		
		public function updateSelectedThumbnail(thumbnailArrayIndex:Number) {
			currentThumbIndex = thumbnailArrayIndex;
			thumbPanel.selectThumbByArrayIndex( currentThumbIndex );
		}
		
		
		private function handlePrev( event:MouseEvent ):void {
			currentThumbIndex --;
			if ( currentThumbIndex < 0 ) currentThumbIndex = 0;
			thumbPanel.selectThumbByArrayIndex( currentThumbIndex );
		}
		
		private function handleNext( event:MouseEvent ):void {
			currentThumbIndex ++;
			if ( currentThumbIndex > thumbsArray.length - 1 ) currentThumbIndex = thumbsArray.length - 1;
			thumbPanel.selectThumbByArrayIndex( currentThumbIndex );
		}

		
		/**
		 * Handle Thumb Click events
		 */
		private function thumbClickHandler( event:ThumbPanelEvent ):void {
			//trace( "PGPGThumbPanel : thumbClickHandler: largeImageURL: " + event.thumbData.getLargeImgUrl());
			// update selected thumb array index
			currentThumbIndex = event.thumbArrayIndex;
		}
	}
}