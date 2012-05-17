package com.verticalcue.components.label.util
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import flash.text.engine.*;
	import com.verticalcue.components.label.elements.FTETextBlock;
	
	/**
	 * @author John Vrbanac
	 */
	public class FTEUtils 
	{
		public static function layoutTextLines(textBlock:FTETextBlock, leading:Number, fit:Boolean = true, tallest:Number = 0):FTETextBlock
		{
			var yPos:Number = 0;
			var lines:Vector.<TextLine> = textBlock.getTextLines();
			var line:TextLine;
			
			if (fit) {
				tallest = 0;
			}
			
			for each (line in lines) {
				line.y = fit ? yPos + line.textHeight + measureInlineImageRunover(line) : yPos + tallest;
				yPos += fit ? line.textHeight + measureInlineImageRunover(line) + measureInlineImageRunover(line, "decent") + leading : tallest + leading;
			}
			
			return textBlock;
		}
		
		public static function getMaxLeading(blocks:Vector.<FTETextBlock>):Number
		{
			var max:Number = 0;
			for each (var block:FTETextBlock in blocks) {
				var lines:Vector.<TextLine> = block.getTextLines();
				for each (var line:TextLine in lines) {
					var h:Number = line.textHeight + measureInlineImageRunover(line);
					if (h > max) {
						max = h;
					}
				}
			}
			return max;
		}
		
		public static function getMaxLineWidth(lines:Vector.<TextLine>):Number
		{
			var max:Number = 0;
			for each (var line:TextLine in lines) {
				if (max < line.width) {
					max = line.width;
				}
			}
			return max;
		}
		
		public static function getAtomBounds(blocks:Vector.<FTETextBlock>, position:int):Rectangle
		{
			var countedAtoms:int = 0;
			for each (var block:FTETextBlock in blocks) {
				var line:TextLine = block.firstLine;
				while (line) {
					for (var i:int = 0; i < line.atomCount; i++) {
						if (countedAtoms == position) {
							return line.getAtomBounds(i);
						}
						countedAtoms++;
					}
					line = line.nextLine;
				}
			}
			return null;
		}
		
		public static function getLineFromAbsoluteAtom(blocks:Vector.<FTETextBlock>, position:int):TextLine
		{
			var countedAtoms:int = 0;
			for each (var block:FTETextBlock in blocks) {
				var line:TextLine = block.firstLine;
				while (line) {
					for (var i:int = 0; i < line.atomCount; i++) {
						if (countedAtoms == position) {
							return line;
						}
						countedAtoms++;
					}
					line = line.nextLine;
				}
			}
			return null;
		}
		
		public static function getLineContentBounds(line:TextLine):Rectangle
		{
			var heightMax:Number = 0;
			var yMax:Number = 0;
			var firstX:Number = 0;
			var width:Number = 0;
			var i:int = 0;
			var maxNegativeY:Number = 0;
			var maxPositiveY:Number = 0;
			var baseShift:Number;
			
			for (i = 0; i < line.atomCount; i++)
			{
				var bounds:Rectangle = line.getAtomBounds(i);
				var cE:ContentElement = FTEUtils.getContentElementAtAtomIndex(i, line);
								
				width = i == line.atomCount - 1 ? bounds.x + bounds.width : width;
				heightMax = bounds.height > heightMax ? bounds.height : heightMax;
				
				// Get baseline shift if it exists
				baseShift = cE.elementFormat.baselineShift;
				maxNegativeY = baseShift < maxNegativeY ? baseShift + 3 : maxNegativeY;
				maxPositiveY = baseShift > maxPositiveY ? baseShift : maxPositiveY;
				
				yMax = yMax < -bounds.y ? -bounds.y : yMax;
			}
			
			// Deprecated as of FP 10.1 - Enable if using 10.0.x players
			//line.flushAtomData();
			
			return new Rectangle(0, -(yMax - maxNegativeY), width, int(heightMax - maxNegativeY + 1.5));
		}

		public static function getContentElementAtAtomIndex(index:int, line:TextLine):ContentElement
		{
			var gE:GroupElement = line.textBlock.content as GroupElement;
			if (gE) {
				return gE.getElementAtCharIndex(index);
			} else {
				return null;
			}
				
		}
		
		/**
		 * Returns the spacing between ascent/decent and the tallest inline image. measureFrom accepts "ascent" and "decent"
		 * @param	tf
		 * @param	measureFrom
		 * @return
		 */
		public static function measureInlineImageRunover(txtLine:TextLine, measureFrom:String = "ascent"):Number
		{
			var value:Number = 0;
			var tallest:Number = 0;
			if (txtLine) 
			{
				for (var i:int = 0; i < txtLine.atomCount; i++) {
					var dObj:DisplayObject = txtLine.getAtomGraphic(i);
					if (dObj != null) {
						var rect:Rectangle = txtLine.getAtomBounds(i);
						if ( -rect.y > tallest && measureFrom == "ascent") {
							tallest = -rect.y;
						} else if ( rect.bottom > tallest && measureFrom == "decent") {
							tallest = rect.bottom;
						}
					}
				}
				if (measureFrom == "ascent") {
					value = tallest - txtLine.ascent;
				} else {
					value = tallest - txtLine.descent;
				}
			}
			return (value > 0 ? value : 0);
		}
	}

}