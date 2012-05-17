package com.verticalcue.components.label.elements
{
	import flash.text.engine.ContentElement;
	import com.verticalcue.components.label.style.FTEFontStyle;
	/**
	 * Container class for all FTEElements.
	 * @author John Vrbanac
	 */
	public dynamic class FTEElementContainer
	{
		public static const TEXT:String = "text";
		public static const GROUP:String = "group";
		public static const SPRITE:String = "sprite";
		
		public var type:String;
		public var text:String;
		public var style:FTEFontStyle;
		public var name:String;
		public var xml:XML;
		public var parent:FTEElementContainer;
		public var mustContainGroups:Boolean = false;
		private var _vector:Vector.<FTEElementContainer>;
		
		public function FTEElementContainer(parentContainer:FTEElementContainer = null) 
		{
			parent = parentContainer;
			style = new FTEFontStyle();
		}
		public function get numChildren():int
		{
			return _vector ? _vector.length : 0;
		}
		public function getChildAt(index:int):FTEElementContainer 
		{
			return _vector[index];
		}
		public function addChild(container:FTEElementContainer):uint 
		{
			if (_vector == null)
				_vector = new Vector.<FTEElementContainer>();
			return _vector.push(container);	
		}
		public function indexOf(searchElement:FTEElementContainer, fromIndex:int):int 
		{
			return _vector.indexOf(searchElement, fromIndex);
		}		
	}

}