package com.verticalcue.components.label.elements
{
	import adobe.utils.CustomActions;
	import flash.text.engine.ContentElement;
	import flash.text.engine.FontDescription;
	import flash.text.engine.TextBlock;
	import flash.text.engine.TextJustifier;
	import flash.text.engine.TextLine;
	import flash.text.engine.TabStop;
	import com.verticalcue.components.label.style.FTETextAlign;
	
	/**
	 * ...
	 * @author John Vrbanac
	 */
	public class FTETextBlock 
	{
		private var _spacingAbove:Number = 0;
		private var _spacingBelow:Number = 0;
		private var _maxLeading:Number = 0;
		private var _textBlock:TextBlock;
		private var _width:Number = 0;
		private var _alignment:String = FTETextAlign.LEFT;
		
		public function FTETextBlock(content:ContentElement = null, tabStops:Vector.<TabStop> = null, textJustifier:TextJustifier = null, lineRotation:String = "rotate0", baselineZero:String = "roman", bidiLevel:int = 0, applyNonLinearFontScaling:Boolean = true, baselineFontDescription:FontDescription = null, baselineFontSize:Number = 12) 
		{
			_textBlock = new TextBlock(content, tabStops, textJustifier, lineRotation, baselineZero, bidiLevel, applyNonLinearFontScaling, baselineFontDescription, baselineFontSize);
		}
		
		public function getTextLines():Vector.<TextLine>
		{
			var vect:Vector.<TextLine> = new Vector.<TextLine>();
			var tl:TextLine = _textBlock.firstLine;
			while (tl) {
				vect.push(tl);
				tl = tl.nextLine;
			}
			return vect;
			
		}
		
		public function release():void
		{
			_textBlock.releaseLines(_textBlock.firstLine, _textBlock.lastLine);
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
		
		public function get textBlock():TextBlock { return _textBlock; }
		public function set textBlock(value:TextBlock):void 
		{
			_textBlock = value;
		}
		
		public function get content():ContentElement { return _textBlock.content; }
		public function set content(value:ContentElement):void 
		{
			_textBlock.content = value;
		}
		
		public function get contentHeight():Number
		{
			return _textBlock.lastLine.y + _textBlock.lastLine.height;
		}
		
		public function get firstLine():TextLine { return _textBlock.firstLine; }
		public function get lastLine():TextLine { return _textBlock.lastLine; }
		
		public function get maxLeading():Number { return _maxLeading; }
		public function set maxLeading(value:Number):void 
		{
			_maxLeading = value;
		}
		
		/**
		 * Returns the widest created line
		 */
		public function get contentWidth():Number { return _width; }
		
		public function get alignment():String { return _alignment; }
		public function set alignment(value:String):void 
		{
			_alignment = value;
		}
		
		// Composited Override
		public function createTextLine(previousLine:TextLine = null, width:Number = 1000000, lineOffset:Number = 0, fitSomething:Boolean = false):TextLine
		{
			if (width > _width)
				_width = width;
			return _textBlock.createTextLine(previousLine, width, lineOffset, fitSomething);
		}
		
		
	}

}