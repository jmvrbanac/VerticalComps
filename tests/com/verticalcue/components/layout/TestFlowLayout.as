package com.verticalcue.components.layout 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	/**
	 * @author John Vrbanac
	 */
	public class TestFlowLayout 
	{
		private var _comp:FlowLayout = new FlowLayout();
		
		public function TestFlowLayout() 
		{
			
		}
		
		[Before]
		public function setUp():void
		{
			_comp = new FlowLayout();
		}
		
		[Test]
		public function testInstantiation():void
		{
			// Basic
			Assert.assertNotNull(_comp);
			
			// Check for invalid parameters, this should throw an error.
			var tmpComp:FlowLayout;
			try {
				tmpComp = new FlowLayout(NaN);
			} catch (err:Error) {
				tmpComp = null;
			}
			Assert.assertNull(tmpComp);
			
		}
		
		[Test]
		public function testProperties():void
		{
			// Check Default
			Assert.assertEquals(500, _comp.width);
			
			// Check for unequal storage
			_comp.width = 100;
			Assert.assertEquals(100, _comp.width);
			Assert.assertFalse(_comp.width == _comp.realWidth);
		}
		
		[Test]
		public function testBasicCanAddChildToRow():void
		{
			// Start with empty display objects
			var child:Sprite = new Sprite();
			var row:Sprite = new Sprite();
			var graphicsContainer:Sprite;
			
			Assert.assertTrue(_comp.canAddChildToRow(child, row));
			
			// Make the child wider than the available space
			graphicsContainer = new Sprite();
			graphicsContainer.graphics.beginFill(0x0, 1);
			graphicsContainer.graphics.drawRect(0, 0, 50, 50);
			graphicsContainer.graphics.endFill();
			child.addChild(graphicsContainer);
			
			_comp.width = 49;
			Assert.assertFalse(_comp.canAddChildToRow(child, row));	
			
			// Lets add a child and try again
			_comp.width = 99;
			row.addChild(child);
			Assert.assertFalse(_comp.canAddChildToRow(child, row));	
			
			// Have just enough room to fit both
			_comp.width = 100;
			Assert.assertTrue(_comp.canAddChildToRow(child, row));
		}
		
		[Test]
		public function testGetActiveRow():void
		{
			// This should give us the first row on a clean object.
			Assert.assertNotNull(_comp.getActiveRow());
		}
		
		[Test]
		public function testAddChild():void
		{
			var s1:Sprite = createNewTestSprite(0x0, new Rectangle(0, 0, 150, 150));
			var s2:Sprite = createNewTestSprite(0x5051f, new Rectangle(0, 0, 150, 150));
			var s3:Sprite = createNewTestSprite(0xababab, new Rectangle(0, 0, 150, 150));
			
			_comp.width = 300;
			_comp.addChild(s1);
			_comp.addChild(s2);
			Assert.assertEquals(2, _comp.getActiveRow().numChildren);
			
			// Checking to make sure addChild creates a new row
			_comp.addChild(s3);
			Assert.assertEquals(1, _comp.getActiveRow().numChildren);
			
		}
		
		[Test]
		[Ignore]
		public function testRemoveChild():void
		{
			// Need to add test
		}
		
		private function createNewTestSprite(color:uint, size:Rectangle):Sprite
		{
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill(color, 1);
			sp.graphics.drawRect(size.x, size.y, size.height, size.width);
			sp.graphics.endFill();
			return sp;
		}
	}

}