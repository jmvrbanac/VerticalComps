package com.verticalcue.components.layout 
{
	import com.verticalcue.errors.InvalidParameterError;
	import com.verticalcue.errors.NotImplementedError;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * This component is designed to dynamically flow its children.
	 * @author John Vrbanac
	 */
	public class FlowLayout extends Sprite 
	{
		private var _hSpacing:Number = 0;
		private var _vSpacing:Number = 0;
		private var _rows:Vector.<Sprite>;
		private var _layoutWidth:int;
		
		public function FlowLayout(defaultWidth:Number = 500) 
		{
			super();
			
			if (isNaN(defaultWidth)) {
				throw new InvalidParameterError();
			}
			
			_layoutWidth = defaultWidth;
			
			// Initialize and add empty row.
			_rows = new Vector.<Sprite>();
			_rows.push(new Sprite());
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject 
		{
			var row:Sprite = getRowContainingChild(child);
			row.removeChild(child);
			
			// Need to implement a row rebuilding function
			
			return child;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject 
		{
			// Check to see if we need to create a new row.
			var activeRow:Sprite = getActiveRow();
			if (!canAddChildToRow(child, activeRow)) {
				activeRow = new Sprite();
				_rows.push(activeRow);
			}
			
			// Add child to row
			activeRow = addChildToRow(child, activeRow);
			
			layoutAndAddRows();
			
			return child;
		}
		
		internal function layoutAndAddRows():void
		{
			var yPosition:Number = 0;
			for (var i:int = 0; i < _rows.length; i++)
			{
				var row:Sprite = _rows[i];
				row.y = yPosition;
				
				yPosition += row.height + _vSpacing;
				
				// Add row if not on the display list.
				// I am assuming that this will only happen when a new row is created.
				if (!contains(row)) {
					super.addChild(row);
				}
			}
		}
		
		internal function getActiveRow():Sprite
		{
			var result:Sprite = null;
			if (_rows && _rows.length > 0) {
				result = _rows[_rows.length - 1];
			}
			return result;
		}
		
		internal function canAddChildToRow(child:DisplayObject, row:Sprite):Boolean
		{
			if (!child || !row) {
				throw new InvalidParameterError();
			}
			
			var result:Boolean = true;
			var totalWidth:Number = row.width;
			totalWidth += child.width;
			totalWidth += _hSpacing;
			
			if (totalWidth > _layoutWidth) {
				result = false;
			}
			
			return result;
		}
		
		/**
		 * @param	child
		 * @param	row
		 * @return  Returns the modified row.
		 */
		internal function addChildToRow(child:DisplayObject, row:Sprite):Sprite
		{
			child.x = row.width + _hSpacing;
			row.addChild(child);
			return row;
		}
		
		internal function rebuildRows():void
		{			
			throw new NotImplementedError();
		}
		
		private function getRowContainingChild(child:DisplayObject):Sprite
		{
			var result:Sprite = null;
			for each (var row:Sprite in _rows) {
				if (row.contains(child)) {
					result = row;
				}
			}
			return result;
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject 
		{
			throw new NotImplementedError();
			return null;
		}
		override public function removeChildAt(index:int):DisplayObject 
		{
			throw new NotImplementedError();
			return null;
		}
		
		/*
		 * ------------
		 * Properties
		 * ------------
		 */ 
		
		public function get hSpacing():Number { return _hSpacing; }
		public function set hSpacing(value:Number):void 
		{
			_hSpacing = value;
		}
		
		public function get vSpacing():Number { return _vSpacing; }
		public function set vSpacing(value:Number):void 
		{
			_vSpacing = value;
		}
		
		public function get realWidth():Number { return super.width; }
		override public function get width():Number { return _layoutWidth; }
		override public function set width(value:Number):void 
		{
			_layoutWidth = value;
		}
	}

}