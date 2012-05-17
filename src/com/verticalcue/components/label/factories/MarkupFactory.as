package com.verticalcue.components.label.factories 
{
	import flash.geom.Rectangle;
	import flash.display.Sprite;
	import flash.text.engine.TextLine;

	import com.verticalcue.components.label.util.FTEUtils;
	import com.verticalcue.components.label.style.FTEFontStyle;
	import com.verticalcue.components.label.style.FTETextAlign;
	import com.verticalcue.components.label.elements.FTETextBlock;
	
	/**
	 * Base factory class
	 * @author John Vrbanac
	 */
	public class MarkupFactory implements IMarkupFactory
	{
		private var _textBlocks:Vector.<FTETextBlock>;
		
		public function MarkupFactory() 
		{
			_textBlocks = new Vector.<FTETextBlock>();
		}
		public function parse(markup:String, defaultFontStyle:FTEFontStyle):void 
		{

		}
		
		public function renderTextBlock(txtBlock:FTETextBlock, maxLeading:Number = 0):Sprite
		{
			txtBlock = FTEUtils.layoutTextLines(txtBlock, 15, false, maxLeading);
			
			var tmpLines:Vector.<TextLine> = txtBlock.getTextLines();
			var container:Sprite = new Sprite();
			var max:Number = FTEUtils.getMaxLineWidth(tmpLines);
			
			for each (var tempLine:TextLine in tmpLines) {
				var lineContainer:Sprite = new Sprite();
				lineContainer.addChild(tempLine);
				container.addChild(lineContainer);
				if (txtBlock.alignment == FTETextAlign.RIGHT)
					lineContainer.x =  txtBlock.contentWidth - lineContainer.width;
				else if (txtBlock.alignment == FTETextAlign.CENTER)
					lineContainer.x =  (txtBlock.contentWidth - lineContainer.width) / 2;
			}
			
			return container;
		}
		
		public function createTextLines(buildWidth:int = 100):void
		{
			for each (var block:FTETextBlock in _textBlocks) {
				var txtLine:TextLine = block.createTextLine(null, buildWidth);
				while (txtLine)
					txtLine = block.createTextLine(txtLine, buildWidth);
			}
		}
		
		public function clean():void
		{
			for each (var block:FTETextBlock in _textBlocks) {
				block.release();
				
			}
		}
		
		public function get textBlocks():Vector.<FTETextBlock> { return _textBlocks; }
		public function set textBlocks(value:Vector.<FTETextBlock>):void 
		{
			_textBlocks = value;
		}
		
		public function get lastTextBlock():FTETextBlock { return _textBlocks[_textBlocks.length - 1]; }
		
	}

}