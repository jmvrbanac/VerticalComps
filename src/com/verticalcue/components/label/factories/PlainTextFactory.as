package com.verticalcue.components.label.factories
{
	import flash.display.Sprite;
	import flash.text.engine.TextBlock;
	import flash.text.engine.TextElement;
	import flash.text.engine.TextLine;
	import com.verticalcue.components.label.style.FTEFontStyle;
	import com.verticalcue.components.label.elements.FTETextBlock;
	
	/**
	 * Simple non-formatted text implementation of IMarkupFactory.
	 * @author John Vrbanac
	 */
	public class PlainTextFactory extends MarkupFactory implements IMarkupFactory 
	{
		private var _textBlocks:Vector.<FTETextBlock>;
		private var _te:TextElement;
		
		public function PlainTextFactory() 
		{
			super();
			textBlocks.push(new FTETextBlock());
		}
		
		override public function parse(markup:String, style:FTEFontStyle):void
		{
			
			_te = new TextElement(markup, style.getElementFormat());
			textBlocks[0].content = _te;
		}
		
	}

}