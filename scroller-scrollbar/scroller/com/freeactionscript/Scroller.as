/**
 * Scroller
 * ---------------------
 * VERSION: 1.0
 * DATE: 4/08/2010
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.FreeActionScript.com
 **/
package com.freeactionscript
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.greensock.TweenLite;
	
	public class Scroller extends MovieClip
	{		
		public function Scroller()
		{
			scrollBar_mc.addEventListener(ScrollBarEvent.VALUE_CHANGED, scrollBarMoved);
		}
		
		private function scrollBarMoved(event:ScrollBarEvent):void
		{
			var newY:Number = -event.scrollPercent * (content_mc.height - mask_mc.height);
			TweenLite.to(content_mc, 1, { y:newY } );
		}
	}
}
