/**
 * @author Rick Witten
 */
package com.enlighten.utils {
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	//
	//
	public class DisplayObjectTools extends Sprite {
		private static var traceOn:Boolean = false;
		//
		/* ALIGNMENT TOKENS */
		public static const LEFT:String			= "l";
		public static const RIGHT:String		= "r";
		public static const CENTER:String		= "c";
		public static const LEFT_EDGE:String	= "le";
		public static const RIGHT_EDGE:String	= "re";
		public static const TOP:String			= "t";
		public static const BOTTOM:String		= "b";
		public static const TOP_EDGE:String		= "te";
		public static const BOTTOM_EDGE:String= "be";
		//
		public static var stg:Stage;
		//
		public function DisplayObjectTools():void {
			addEventListener( Event.ADDED_TO_STAGE, addedToStage );
		}
		private function addedToStage( e:Event ):void {
			removeEventListener( Event.ADDED_TO_STAGE, addedToStage );
			stg = stage;
		}
		//
		/********************
		 * Aligns one display object to another based on horizontal and vertical positioning.
		 *  NOTE: Display objects *may* need to be at the same level (siblings) for this to work.
		 *******************/
		public static function alignObjToRef	(	movingObj:DisplayObject,
													refObj:DisplayObject,
													refHoriz:String = "c",
													refVert:String = "c"
												):void {
			//
			// HORIZONTAL ALIGN
			//
if(traceOn) trace( "alignObjToRef: Mover: (" + int(movingObj.x) + "," + int(movingObj.y) + ") : (" + int(movingObj.width) + "," + int(movingObj.height) +")");
if(traceOn) trace( "alignObjToRef: Mover: (" + int(refObj.x) + "," + int(refObj.y) + ") : (" + int(refObj.width) + "," + int(refObj.height) +")");
			//
			switch ( refHoriz.toLowerCase()) {
				case LEFT:			// Right edge of mover touches left edge of reference
					movingObj.x = refObj.x - movingObj.width;
					break;
				case CENTER:
					movingObj.x = refObj.x + ( refObj.width - movingObj.width ) / 2;
					break;
				case RIGHT:			// Left edge of mover touches right edge of reference
					movingObj.x = refObj.x + refObj.width;
					break;
				case LEFT_EDGE:		// Left edge of mover aligns with x edge of reference
					movingObj.x = refObj.x;
					break;
				case RIGHT_EDGE:	// Right edge of mover aligns with right edge of reference
					movingObj.x = refObj.x + refObj.width - movingObj.width;
					break;
			}
			// VERTICAL ALIGN
			switch ( refVert.toLowerCase()) {
				case TOP:			// Bottom of Mover aligns with Top of reference
					movingObj.y = refObj.y - movingObj.height;
					break;
				case CENTER:
					movingObj.y = refObj.y + ( refObj.height - movingObj.height ) / 2;
					break;
				case BOTTOM:		// Top of Mover aligns with Bottom of reference
					movingObj.y = refObj.y + refObj.height;
					break;
				case TOP_EDGE:		// Top of Mover aligns with Top of reference
					movingObj.y = refObj.y;
					break;
				case BOTTOM_EDGE:	// Bottom of Mover aligns with Bottom of reference
					movingObj.y = refObj.y + ( refObj.height - movingObj.height );
					break;
			}
if(traceOn) trace( "alignObjToRef: END Mover: (" + int(movingObj.x) + "," + int(movingObj.y) + ") : (" + int(movingObj.height) + "," + int(movingObj.width) +")");
			//movingObj = movingObj.getBounds( movingObj.stage );
			//if ( keepOnStage ) {
				//if ( movingObj.x < 15 ) movingObj.x = 15;
				//if ( movingObj.y < 50 ) movingObj.y = 50;
				//if ( movingObj.x + movingObj.width > movingObj.stage.stageWidth ) movingObj.x = movingObj.stage.stageWidth - movingObj.width;
				//if ( movingObj.y + movingObj.height > movingObj.stage.stageHeight ) movingObj.y = movingObj.stage.stageHeight - movingObj.height;
			//}
		}
		/********************
		 * Aligns one display object to another based on horizontal and vertical positioning.
		 *  NOTE: Display objects may need to be at the same level (siblings) for this to work.
		 *******************/
		public static function alignObjToRefGlobal	(	mvObj:DisplayObject,
														refObj:DisplayObject,
														refHoriz:String = "c",
														refVert:String = "c",
														keepOnStage:Boolean = true
													):void {
			//
			// HORIZONTAL ALIGN
			var mvBds:Rectangle = mvObj.getBounds( stg );
			var mvXoff:Number = mvObj.x - mvBds.left;
			var mvYoff:Number = mvObj.y - mvBds.y;
			var refBds:Rectangle = refObj.getBounds( stg );
			//
if(traceOn) trace( "alignObjToRefGlobal: Mover" + stg  + ": (" + int(mvBds.left) + "," + int(mvBds.right) + ") : (" + int(mvBds.height) + "," + int(mvBds.width) +") : (" + int(mvBds.x) + "," + int(mvBds.y) +") : (" + int(mvXoff) + "," + int(mvYoff) + ")");
if(traceOn) trace( "alignObjToRefGlobal: Refer" + stg + ": (" + int(refBds.left) + "," + int(refBds.right) + ") : (" + int(refBds.height) + "," + int(refBds.width) +")");
			//
			var targetX:Number;
			var targetY:Number;
			//
			switch ( refHoriz.toLowerCase()) {
				case LEFT:			// Right edge of mover touches left edge of reference
					targetX = refBds.left - mvObj.width - mvXoff;
					break;
				case CENTER:
					targetX = refBds.left - (( mvBds.width - refBds.width ) / 2 ) + mvXoff;
					break;
				case RIGHT:			// Left edge of mover touches right edge of reference
					targetX = refBds.left + refBds.width + mvXoff;
					break;
				case LEFT_EDGE:		// Left edge of mover aligns with left edge of reference
					targetX = refBds.x + mvXoff;
					break;
				case RIGHT_EDGE:	// Right edge of mover aligns with right edge of reference
					targetX = refBds.x + refBds.width - mvBds.width + mvXoff;
					break;
			}
			// VERTICAL ALIGN
			switch ( refVert.toLowerCase()) {
				case TOP:			// Bottom of Mover aligns with Top of reference
					targetY = refBds.y - mvBds.height + mvYoff;
					break;
				case CENTER:
					targetY = refBds.y - (( mvBds.height - refBds.height ) / 2) + mvYoff;
					break;
				case BOTTOM:		// Top of Mover aligns with Bottom of reference
					targetY = refBds.y + refBds.height + mvYoff;
					break;
				case TOP_EDGE:		// Top of Mover aligns with Top of reference
					targetY = refBds.y + mvYoff;
					break;
				case BOTTOM_EDGE:	// Bottom of Mover aligns with Bottom of reference
					targetY = refBds.y + ( refBds.height - mvBds.height ) + mvYoff;
					break;
			}
			mvObj.x = mvObj.globalToLocal( new Point( targetX, targetY ) ).x;
			mvObj.y = mvObj.globalToLocal( new Point( targetX, targetY ) ).y;
			//
			mvBds = mvObj.getBounds( mvObj.stage );
			if ( false && keepOnStage ) {
				if ( mvBds.x < 15 ) mvObj.x = 15;
				if ( mvBds.y < 15 ) mvObj.y = 15;
				if (( mvBds.x + mvBds.width ) > mvObj.stage.stageWidth ) mvObj.x = mvObj.stage.stageWidth  - mvBds.width  + mvXoff;
				if (( mvBds.y + mvBds.height) > mvObj.stage.stageHeight) mvObj.y = mvObj.stage.stageHeight - mvBds.height + mvYoff;
if(traceOn) trace( "alignObjToRefGlobal: END: Mover: (" + mvObj.stage + ":" + int(mvObj.x) + "," + int(mvObj.y) + ") : (" + int(mvObj.height) + "," + int(mvObj.width) +")");
				//
				mvObj.x = targetX;
			}
		}
	}
}