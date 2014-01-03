package haxel;

// import flash.display.Stage;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;

class Input 
{
    public static var mouseX(get, null):Float;
    public static var mouseY(get, null):Float;
    
    private static var _mouseX:Float;
    private static var _mouseY:Float;
    
    private static var :Bool;
    // private static var _stage:Stage;
    
    private static var _currentKeyPressed:Int;
    private static var _currentKeyReleased:Int;
    private static var _lastKeyPressed:Int;
    private static var _keyCode:Int;
    
    private static var _keys:Array<Bool>;
    
    private static var _leftMouseDown:Bool;
    private static var _leftMousePressed:Bool;
    private static var _leftMouseReleased:Bool;
    private static var _rightMouseDown:Bool;
    private static var _rightMousePressed:Bool;
    private static var _rightMouseReleased:Bool;
    
    private static var _keyMap:Map < String, Array<Int> > ;
    
    public static function enable()
    {
        if (!_enabled && HXP.stage != null)
        {
            HXP.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false,  2);
            HXP.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp, false,  2);
            HXP.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false,  2);
            HXP.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false,  2);
            HXP.stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel, false,  2);
            
        #if !js
            HXP.stage.addEventListener(MouseEvent.MIDDLE_MOUSE_DOWN, onMiddleMouseDown, 2);
            HXP.stage.addEventListener(MouseEvent.MIDDLE_MOUSE_UP, onMiddleMouseUp, 2);
            HXP.stage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, onRightMouseDown, 2);
            HXP.stage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, onRightMouseUp, 2);
        #end
        
            multiTouchSupported = Multitouch.supportsTouchEvents;
            if (multiTouchSupported)
            {
                Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

                HXP.stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
                HXP.stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
                HXP.stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
            }

#if ((nme || openfl) && (cpp || neko))
            HXP.stage.addEventListener(JoystickEvent.AXIS_MOVE, onJoyAxisMove);
            HXP.stage.addEventListener(JoystickEvent.BALL_MOVE, onJoyBallMove);
            HXP.stage.addEventListener(JoystickEvent.BUTTON_DOWN, onJoyButtonDown);
            HXP.stage.addEventListener(JoystickEvent.BUTTON_UP, onJoyButtonUp);
            HXP.stage.addEventListener(JoystickEvent.HAT_MOVE, onJoyHatMove);
#end

        #if !(flash || js)
            _nativeCorrection.set("0_64", Key.INSERT);
            _nativeCorrection.set("0_65", Key.END);
            _nativeCorrection.set("0_66", Key.DOWN);    
            _nativeCorrection.set("0_67", Key.PAGE_DOWN);
            _nativeCorrection.set("0_68", Key.LEFT);    
            _nativeCorrection.set("0_69", -1);
            _nativeCorrection.set("0_70", Key.RIGHT);
            _nativeCorrection.set("0_71", Key.HOME);
            _nativeCorrection.set("0_72", Key.UP);
            _nativeCorrection.set("0_73", Key.PAGE_UP);
            _nativeCorrection.set("0_266", Key.DELETE);
            _nativeCorrection.set("123_222", Key.LEFT_SQUARE_BRACKET);
            _nativeCorrection.set("125_187", Key.RIGHT_SQUARE_BRACKET);
            _nativeCorrection.set("126_233", Key.TILDE);
        
            _nativeCorrection.set("0_80", Key.F1);
            _nativeCorrection.set("0_81", Key.F2);
            _nativeCorrection.set("0_82", Key.F3);
            _nativeCorrection.set("0_83", Key.F4);
            _nativeCorrection.set("0_84", Key.F5);
            _nativeCorrection.set("0_85", Key.F6);
            _nativeCorrection.set("0_86", Key.F7);
            _nativeCorrection.set("0_87", Key.F8);
            _nativeCorrection.set("0_88", Key.F9);
            _nativeCorrection.set("0_89", Key.F10);
            _nativeCorrection.set("0_90", Key.F11);
            
            _nativeCorrection.set("48_224", Key.DIGIT_0);
            _nativeCorrection.set("49_38", Key.DIGIT_1);
            _nativeCorrection.set("50_233", Key.DIGIT_2);
            _nativeCorrection.set("51_34", Key.DIGIT_3);
            _nativeCorrection.set("52_222", Key.DIGIT_4);
            _nativeCorrection.set("53_40", Key.DIGIT_5);
            _nativeCorrection.set("54_189", Key.DIGIT_6);
            _nativeCorrection.set("55_232", Key.DIGIT_7);
            _nativeCorrection.set("56_95", Key.DIGIT_8);
            _nativeCorrection.set("57_231", Key.DIGIT_9);
            
            _nativeCorrection.set("48_64", Key.NUMPAD_0);
            _nativeCorrection.set("49_65", Key.NUMPAD_1);
            _nativeCorrection.set("50_66", Key.NUMPAD_2);
            _nativeCorrection.set("51_67", Key.NUMPAD_3);
            _nativeCorrection.set("52_68", Key.NUMPAD_4);
            _nativeCorrection.set("53_69", Key.NUMPAD_5);
            _nativeCorrection.set("54_70", Key.NUMPAD_6);
            _nativeCorrection.set("55_71", Key.NUMPAD_7);
            _nativeCorrection.set("56_72", Key.NUMPAD_8);
            _nativeCorrection.set("57_73", Key.NUMPAD_9);
            _nativeCorrection.set("42_268", Key.NUMPAD_MULTIPLY);
            _nativeCorrection.set("43_270", Key.NUMPAD_ADD);
            //_nativeCorrection.set("", Key.NUMPAD_ENTER);
            _nativeCorrection.set("45_269", Key.NUMPAD_SUBTRACT);
            _nativeCorrection.set("46_266", Key.NUMPAD_DECIMAL); // point
            _nativeCorrection.set("44_266", Key.NUMPAD_DECIMAL); // comma
            _nativeCorrection.set("47_267", Key.NUMPAD_DIVIDE);
        #end
        }
    }
    
    public static function update():Void
    {
        if (_leftMousePressed)
        {
            _leftMousePressed = false;
        }
        
        if (_leftMouseReleased)
        {
            _leftMouseReleased = false;
        }
        
        //if (_rightMousePressed)
        //{
            //_rightMousePressed = false;
        //}
        //
        //if (_rightMouseReleased)
        //{
            //_rightMouseReleased = false;
        //}
        
        _mouseX = _stage.mouseX;
        _mouseY = _stage.mouseY;
        _lastKeyPressed = _currentKeyPressed;
    }
    
    public static function addKey(name:String, ?key:Int, ?keys:Array<Int>):Void
    {
        if (_keyMap.exists(name))
        {
            _keyMap.get(name).push(key);
        }
        else
        {
            if (key != null)
            {
                _keyMap.set(name, [key]);
            }
            else
            {
                _keyMap.set(name, keys);
            }
        }
    }
    
    private static function keyDownEvent(event:KeyboardEvent):Void
    {
        _currentKeyPressed = _keyCode = event.keyCode;
        _keys[event.keyCode] = true;
    }
    
    private static function keyUpEvent(event:KeyboardEvent):Void
    {
        _currentKeyPressed = -1;
        _lastKeyPressed = -1;
        
        _currentKeyReleased = event.keyCode;
        _keys[event.keyCode] = false;
    }
    
    public static function keyPressed(?keyInt:Int, ?keyString:String):Bool
    {
        if (keyInt != null)
        {
            return checkKeyPressed(keyInt);
        }
        else
        {
            var keys:Array<Int> = _keyMap.get(keyString);
            if (keys != null)
            {
                for (key in keys)
                {
                    if (checkKeyPressed(key))
                    {
                        return true;
                    }
                }
            }
        }
        
        return false;
    }
    
    public static function anyKeyPressed():Bool 
    {
        for (key in _keys)
        {
            if (key)
            {
                return key;
            }
        }
        return false;
    }
    
    public static function keyDown(?keyInt:Int, ?keyString:String):Bool
    {
        if (keyInt != null)
        {
            return _keys[keyInt];
        }
        else
        {
            var keys:Array<Int> = _keyMap.get(keyString);
            if (keys != null)
            {
                for (key in keys)
                {
                    if (_keys[key])
                    {
                        return true;
                    }
                }
            }
        }
        return false;
    }
    
    public static function keyUp(keyInt:Int):Bool
    {
        if (keyInt == _currentKeyReleased)
        {
            _currentKeyReleased = -1;
            return true;
        }
        else
        {
            return false;
        }
    }
    
    private static function mouseDownEvent(event:MouseEvent):Void
    {
        _leftMouseDown = true;
        _leftMousePressed = true;
        _leftMouseReleased = false;
    }
    
    private static function mouseUpEvent(event:MouseEvent):Void
    {
        _leftMouseDown = false;
        _leftMousePressed = false;
        _leftMouseReleased = true;
    }
    
    private static function rightMouseUpEvent(event:MouseEvent):Void 
    {
        _rightMouseDown = true;
        _rightMousePressed = true;
        _rightMouseReleased = false;
    }
    
    private static function rightMouseDownEvent(event:MouseEvent):Void 
    {
        _rightMouseDown = false;
        _rightMousePressed = false;
        _rightMouseReleased = true;
    }
    
    public static function leftMouseReleased():Bool
    {
        return _leftMouseReleased;
    }
    
    public static function leftMouseDown():Bool
    {
        return _leftMouseDown;
    }
    
    public static function leftMousePressed():Bool
    {
        return _leftMousePressed;
    }
    
    //public static function rightMouseReleased():Bool
    //{
        //return _rightMouseReleased;
    //}
    //
    //public static function rightMouseDown():Bool
    //{
        //return _rightMouseDown;
    //}
    //
    //public static function rightMousePressed():Bool
    //{
        //return _rightMousePressed;
    //}
    
    public static function mouseMoved():Bool
    {
        if (_mouseX != _stage.mouseX || _mouseY != _stage.mouseY)
        {
            _mouseX = _stage.mouseX;
            _mouseY = _stage.mouseY;
            return true;
        }
        else
        {
            return false;
        }
    }
    
    public static function keyCode():Int
    {
        return _keyCode;
    }
    
    private static function get_mouseX():Float
    {
        return _stage.mouseX;
    }
    
    private static function get_mouseY():Float
    {
        return _stage.mouseY;
    }
}