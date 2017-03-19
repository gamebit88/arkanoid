package objects 
{
    import flash.display.Sprite;
    import flash.events.*;
    import flash.display.Stage;
    import flash.ui.Mouse;
	/**
     * ...
     * @author alexander
     */
    public class Paddle extends Sprite
    {
        public var paddle_symb:Paddle_symb;
        private var stage_width:Number;
        private var stage_height:Number;
        
        public function Paddle():void 
        {
            
            if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
            
        }
        
        private function init(e:Event = null):void 
        {
            removeEventListener(Event.ADDED_TO_STAGE, init);
            this.stage_width = stage.stageWidth;
            this.stage_height = stage.stageHeight;
            paddle_symb = new Paddle_symb();
            setDefaultPaddlePosition();
        }
        
        public function start():void
        {
            stage.addEventListener(MouseEvent.MOUSE_MOVE, movePaddleListener);
        }
        
        public function stop():void
        {
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, movePaddleListener);            
        }
        
        private function setDefaultPaddlePosition():void 
        {
            paddle_symb.x = stage_width / 2;
            paddle_symb.y = stage_height - paddle_symb.height * 2;
            addChild(paddle_symb);
        }
        
        public function movePaddleListener(e:MouseEvent):void 
        {
            //Mouse.hide();
            paddle_symb.x = mouseX;
            if (paddle_symb.x + paddle_symb.width / 2 >= stage_width)
            {
                paddle_symb.x = stage_width - paddle_symb.width / 2;
            } else if (paddle_symb.x - paddle_symb.width / 2 <= 0)
            {
                paddle_symb.x = 0 + paddle_symb.width / 2;
            }
        }
        
    }

}