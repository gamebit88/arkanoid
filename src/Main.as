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
        public var bricks:Bricks;
        private var menuScreen:MenuScreen;
        private var bg:Bg_screen;
        
        
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
            
            paddle = new Paddle();
            addChild(paddle);
            
            ball = new Ball(paddle);
            addChild(ball);
            
            bg.addEventListener(MouseEvent.MOUSE_UP, startGame);
            
        }
        
        private function startGame(e:MouseEvent):void 
        {
            Mouse.hide();
            bg.removeEventListener(MouseEvent.MOUSE_UP, startGame);
            ball.start();
            paddle.start();
            bg.addEventListener(MouseEvent.MOUSE_UP, pauseGame);
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