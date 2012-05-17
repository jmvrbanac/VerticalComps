package com.verticalcue.components 
{
	import com.verticalcue.components.label.TestTextLabel;
	import com.verticalcue.components.layout.TestFlowLayout;
	/**
	 * Unit Test Suite for VerticalComps
	 * @author John Vrbanac
	 */
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class ComponentTestSuite 
	{
		public var _flowLayout:TestFlowLayout;
		public var _textLabel:TestTextLabel;
		
		public function ComponentTestSuite() 
		{
			
		}
		
	}

}