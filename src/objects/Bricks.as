package objects 
{
    import flash.display.Sprite;
    import flash.display.Stage;
	/**
     * ...
     * @author alexander
     */
    public class Bricks extends Sprite
    {
        public var brick_symb:Brick_symb;
        public var bricks:Array = [1,1,1,1,1,1,1,1];
        public var s:Stage;
        
        public function Bricks(s:Stage):void 
        {
            this.s = s;
        }
        
        public function setBricks():void 
        {
            for (var i:int = 0; i < bricks.length; i++ )
            {
                bricks[i] = new Brick_symb();
                bricks[i].x = (50 + bricks[i].width) * i;
                s.addChild(bricks[i]);
            }
            
        }
        
    }

}