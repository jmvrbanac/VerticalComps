package 
{
	import com.verticalcue.components.layout.FlowLayout;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author John Vrbanac
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var layout:FlowLayout = new FlowLayout();
			
			var s1:Sprite = createNewTestSprite(0x0, new Rectangle(0, 0, 150, 150));
			var s2:Sprite = createNewTestSprite(0x5051f, new Rectangle(0, 0, 150, 150));
			var s3:Sprite = createNewTestSprite(0xab32f, new Rectangle(0, 0, 150, 150));
			layout.addChild(s1);
			layout.addChild(s2);
			layout.addChild(s3);
			layout.addChild(createNewTestSprite(0xabefa, new Rectangle(0, 0, 150, 150)));

			
			addChild(layout);			
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