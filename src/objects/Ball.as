package objects 
{
    import flash.display.*;
    import flash.events.*;
    import objects.*;
    import flash.geom.*;
	/**
     * ...
     * @author alexander
     */
    public class Ball extends Sprite
    {
        public var ball_symb:Ball_symb;
        private static const BALL_WIDTH:Number = 20;
        private static const BALL_HEIGHT:Number = 20;
        private var BALL_SPEEDx:Number = 2;
        private var BALL_SPEEDy:Number = 2;
        private var stage_width:Number;
        private var stage_height:Number;
        public var paddle:Paddle;
        private var ballPosition:Number;
        private var hitPercent:Number;
        private var nextX:Number;
        private var nextY:Number;
        private var point:Point;

        
        public function Ball(paddle:Paddle):void 
        {
            this.paddle = paddle;
            
            if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
            
        }
        
        private function init(e:Event = null):void 
        {
            this.stage_width = stage.stageWidth;
            this.stage_height = stage.stageHeight;
            ball_symb = new Ball_symb();
            setDefaultBallPosition();
            ball_symb.width = BALL_WIDTH;
            ball_symb.height = BALL_HEIGHT;
            
            point = new Point(ball_symb.x, ball_symb.y);
        }
        
        public function start():void
        {
            addEventListener(Event.ENTER_FRAME, moveBallListener);
        }
        
        public function stop():void
        {
            removeEventListener(Event.ENTER_FRAME, moveBallListener);
        }
        
        private function setDefaultBallPosition():void
        {
            ball_symb.x = stage_width / 2 - ball_symb.width / 2;
            ball_symb.y = stage_height / 1.2;
            addChild(ball_symb);
        }
        
        public function moveBallListener(e:Event):void 
        {
            
            ball_symb.x += BALL_SPEEDx;
            ball_symb.y += BALL_SPEEDy;
            point.x += BALL_SPEEDx;
            point.y += BALL_SPEEDy;
            
            if (ball_symb.x > stage_width - ball_symb.width/2 + 4 || ball_symb.x <= -3 + ball_symb.width / 2)
            {
                nextX = ball_symb.x;
                nextY = ball_symb.y;
                var p:Point = new Point(nextX, nextY);
                BALL_SPEEDx = -1 * BALL_SPEEDx;
                
            }
            if (ball_symb.y >= stage_height - ball_symb.height/2 + 4 || ball_symb.y <= -3 + ball_symb.height/2)
            {
                BALL_SPEEDy = -1 * BALL_SPEEDy;
            }
            
            if (paddle.paddle_symb.hitTestObject(ball_symb))
            {
                ballPosition = ball_symb.x - paddle.paddle_symb.x;
                hitPercent = (ballPosition / (paddle.paddle_symb.width - ball_symb.width)) - .5;
                BALL_SPEEDx = hitPercent * 10;
                BALL_SPEEDy *= -1; 
                
            }
        }
        
    }

}