package com.verticalcue.components.label
{
	import com.verticalcue.errors.NotImplementedError;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.text.engine.TextLine;
	import com.verticalcue.components.label.elements.FTETextBlock;
	import com.verticalcue.components.label.factories.*;
	import com.verticalcue.components.label.style.FTEFontStyle;
	import com.verticalcue.components.label.util.FTEUtils;
	import com.verticalcue.components.label.util.SelectionManager;
	
	/**
	 * This component is the basis of a FTE-based TextLabel.
	 * Here be dragons!
	 * @author John Vrbanac
	 */
	public class TextLabel extends Sprite 
	{
		public static const PLAIN:int = 0;
		
		private var _markup:String = "";
		private var _renderingProcessor:int = 0;
		private var _factory:IMarkupFactory;
		private var _defaultStyle:FTEFontStyle;
		private var _container:Sprite;
		private var _buildWidth:Number = 400;
		private var _toFit:Boolean = false;
		private var _selectionManager:SelectionManager;

		public function TextLabel() 
		{
			super();
			_selectionManager = new SelectionManager();
			_selectionManager.parent = this;
			
			// Adding new base container for all text lines
			_container = new Sprite();
		}
		
		/**
		 * This function is designed to add the TextLine container after one frame has passed.
		 * This allows for the player rendering to catch up with what we are drawing.
		 * @param	e
		 */
		private function renderLabel(e:Event):void
		{
			this.removeEventListener(Event.ENTER_FRAME, renderLabel);
			this.addChild(_container);
		}
		
		private function draw():void
		{
			// Pre-mature return if we don't have enough information to draw.
			if (_markup.length <= 0 || !_defaultStyle) {
				return;
			}
			
			// Clean up Container and Factory
			removeChildren();
			if (_factory) {
				_factory.clean();
			}
			
			// We are assuming that this factory will be used by default
			if (_renderingProcessor == TextLabel.PLAIN) {
				_factory = new PlainTextFactory();
			}
			
			_factory.parse(_markup, _defaultStyle);
			_factory.createTextLines(_buildWidth > 0 ? _buildWidth : 400);
			
			var maxLeading:Number = FTEUtils.getMaxLeading(_factory.textBlocks);
			layoutAndAddTextBlocks(_factory.textBlocks, maxLeading, _container);
			
			// Wait one frame for the player to catch up for advanced markup factories.
			this.addEventListener(Event.ENTER_FRAME, renderLabel, false, 0);
		}
		
		private function layoutAndAddTextBlocks(blocks:Vector.<FTETextBlock>, leading:Number, container:Sprite = null):Sprite
		{
			// Create new container if not given one
			if (!container) {
				container = new Sprite();
			}
			
			var nextY:Number = 0;
			for each (var block:FTETextBlock in blocks) {
				var child:Sprite = _factory.renderTextBlock(block, leading);
				child.y = nextY + block.spacingAbove;
				
				container.addChild(child);
				
				// Set the position for the next line
				nextY += block.lastLine.y + block.lastLine.height + block.spacingBelow + block.spacingAbove;
			}
			
			return container;
		}
		
		/**
		 * Diagnostic function designed to let a dev see the boundary of the TextLabel
		 * @param	thickness
		 * @param	color
		 */
		public function drawBorder(thickness:Number, color:uint):void
		{
			this.graphics.clear();
			this.graphics.lineStyle(thickness, color, 1);
			this.graphics.beginFill(color, 0);
			this.graphics.drawRect(0, 0, this.width, this.height);
			this.graphics.endFill();
		}
		
		private function removeChildren():void
		{
			if (_container && _container.parent) {
				this.removeChild(_container);
				
				// Remove rendered text lines
				for (var i:int = 0; i < _container.numChildren; i++) {
					_container.getChildAt(i);
				}
			}
		}
		
		private function getHeightOfTallestChild(container:Sprite):Number
		{
			var tallest:Number = 0;
			for (var i:int = 0; i < container.numChildren; i++) {
				var child:DisplayObject = container.getChildAt(i);
				if (tallest < child.y + child.height) {
					tallest = child.y + child.height;
				}
			}
			return tallest;
		}
		
		/**
		 * Get real height of inner text
		 */
		override public function get height():Number 
		{
			var result:Number = 0;
			
			// Get the real width of the text lines (including any spacing and descent).
			if (_factory && _factory.textBlocks) {
				result += getHeightOfTallestChild(_container);
				result += _factory.lastTextBlock.spacingBelow;
				result += _factory.lastTextBlock.lastLine.descent;
			} else {
				result = super.height;
			}
			
			return result;
		}
		override public function set height(value:Number):void 
		{
			throw new NotImplementedError("You cannot force the height of a TextLabel yet");
		}
		
		public function get text():String { return _markup; }
		public function set text(value:String):void 
		{
			_markup = value;
			draw();
		}
		
		public function get renderingProcessor():int { return _renderingProcessor; }
		public function set renderingProcessor(value:int):void 
		{
			_renderingProcessor = value;
		}
		
		public function get factory():IMarkupFactory { return _factory; }
		public function set factory(value:IMarkupFactory):void 
		{
			_factory = value;
		}
		
		public function get defaultStyle():FTEFontStyle { return _defaultStyle; }
		public function set defaultStyle(value:FTEFontStyle):void 
		{
			_defaultStyle = value;
			draw();
		}
		
		override public function get width():Number { 
			var maxWidth:Number = 0;
			
			// Get the real width if toFit is enabled.
			if (toFit && _factory) {
				for each (var block:FTETextBlock in _factory.textBlocks) {
					var tempWidth:Number = FTEUtils.getMaxLineWidth(block.getTextLines());
					if (tempWidth > maxWidth) {
						maxWidth = tempWidth;
					}
				}
			} else {
				maxWidth = _buildWidth; 
			}
			return maxWidth;
		}
		override public function set width(value:Number):void 
		{
			_buildWidth = value;
			draw();
		}
		
		public function get toFit():Boolean  { return _toFit; }
		public function set toFit(value:Boolean):void 
		{
			_toFit = value;
		}
		
		public function get selectionManager():SelectionManager { return _selectionManager;	}
		public function set selectionManager(value:SelectionManager):void 
		{
			_selectionManager = value;
		}
		
	}

}