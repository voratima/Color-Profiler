package com.enlighten.common
{
	import flash.events.Event;
	
	public class ENLToolTipEvent extends Event
	{
		
		public static const SHOW_TOOLTIP:String			= "ENLToolTipEvent_SHOW_TOOLTIP";
		public static const HIDE_TOOLTIP:String			= "ENLToolTipEvent_HIDE_TOOLTIP";
		
		public var properties:Object;
		
		public function ENLToolTipEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, _properties:Object = null):void
		{
			super(type, bubbles, cancelable);
			properties	= _properties;
		}
	}
}