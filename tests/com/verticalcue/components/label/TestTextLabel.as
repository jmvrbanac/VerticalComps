package com.verticalcue.components.label 
{
	import com.verticalcue.components.label.style.FTEFontStyle;
	import com.verticalcue.components.label.util.FTEUtils;
	import org.flexunit.Assert;
	/**
	 * ...
	 * @author John Vrbanac
	 */
	public class TestTextLabel 
	{
		private var _comp:TextLabel;
		public function TestTextLabel() 
		{
			
		}
		
		[Before]
		public function setUp():void
		{
			_comp = new TextLabel();
		}
		
		[Test]
		public function testInstantiation():void
		{
			Assert.assertNotNull(_comp);
		}
		
		[Test]
		public function testBasicTextDrawing():void
		{
			_comp.text = "Test text";
			
			// Making sure that it hasn't draw yet. It shouldn't do this until it gets a valid style.
			Assert.assertEquals(0, _comp.height);
			
			_comp.defaultStyle = new FTEFontStyle();
			
			// Now it should have a height. 
			// Allowing a margin of error of 1px for AA
			Assert.assertTrue(_comp.height >= 14 && _comp.height <= 15);
		}
		
		[Test]
		public function testMultiLineText():void
		{
			_comp.text = "First line\nSecond line";
			_comp.defaultStyle = new FTEFontStyle();
			
			// Allowing a margin of error of 1px for AA
			Assert.assertTrue(_comp.height <= 41.4 && _comp.height >= 40.4);
		}
		
		[Test]
		public function testFontSize():void
		{
			var style:FTEFontStyle = new FTEFontStyle();
			style.size = 10;
			_comp.text = "First line\nSecond line";
			_comp.defaultStyle = style;
			
			
			// Allowing a margin of error of 1px for AA
			Assert.assertTrue(_comp.height <= 37 && _comp.height >= 36);
		}
		
		[Test]
		public function testToFit():void
		{
			_comp.text = "First line\nSecond line";
			_comp.toFit = true;
			_comp.defaultStyle = new FTEFontStyle();
			
			Assert.assertEquals(72, _comp.width);
		}
		
		[Test]
		public function testKerning():void
		{
			var style:FTEFontStyle = new FTEFontStyle();
			style.size = 10;
			style.kerning = 10;
			_comp.text = "First line\nSecond line";
			_comp.toFit = true;
			_comp.defaultStyle = style;
			
			Assert.assertEquals(137, _comp.factory.textBlocks[0].firstLine.width);
		}
		
	}

}