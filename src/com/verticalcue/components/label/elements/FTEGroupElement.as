package com.verticalcue.components.label.elements
{
	import flash.events.EventDispatcher;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.GroupElement;
	
	/**
	 * Designed to eventually be used for paragraphs
	 * @author John Vrbanac
	 */
	public class FTEGroupElement extends GroupElement 
	{
		private var _spacingAbove:Number = 0;
		private var _spacingBelow:Number = 0;
		
		public function FTEGroupElement(elements:Vector.<ContentElement> = null, elementFormat:ElementFormat = null, eventMirror:EventDispatcher = null, textRotation:String = "rotate0") 
		{
			super(elements, elementFormat, eventMirror, textRotation);
		}
		
		public function get spacingAbove():Number { return _spacingAbove; }
		public function set spacingAbove(value:Number):void 
		{
			_spacingAbove = value;
		}
		
		public function get spacingBelow():Number { return _spacingBelow; }
		public function set spacingBelow(value:Number):void 
		{
			_spacingBelow = value;
		}
		
	}

}