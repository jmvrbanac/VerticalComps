package com.verticalcue.components.label.factories
{
	import flash.display.Sprite;
	import com.verticalcue.components.label.style.FTEFontStyle;
	import com.verticalcue.components.label.elements.FTETextBlock;
	
	/**
	 * Interface for markup factories used with the TextLabel
	 * @author John Vrbanac
	 */
	public interface IMarkupFactory 
	{
		function parse(markup:String, defaultFontStyle:FTEFontStyle):void;
		function renderTextBlock(txtBlock:FTETextBlock, maxLeading:Number = 0):Sprite;
		function createTextLines(buildWidth:int = 100):void;
		function get textBlocks():Vector.<FTETextBlock>;
		function set textBlocks(value:Vector.<FTETextBlock>):void;
		function get lastTextBlock():FTETextBlock;
		function clean():void;
	}
	
}