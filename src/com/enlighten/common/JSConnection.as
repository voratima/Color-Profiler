package com.enlighten.common
{
	//FLASH TRACKING
	import flash.external.*;
	import flash.net.*;

	public class JSConnection
	{
		
		public static function send(functionName:String, val:String):void 
		{
			try {
				//trace("FlashTrack called - "+functionName+"("+val+")");
				flash.external.ExternalInterface.call(functionName,val);
			} catch (e:Error) {
				navigateToURL(new URLRequest("javascript:"+functionName+"('" + val + "'); void(0);"), "_self");
			}
		}
	}
}