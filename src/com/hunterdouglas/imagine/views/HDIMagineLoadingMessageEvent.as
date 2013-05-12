package com.hunterdouglas.imagine.views
{
	import flash.events.Event;
	
	public class HDIMagineLoadingMessageEvent extends Event
	{
		
		public static const SHOW:String	= "HDIMagineLoadingMessageEvent_SHOW";
		public static const HIDE:String	= "HDIMagineLoadingMessageEvent_HIDE";
		
		public var properties:Object;
		
		public function HDIMagineLoadingMessageEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, _properties:Object = null):void
		{
			super(type, bubbles, cancelable);
			properties	= _properties;
		}
	}
}