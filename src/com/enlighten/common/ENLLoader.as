package com.enlighten.common
{
	import flash.events.*;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	
	import flash.events.EventDispatcher;
	import flash.events.Event;
	
	public class ENLLoader extends EventDispatcher
	{
		private var url:String;
		private var xml_data:XML;
		private var urlLoader:URLLoader;
		private var urlRequest:URLRequest;
		
		public function ENLLoader():void//xml_path:String)
		{
			/*
			//trace("ENLLoader : xml_path:"+xml_path);
			urlRequest = new URLRequest(xml_path);
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, loadComplete);
			urlLoader.load(urlRequest); 
			*/
		}
		public function load(xml_path:String)
		{
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, loadComplete);
			/*urlLoader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
*/
			urlLoader.load(new URLRequest(xml_path)); 
		}
		private function loadComplete(e:Event):void
		{
			//trace("loadComplete:");
			var xml = new XML(e.target.data);
			xml_data = xml;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		/*
		private function progressHandler(event:ProgressEvent):void {
            trace("################ progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
        }
        private function securityErrorHandler(event:SecurityErrorEvent):void {
            trace("################ securityErrorHandler: " + event);
        }
        private function httpStatusHandler(event:HTTPStatusEvent):void {
            trace("################ httpStatusHandler: " + event);
        }
        private function ioErrorHandler(event:IOErrorEvent):void {
            trace("################ ioErrorHandler: " + event);
        }
*/
		public function get data():XML{
			return xml_data;
		}
	}
}