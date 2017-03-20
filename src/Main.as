package  
{
    import flash.ui.Mouse;
	import flash.display.*;
	import flash.events.*;
    import flash.text.*;
    import objects.*;

	/**
	 * ...
	 * @author alexander
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{
        public var paddle:Paddle;
        public var ball:Ball;
        public var bricksArr:Array = [];
        private var menuScreen:MenuScreen;
        private var bg:Bg_screen;
        private var scoreTF:TF = new TF("Score: ", 0, "left");
        private var livesTF:TF = new TF("Lives: ", 3, "center");
        private var levelTF:TF = new TF("Level: ", 1, "right");
        public var Leveles:Levels;
        
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
        
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
            
			// entry point
            
            menuScreen = new MenuScreen();
            addChild(menuScreen);
            menuScreen.startB.addEventListener(MouseEvent.MOUSE_UP, initGame);
		}
        
        private function initGame(e:MouseEvent):void 
        {
            menuScreen.startB.removeEventListener(MouseEvent.MOUSE_UP, initGame);
            removeChild(menuScreen);
            menuScreen = null;
            
            bg = new Bg_screen();
            addChild(bg);
            
            addChild(scoreTF);
            addChild(livesTF);
            addChild(levelTF);
            
            Leveles = new Levels();
            addChild(Leveles);
            
            paddle = new Paddle();
            addChild(paddle);
            
            ball = new Ball(paddle);
            ball.setBricks(Leveles, Leveles.bricksArr);
            addChild(ball);
            
            bg.addEventListener(MouseEvent.MOUSE_UP, startGame);
            
        }
        
        private function startGame(e:MouseEvent):void 
        {
            Mouse.hide();
            bg.removeEventListener(MouseEvent.MOUSE_UP, startGame);
            ball.setDefaultBallPosition();
            paddle.setDefaultPaddlePosition();
            ball.start();
            paddle.start();
            ball.addEventListener(BallEvents.BALL_LOSE, ballLoseListener);
            ball.addEventListener(BallEvents.LEVEL_DONE, levelDoneListener);
            bg.addEventListener(MouseEvent.MOUSE_UP, pauseGame);
        }
        
        private function levelDoneListener(e:BallEvents):void 
        {
            trace("level_done");
            ball.removeEventListener(BallEvents.LEVEL_DONE, levelDoneListener);
        }
        
        private function ballLoseListener(e:Event):void 
        {
            trace("lose");
            ball.removeEventListener(BallEvents.BALL_LOSE, ballLoseListener);
        }
        
        private function pauseGame(e:MouseEvent):void 
        {
            Mouse.show();
            bg.removeEventListener(MouseEvent.MOUSE_UP, pauseGame);
            ball.stop();
            paddle.stop();
            bg.addEventListener(MouseEvent.MOUSE_UP, startGame);
        }
	}

}