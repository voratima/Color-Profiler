/**
* Path that control live and local XML load
* @author Enlighten: Voratima Orawannukul
*/
//PRODUCT LIST
		//http://hunter-dev.enlighten.com/content.jsp?object=Product&fields=ProductTradeName
		//STYLE LIST
		//http://hunter-dev.enlighten.com/content.jsp?object=GalleryStyle
		//ROOM LIST
		//http://hunter-dev.enlighten.com/content.jsp?object=GalleryRoom
		//STYLE SEARCH
		//http://hunter-dev.enlighten.com/content.jsp?object=GalleryImage&id=1&refobject=GalleryStyle
		//ROOM SEARCH
		//http://hunter-dev.enlighten.com/content.jsp?object=GalleryImage&id=1&refobject=GalleryRoom
		//PRODUCT SEARCH
		//http://hunter-dev.enlighten.com/content.jsp?object=GalleryImage&id=1&refobject=Product
package com.hunterdouglas.photogallery {

	public class Path {
		//REMOTE
		
		public static const ROOT:String 			= "";//"http://hunter-dev.enlighten.com";
		public static const CONTENT:String 			= ROOT+"/content.jsp?";
		public static const PG_OVERLAY:String 		= ROOT+"/flash/mainsite/PhotoGalleryOverlay.swf";
		
		public static const NAV:String				= ROOT+"/flash/mainsite/xml/photogallery-en.xml";
		public static const FONT4:String			= ROOT+"/flash/mainsite/HDFonts4.swf";
		public static const FONT5:String			= ROOT+"/flash/mainsite/HDFonts5.swf";
		public static const PRODUCT_LIST:String 	= CONTENT + "object=Product&fields=ProductTradeName";
		public static const ROOM_LIST:String 		= CONTENT + "object=GalleryRoom";
		public static const STYLE_LIST:String 		= CONTENT + "object=GalleryStyle";
		public static const PRODUCT_SEARCH:String 	= CONTENT + "object=GalleryImage&refobject=Product&id=1";
		public static const ROOM_SEARCH:String 		= CONTENT + "object=GalleryImage&refobject=GalleryRoom&id=1";
		public static const STYLE_SEARCH:String 	= CONTENT + "object=GalleryImage&refobject=GalleryStyle&id=1";
		/*
		//LOCAL
		public static const ROOT:String 			= ".";
		public static const CONTENT:String 			= ROOT+"/content_jsp_xml";
		public static const PG_OVERLAY:String 		= ROOT+"/PhotoGalleryOverlay.swf";
		
		public static const NAV:String				= "xml/photogallery-en.xml";
		public static const FONT4:String			= "./HDFonts4.swf";
		public static const FONT5:String			= "./HDFonts5.swf";
		public static const PRODUCT_LIST:String 	= CONTENT + "/photogallery-product-list.xml";
		public static const ROOM_LIST:String 		= CONTENT + "/photogallery-room-list.xml";
		public static const STYLE_LIST:String 		= CONTENT + "/photogallery-style-list.xml";
		public static const PRODUCT_SEARCH:String 	= CONTENT + "/photogallery-product-search.xml";
		public static const ROOM_SEARCH:String 		= CONTENT + "/photogallery-room-search.xml";
		public static const STYLE_SEARCH:String 	= CONTENT + "/photogallery-style-search.xml";
		*/
		public function Path():void
		{
			
		}
	}
}