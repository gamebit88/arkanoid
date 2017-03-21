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
        private var paddle:Paddle;
        private var ball:Ball;
        private var bricksArr:Array = [];
        private var menuScreen:MenuScreen;
        private var bg:Bg_screen;
        private var scoreTF:TF;
        private var livesTF:TF;
        private var levelTF:TF;
        private var Leveles:Levels;
        private var gameEvent:String;
        
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
            
            Leveles = new Levels(); addChild(Leveles);
            
            scoreTF = new TF("Score: ", 0, "left"); addChild(scoreTF);
            livesTF = new TF("Lives: ", 3, "center"); addChild(livesTF);
            levelTF = new TF("Level: ", 1, "right"); addChild(levelTF);
            
            paddle = new Paddle(); addChild(paddle);
            
            ball = new Ball(paddle);
            ball.setBricks(Leveles, Leveles.bricksArr, scoreTF);
            addChild(ball);
            bg.addEventListener(MouseEvent.MOUSE_UP, startGame);
        }
        
        private function startGame(e:MouseEvent):void 
        {
            Mouse.hide();
            switch (gameEvent) 
            {
                case "lose":
                case "level_done":
                    Mouse.show();
                    ball.stop(); paddle.stop();
                    ball.setDefaultBallPosition();
                    paddle.setDefaultPaddlePosition();
                    bg.addEventListener(MouseEvent.MOUSE_UP, inGame);
                        
                break;
                    
                default:
                    bg.removeEventListener(MouseEvent.MOUSE_UP, startGame);
                    ball.start(); paddle.start();
                    ball.addEventListener(BallEvents.BALL_LOSE, ballLoseListener);
                    ball.addEventListener(BallEvents.LEVEL_DONE, levelDoneListener);
                    bg.addEventListener(MouseEvent.MOUSE_UP, pauseGame);
            }
        }
        
        private function ballLoseListener(e:Event):void 
        {
            ball.removeEventListener(BallEvents.BALL_LOSE, ballLoseListener);
            livesTF.val -= 1;
            if (livesTF.val > 0) 
            {
                gameEvent = e.type;  startGame(null);
                ball.addEventListener(BallEvents.BALL_LOSE, ballLoseListener);
            }
            else
            {
                gameEvent = null;
                endGame();
            }
        }
        
        private function levelDoneListener(e:BallEvents):void 
        {
            ball.removeEventListener(BallEvents.LEVEL_DONE, levelDoneListener);
            Leveles.currentLevel += 1;
            levelTF.val = Leveles.currentLevel + 1;
            if (Leveles.currentLevel <= Leveles.levels.length - 1)
            {
                gameEvent = e.type;
                Leveles.buildLevel(Leveles.levels[Leveles.currentLevel]);
                ball.addEventListener(BallEvents.LEVEL_DONE, levelDoneListener);
                startGame(null);
            }
            else
            {
                gameEvent = null; endGame();
            }
        }
        
        private function endGame():void 
        {
            paddle.stop();
            ball.stop();
            ball.removeEventListener(BallEvents.BALL_LOSE, ballLoseListener);
            ball.removeEventListener(BallEvents.LEVEL_DONE, levelDoneListener);
            removeChild(bg); bg = null;
            removeChild(scoreTF); scoreTF = null;
            removeChild(livesTF); livesTF = null;
            removeChild(levelTF); levelTF = null;
            removeChild(Leveles); Leveles = null;
            removeChild(paddle); paddle = null;
            removeChild(ball); ball = null;
            
            menuScreen = new MenuScreen();
            addChild(menuScreen);
            Mouse.show();
            menuScreen.startB.addEventListener(MouseEvent.MOUSE_UP, initGame);
            
        }
        
        private function pauseGame(e:MouseEvent):void 
        {
            Mouse.show();
            bg.removeEventListener(MouseEvent.MOUSE_UP, pauseGame);
            ball.stop();
            paddle.stop();
            bg.addEventListener(MouseEvent.MOUSE_UP, inGame);
        }
        
        private function inGame(e:MouseEvent):void 
        {
            Mouse.hide();
            bg.removeEventListener(MouseEvent.MOUSE_UP, inGame);
            ball.start();
            paddle.start();
            bg.addEventListener(MouseEvent.MOUSE_UP, pauseGame);
        }
	}
}