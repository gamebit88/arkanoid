package objects 
{
    import flash.events.*;
	/**
     * ...
     * @author alexander
     */
    public class BallEvents extends Event
    {
        public static const BALL_LOSE:String = "lose";
        public static const LEVEL_DONE:String = "level_done";
        
        public function BallEvents(type:String, bubbles:Boolean = false, cancelable:Boolean = false) 
        {
            super(type, bubbles, cancelable);
        }
        
    }

}