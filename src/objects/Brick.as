package objects 
{
    import flash.display.Sprite;
    import flash.events.*;
	/**
     * ...
     * @author alexander
     */
    public class Brick extends Sprite
    {
        
        public function Brick():void 
        {
            var color:uint = ( Math.random() * 0xFFFFFF );
            this.graphics.lineStyle(1);
			this.graphics.beginFill(color);
			this.graphics.drawRect(0, 0, 19, 20);
			this.graphics.endFill();
            if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
        }
        
        private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
        
        
    }

}