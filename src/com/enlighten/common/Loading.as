package com.enlighten.common
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	
	
	public class Loading extends MovieClip
	{
		private var loading:SimpleLoadingAnimation;
		private var background:Shape
		
		public function Loading():void 
		{			
			loading	= new SimpleLoadingAnimation();
			addChild(loading);
			hide();
		}
		public function createBackground(_w:Number, _h:Number, _backgroundColor:uint = 0xFFDD00, _backgroundAlpha:Number=0.5):void
		{
			background = new Shape();
			background.graphics.beginFill(_backgroundColor);
			
			background.graphics.drawRect(0, 0, _w, _h);
			background.graphics.endFill();
			background.alpha =_backgroundAlpha;
			addChildAt(background, 0);

			loading.x = (background.width - loading.width)/2;
			loading.y = (background.height - loading.height)/2;
		}
		public function adjustBackground(_w:Number, _h:Number):void
		{
			background.width	= _w;
			background.height	= _h;
			loading.x = (background.width - loading.width)/2;
			loading.y = (background.height - loading.height)/2;
		}
		public function show():void
		{
			visible	= true;
			loading.play();		
		}
		public function hide():void
		{
			visible = false;
			loading.stop();
		}
	}
}