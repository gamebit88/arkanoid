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
        private var BALL_SPEEDx:Number = 8;
        private var BALL_SPEEDy:Number = 8;
        public var paddle:Paddle;
        public var bricksArr:Array = [];
        public var currentLevel:Levels;
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
            removeEventListener(Event.ADDED_TO_STAGE, init);
            ball_symb = new Ball_symb();
            setDefaultBallPosition();
            //ball_symb.width = BALL_WIDTH;
            //ball_symb.height = BALL_HEIGHT;
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
        
        public function setDefaultBallPosition():void
        {
            ball_symb.x = stage.stageWidth / 2 - ball_symb.width / 2;
            ball_symb.y = stage.stageHeight / 1.2;
            addChild(ball_symb);
        }
        
        public function setBricks(currentLevel:Levels, arr:Array):void
        {
            this.currentLevel = currentLevel;
            bricksArr = arr;
        }
        
        public function moveBallListener(e:Event):void 
        {
            
            ball_symb.x += BALL_SPEEDx;
            ball_symb.y -= BALL_SPEEDy;
            point.x += BALL_SPEEDx;
            point.y += BALL_SPEEDy;
            
            if (ball_symb.x > stage.stageWidth - ball_symb.width/2 + 4 || ball_symb.x <= -3 + ball_symb.width / 2)
            {
                nextX = ball_symb.x;
                nextY = ball_symb.y;
                var p:Point = new Point(nextX, nextY);
                BALL_SPEEDx = -1 * BALL_SPEEDx;
                
            }
            if (ball_symb.y >= stage.stageHeight - ball_symb.height/2 + 4 || ball_symb.y <= -3 + ball_symb.height/2)
            {
                BALL_SPEEDy = -1 * BALL_SPEEDy;
            }
            
            if (paddle.paddle_symb.hitTestObject(ball_symb))
            {
                ballPosition = ball_symb.x - paddle.paddle_symb.x;
                hitPercent = (ballPosition / (paddle.paddle_symb.width - ball_symb.width));
                BALL_SPEEDx = hitPercent * 5;
                BALL_SPEEDy *= -1; 
                
            }
            
            if (ball_symb.y > paddle.paddle_symb.y + paddle.paddle_symb.height)
            {
                dispatchEvent(new BallEvents(BallEvents.BALL_LOSE));
            }
            
            for(var i:int = 0; i < bricksArr.length; i++) 
            { 
                if(ball_symb.hitTestObject(bricksArr[i])) 
                { 
                    //BALL_SPEEDx *= -1;
                        
                    BALL_SPEEDy *= -1; 
                    currentLevel.removeChild(bricksArr[i]); 
                    bricksArr.splice(i, 1);
                } 
            }
            
            if (bricksArr.length < 1)
            {
                //trace("win");
                dispatchEvent(new BallEvents(BallEvents.LEVEL_DONE));
            }
            
        }
            
        
        
        
    }

}