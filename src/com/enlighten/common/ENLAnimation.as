/**
* Path that control live and local XML load
* @author Enlighten: Voratima Orawannukul
*/
package com.enlighten.common
{
	import flash.filters.*;
	import com.greensock.*;
	import com.greensock.easing.*;
	
	public class ENLAnimation {
		
		public static const TWEEN_TIME:Number 		= 1;
		public static const MENU_DELAY:Number		= 0.3;
		public function ENLAnimation():void
		{
			
		}
		public static function getBlurFilter(bx:Number=40, by:Number=20):BitmapFilter
		{
			var blurX:Number = bx;
            var blurY:Number = by;
            return new BlurFilter(blurX, blurY, BitmapFilterQuality.HIGH);

		}
		public static function getGlowFilter(_color:uint = 0xFFFFFF, _alp:Number = 0.85, _blurX:Number=4, _blurY:Number=4, _strength:Number = 1):BitmapFilter
		{
          return new GlowFilter(_color, _alp, _blurX, _blurY, _strength, BitmapFilterQuality.HIGH, false, false);
		}
		public static function getDropShadowFilter(_color:uint = 0xFFFFFF, _angle:Number = 45, _alp:Number = 0.85, _blurX:Number=4, _blurY:Number=4, _distance:Number=3, _strength:Number = 1):BitmapFilter
		{
          return new DropShadowFilter(_distance, _angle, _color, _alp, _blurX, _blurY, _strength, BitmapFilterQuality.HIGH, false, false);		  
		}
		public static function showObject(_obj:*, _time:Number = 1, _delay:Number = 0):void
		{
			_obj.visible	= true;
			new TweenLite(_obj, _time, {alpha:1, delay:_delay});
		}
		public static function hideObject(_obj:*, _time:Number = 1, _delay:Number = 0):void
		{
			new TweenLite(_obj, _time, {alpha:0, delay:_delay, onComplete:onHideObjectComplete, onCompleteParams:[_obj]});
		}
		public static function onHideObjectComplete(...args):void
		{
			args[0].visible	= false;
		}
		public static function initObject(_obj:*):void
		{
			_obj.alpha			= 0;
			_obj.visible		= false;
		}
	}
}