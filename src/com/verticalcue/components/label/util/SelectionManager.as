package com.verticalcue.components.label.util 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.engine.ContentElement;
	import flash.text.engine.TextLine;
	import com.verticalcue.components.label.elements.FTETextBlock;
	import com.verticalcue.components.label.elements.SelectionBounds;
	import com.verticalcue.components.label.factories.IMarkupFactory;
	import com.verticalcue.components.label.TextLabel;
	/**
	 * @author John Vrbanac
	 */
	public class SelectionManager 
	{
		public static const UNDERLINE_AT_BASELINE:String = "baseline";
		public static const UNDERLINE_AT_BOTTOM:String = "bottom";
		
		private var _parent:TextLabel;
		private var _factory:IMarkupFactory;
		private var _selection:Point;
		private var _selectionRects:Vector.<SelectionBounds>
		
		public function SelectionManager() 
		{
			_selection = new Point();
			_selectionRects = new Vector.<SelectionBounds>();
		}
		
		public function setSelection(start:int, end:int):void 
		{
			_factory = _parent.factory;
			_selection.x = start;
			_selection.y = end;
		}
		
		
		/**
		 * Designed to create a group of selection rectangles across all TextBlocks and TextLines
		 */
		private function createSelectionRectangles():void
		{
			_selectionRects = new Vector.<SelectionBounds>();
			var totalCountedAtoms:int = 0;
			var startLine:TextLine = null;
			var endLine:TextLine = null;
			var lineBounds:Rectangle = null;
			
			if (_factory) {
				// TODO: Refactor this. 
				for each (var block:FTETextBlock in _factory.textBlocks) {
					var line:TextLine = block.firstLine;
					while (line) {
						var pointA:Point = null;
						var pointB:Point = null;
						
						for (var i:int = 0; i < line.atomCount; i++) {
							var atomBounds:Rectangle = line.getAtomBounds(i);
							var select:Number = startLine == null ? _selection.x : _selection.y;
							if ((select <= totalCountedAtoms + (line.atomCount - i)) && (select >= totalCountedAtoms)) {
								if (select == totalCountedAtoms) {
									if (startLine != null) {
										endLine = line;
										pointB = new Point(atomBounds.x, atomBounds.y);
										if (endLine != startLine)
											pointA = new Point(line.x, atomBounds.y);
									} else {
										startLine = line;
										pointA = new Point(atomBounds.x, atomBounds.y);
										if (_selection.y > totalCountedAtoms + (line.atomCount - i))
											pointB = new Point(line.width, atomBounds.y);
									}
								}
								
							}
							if (line != startLine && _selection.x < totalCountedAtoms && _selection.y > totalCountedAtoms + (line.atomCount - i)) {
								lineBounds = FTEUtils.getLineContentBounds(line);
								pointA = new Point(lineBounds.x, lineBounds.y);
								pointB = new Point(lineBounds.width, lineBounds.y);
							}
							
							totalCountedAtoms++;
						}
						if (pointA && pointB) {
							lineBounds = FTEUtils.getLineContentBounds(line);
							_selectionRects.push(new SelectionBounds(pointA.x, line.localToGlobal(new Point(line.x,line.y)).y - line.y + lineBounds.y, pointB.x - pointA.x, lineBounds.height, lineBounds.height - line.descent));
						}
						
						// Deprecated as of FP 10.1 - Enable if using 10.0.x players
						//line.flushAtomData();
						
						line = line.nextLine;
					}
				}
			}
		}
		public function underlineSelection(thickness:Number, color:uint, position:String):void
		{
			createSelectionRectangles();
			var drawLayer:Sprite = new Sprite();
			drawLayer.name = "underlineLayer";
			for each (var rect:SelectionBounds in _selectionRects) {
				var s:Sprite = new Sprite();
				s.graphics.lineStyle(thickness, color);
				if (position == SelectionManager.UNDERLINE_AT_BASELINE)
					s.graphics.drawRect(rect.x, rect.y + rect.baseline, rect.width, 0);
				else
					s.graphics.drawRect(rect.x, rect.y + rect.height, rect.width, 0);
					
				drawLayer.addChild(s);
			}
			_parent.addChildAt(drawLayer, 0);
		}
		public function highlightSelection(color:uint, alpha:Number):void
		{
			createSelectionRectangles();
			
			var drawLayer:Sprite = new Sprite();
			drawLayer.name = "drawLayer";
			for each (var rect:SelectionBounds in _selectionRects) {
				var s:Sprite = new Sprite();
				s.graphics.beginFill(color, alpha);
				s.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
				s.graphics.endFill();
				s.graphics.lineStyle(1, 0x000000);
				s.graphics.drawRect(rect.x, rect.y + rect.baseline, rect.width, 1);
				drawLayer.addChild(s);
			}
			_parent.addChildAt(drawLayer, 0);
		}		
		
		public function get parent():TextLabel { return _parent; }
		public function set parent(value:TextLabel):void 
		{
			_parent = value;
		}
		
	}

}