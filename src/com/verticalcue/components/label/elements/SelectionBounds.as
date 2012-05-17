package com.verticalcue.components.label.elements 
{
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author John Vrbanac
	 */
	public class SelectionBounds extends Rectangle 
	{
		public var baseline:Number = 0;
		
		public function SelectionBounds(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0, baselineOfSelection:Number = 0) 
		{
			super(x, y, width, height);
			baseline = baselineOfSelection;
		}
		
	}

}