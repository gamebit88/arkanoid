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
        private var ball_symb:Ball_symb;
        private static const BALL_WIDTH:Number = 20;
        private static const BALL_HEIGHT:Number = 20;
        private var BALL_SPEEDx:Number = 8;
        private var BALL_SPEEDy:Number = 8;
        private var ball_tempx:Number;
        private var ball_tempy:Number;
        private var grav:Number = 1;
        private var paddle:Paddle;
        private var bricksArr:Array = [];
        private var currentLevel:Levels;
        private var ballPosition:Number;
        private var hitPercent:Number;
        private var nextX:Number;
        private var nextY:Number;
        private var point:Point;
        private var score:TF;
        private const BONUS:int = 10;
        
        public function Ball(paddle:Paddle):void 
        {
            this.paddle = paddle;
            
            
            if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
            
        }
        
        
        private function init(e:Event = null):void 
        {
            //ball_symb.width = BALL_WIDTH;
            //ball_symb.height = BALL_HEIGHT;
            removeEventListener(Event.ADDED_TO_STAGE, init);
            ball_symb = new Ball_symb();
            setDefaultBallPosition();
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
            ball_symb.y = paddle.paddle_symb.y - ball_symb.height * 4;
            addChild(ball_symb);
        }
        
        public function setBricks(currentLevel:Levels, arr:Array, score:TF):void
        {
            this.score = score;
            this.currentLevel = currentLevel;
            bricksArr = arr;
        }
        
        public function moveBallListener(e:Event):void 
        {
            
            //ball_symb.x += BALL_SPEEDx;
            //ball_symb.y += BALL_SPEEDy;
            ball_symb.y += grav;
            ball_tempx = ball_symb.x + BALL_SPEEDx;
            ball_tempy = ball_symb.y + BALL_SPEEDy;
            ball_symb.x = ball_tempx;
            ball_symb.y = ball_tempy;
            //point.x += BALL_SPEEDx;
            //point.y += BALL_SPEEDy;
            
            if (ball_symb.x + ball_symb.width >= stage.stageWidth || ball_symb.x + ball_symb.width / 2 <= ball_symb.width / 2)
            {
                //nextX = ball_symb.x;
                //nextY = ball_symb.y;
                //var p:Point = new Point(nextX, nextY);
                grav = 1;
                var xs:Number = ball_symb.x - ball_symb.width / 2;
                var rel:Number = (ball_tempx - xs) / (ball_tempx - ball_symb.x);
                var ys:Number = ball_tempy - rel * (ball_tempy - ball_symb.y);
                ball_tempx = xs;
                ball_tempy = ys;
                
                BALL_SPEEDx = -1 * BALL_SPEEDx;
                
            }
            if (ball_symb.y >= stage.stageHeight - ball_symb.height/2 + 4 || ball_symb.y <= ball_symb.height/2)
            {
                BALL_SPEEDy = -1 * BALL_SPEEDy;
            }
            
            if (paddle.paddle_symb.hitTestObject(ball_symb))
            {
                ballPosition = ball_symb.x - paddle.paddle_symb.x;
                hitPercent = (ballPosition / (paddle.paddle_symb.width - ball_symb.width));
                ball_symb.y -= 4*grav;
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
                    grav = 1;    
                    BALL_SPEEDy *= -1; 
                    currentLevel.removeChild(bricksArr[i]); 
                    bricksArr.splice(i, 1);
                    score.val += BONUS;
                } 
            }
            
            if (bricksArr.length < 1)
            {
                dispatchEvent(new BallEvents(BallEvents.LEVEL_DONE));
            }
        }
    }

}