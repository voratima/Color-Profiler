package com.hunterdouglas.photogallery{
	
	import flash.events.MouseEvent;
	
	public class HDComboBoxEvent extends MouseEvent{
		
		public static const SELECTED:String = "selected";
		public static const CHANGE:String = "change";
		public static const ACTIVE:String = "active";
		
		public var label:String;
		public var id:int;
		
		public function HDComboBoxEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, _label:String = null, _id:int = -1):void
		{
			super(type, bubbles, cancelable);
			label = _label;
			id = _id;
		}
	}
}