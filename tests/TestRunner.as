package  
{
	import com.verticalcue.components.ComponentTestSuite;
	import org.flexunit.internals.TraceListener;
	import org.flexunit.runner.FlexUnitCore;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author John Vrbanac
	 */
	public class TestRunner extends Sprite
	{
		private var _core:FlexUnitCore;
		
		public function TestRunner() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_core = new FlexUnitCore();
			_core.addListener(new TraceListener());
			_core.run(ComponentTestSuite);
		}
	}

}