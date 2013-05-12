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
	
	public class PGTab extends Sprite {
		// FOLLOWING DEFINED IN .FLA FILE:
		// tab_background_mc 
		// arrow_mc
		
		
		function PGTab() {
			resetBackgroundAndArrow();
		}
		
		public function resetBackgroundAndArrow() {
			resetBackgroundColor();
			setArrowDown();
		}
		
		public function setArrowDown() {
			arrow_mc.gotoAndStop(1);
		}
		public function setArrowUp() {
			arrow_mc.gotoAndStop(2);
		}
		public function setBackgroundColor(colorValue:Number) {
			var colorInfo:Color = new Color();
			colorInfo.setTint(colorValue, 1);
			tab_background_mc.transform.colorTransform = colorInfo;
		}
		public function resetBackgroundColor() {
			setBackgroundColor(0x000000);			
		}
	}
}