package objects 
{
    import flash.display.Sprite;
    import flash.text.*;
    import flash.events.*;
	/**
     * ...
     * @author alexander
     */
    public class TF extends Sprite
    {
        public var nameTF:String;
        public var tf:TextField;
        public var _val:Number;
        public var position:String;
        
        public function TF(name:String, valDefault:Number, position:String):void 
        {
            nameTF = name;
            this._val = valDefault;
            this.position = position;
            if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
        }
        
        private function init(e:Event = null):void 
        {
            tf = new TextField();
            tf.text = nameTF + _val.toString();
            tf.textColor = 0xf0f0f0;
            
            switch (position) 
            {
                case "left":
                    tf.autoSize = TextFieldAutoSize.LEFT;
                    tf.x = 0;
                break;
                
            case "center":
                    tf.autoSize = TextFieldAutoSize.CENTER;
                    tf.x = stage.stageWidth / 2 - tf.width / 2;
                break;
                
                case "right":
                    tf.x = stage.stageWidth - tf.width;
                    tf.autoSize = TextFieldAutoSize.RIGHT;
                break;    
                default:
            }
            addChild(tf);
        }
        
        public function get val():Number
        {
            return _val;
        }
        
        public function set val(val:Number):void
        {
            _val = val;
            tf.text = nameTF + _val.toString();
        }
        
    }

}