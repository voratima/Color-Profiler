package com.hunterdouglas.imagine.facetsearch{
	
	import flash.events.MouseEvent;
	
	public class ProductItemEvent extends MouseEvent{
		
		public static const MAKE_SELECTION:String		= "ProductItemEvent_makeSelection";
		public static const CONTENT_READY:String		= "ProductItemEvent_contentReady";
		public var productID:int;
		
		
		public function ProductItemEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, _productID:int = -1):void
		{
			super(type, bubbles, cancelable);
			productID 		= _productID;
		}
	}
}