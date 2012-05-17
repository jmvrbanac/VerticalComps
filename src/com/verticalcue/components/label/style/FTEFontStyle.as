package com.verticalcue.components.label.style
{
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontMetrics;
	import flash.text.engine.FontPosture;
	import flash.text.engine.FontWeight;
	import flash.text.engine.TextBaseline;
	/**
	 * Style Adapter for FTE ElementFormats
	 * @author John Vrbanac
	 */
	public class FTEFontStyle 
	{
		public static const NONE:int = 0;
		public static const SUBSCRIPT:int = 1;
		public static const SUPERSCRIPT:int = 2;
		 
		private var _size:Number = 12;
		private var _color:* = 0x000000;
		private var _family:String = "Verdana";
		private var _fontLookup:String = FontLookup.DEVICE;
		private var _kerning:Number;
		private var _weight:String = FontWeight.NORMAL;
		private var _posture:String = FontPosture.NORMAL;
		private var _baselineShift:Number = 0;
		private var _typegraphicModification:int = 0;
		private var _baselineAlignment:String = TextBaseline.USE_DOMINANT_BASELINE;
		private var _spacingAbove:Number = 0;
		private var _spacingBelow:Number = 0;
		private var _firstLineIndention:int = 0;
		private var _tabSize:int = 0;
		private var _alignment:String = "left";
		
		public function FTEFontStyle() 
		{
			
		}
		public function clone():FTEFontStyle
		{
			var nS:FTEFontStyle = new FTEFontStyle();
			nS.color = _color;
			nS.family = _family;
			nS.size = _size;
			nS.fontLookup = _fontLookup;
			nS.weight = _weight;
			nS.posture = _posture;
			nS.kerning = _kerning;
			nS.baselineShift = _baselineShift;
			nS.baselineAlignment = _baselineAlignment;
			nS.typegraphicModification = _typegraphicModification;
			nS.spacingAbove = _spacingAbove;
			nS.spacingBelow = _spacingBelow;
			nS.firstLineIndention = _firstLineIndention;
			nS.tabSize = _tabSize;
			return nS;
		}
		public function getElementFormat():ElementFormat
		{
			var fD:FontDescription = new FontDescription(_family, _weight, _posture, _fontLookup);
			var eF:ElementFormat = new ElementFormat(fD, _size, _color, 1, "auto", TextBaseline.ROMAN, _baselineAlignment, _baselineShift, "on", _kerning / 2, _kerning / 2);
			var metrics:FontMetrics = eF.getFontMetrics();
			if (_typegraphicModification == 1) {
				eF.fontSize = _size * metrics.subscriptScale;
				eF.baselineShift = _size * metrics.subscriptOffset;
			} else if (_typegraphicModification == 2) {
				eF.fontSize = _size * metrics.superscriptScale;
				eF.baselineShift = _size* metrics.superscriptOffset;
			}
			return eF;
		}
		
		public static function get developmentStyle():FTEFontStyle
		{
			var style:FTEFontStyle = new FTEFontStyle();
			style.size = 16;
			style.family = "Verdana";
			style.fontLookup = FontLookup.EMBEDDED_CFF;
			style.spacingAbove = 10;
			style.spacingBelow = 10;
			style.tabSize = 4;
			style.firstLineIndention = 0;
			style.alignment = "left";
			return style;
		}
		
		public function get size():Number { return _size; }
		public function set size(value:Number):void 
		{
			_size = value;
		}
		
		public function get color():uint { return _color; }
		public function set color(value:uint):void 
		{
			_color = value;
		}
		
		public function get family():String { return _family; }
		public function set family(value:String):void 
		{
			_family = value;
		}
		
		public function get kerning():Number { return _kerning; }
		public function set kerning(value:Number):void 
		{
			_kerning = value;
		}
		
		public function get weight():String { return _weight; }
		public function set weight(value:String):void 
		{
			_weight = value.toLowerCase() == "bold" ? "bold" : "normal";
		}
		
		public function get posture():String { return _posture; }
		public function set posture(value:String):void 
		{
			_posture = value.toLowerCase() == "italic" ? "italic" : "normal";
		}
		
		public function get fontLookup():String { return _fontLookup; }
		public function set fontLookup(value:String):void 
		{
			_fontLookup = value;
		}
		
		public function get baselineShift():Number { return _baselineShift; }
		public function set baselineShift(value:Number):void 
		{
			_baselineShift = value;
		}
		
		public function get baselineAlignment():String { return _baselineAlignment; }
		public function set baselineAlignment(value:String):void 
		{
			_baselineAlignment = value;
		}
		
		public function get typegraphicModification():int { return _typegraphicModification; }
		public function set typegraphicModification(value:int):void 
		{
			_typegraphicModification = value;
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
		
		public function get firstLineIndention():int { return _firstLineIndention; }
		public function set firstLineIndention(value:int):void 
		{
			_firstLineIndention = value;
		}
		
		public function get tabSize():int { return _tabSize; }
		public function set tabSize(value:int):void 
		{
			_tabSize = value;
		}
		
		public function get alignment():String { return _alignment;	}
		public function set alignment(value:String):void 
		{
			_alignment = value;
		}
		
	}

}