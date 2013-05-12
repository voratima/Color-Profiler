package com.enlighten.events
{
	import flash.events.Event;
	
	public class AnimationEvent extends Event
	{
		
		public static const CONTENT_IN:String		= "AnimationEvent_CONTENT_IN";
		public static const CONTENT_OUT:String		= "AnimationEvent_CONTENT_OUT";
		public static const CONTENT_SET:String		= "AnimationEvent_CONTENT_SET";
		
		public static const SHOW_BLOCK:String		= "AnimationEvent_SHOW_BLOCK";
		public static const HIDE_BLOCK:String		= "AnimationEvent_HIDE_BLOCK";
		
		public static const LOCK_VIEWS:String		= "AnimationEvent_LOCK_VIEWS";
		public static const UNLOCK_VIEWS:String		= "AnimationEvent_UNLOCK_VIEWS";
		
		public var properties:Object;
		
		public function AnimationEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, _properties:Object = null):void
		{
			super(type, bubbles, cancelable);
			properties	= _properties;
		}
	}
}