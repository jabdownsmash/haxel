package haxel;

// import flash.display.Stage;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.events.TouchEvent;
import flash.ui.Keyboard;
// import flash.ui.Multitouch;
// import flash.ui.MultitouchInputMode;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//
//                                                                          //
//   Because of the nature of this project, please PLEASE test any change   //
//   on HTML5, Flash, AND native. Any changes made for compatibility or     //
//   optimization ABSOLUTELY NEED to be fully documented: reasons, effects  //
//   and changes made. -Aaron                                               //
//                                                                          //
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//

class Input 
{
    public static var keyString:String = "";
    public static var lastKey:Int;
    public static var mouseDown:Bool;
    public static var mouseUp:Bool;
    public static var mousePressed:Bool;
    public static var mouseReleased:Bool;

#if !js 
    public static var rightMouseDown:Bool;
    public static var rightMouseUp:Bool;
    public static var rightMousePressed:Bool;
    public static var rightMouseReleased:Bool;
    public static var middleMouseDown:Bool;
    public static var middleMouseUp:Bool;
    public static var middleMousePressed:Bool;
    public static var middleMouseReleased:Bool;
#end
    
    /**
     * If the mouse wheel has moved
     */
    public static var mouseWheel:Bool;

    /**
     * Returns true if the device supports multi touch
     */
    // public static var multiTouchSupported(default, null):Bool = false;

    /**
     * If the mouse wheel was moved this frame, this was the delta.
     */
    public static var mouseWheelDelta(get_mouseWheelDelta, never):Int;
    public static function get_mouseWheelDelta():Int
    {
        if (mouseWheel)
        {
            mouseWheel = false;
            return _mouseWheelDelta;
        }
        return 0;
    }

    public static var mouseX(get_mouseX, never):Float;
    private static function get_mouseX():Float
    {
        return Core.instance.mouseX;
    }

    public static var mouseY(get_mouseY, never):Float;
    private static function get_mouseY():Float
    {
        return Core.instance.mouseY;
    }

    public static function check(input:Dynamic):Bool
    {
        return input < 0 ? _keyNum > 0 : _key[input];
    }

    public static function pressed(input:Dynamic):Bool
    {
        return (input < 0) ? _pressNum != 0 : indexOf(_press, input) >= 0;
    }

    public static function released(input:Dynamic):Bool
    {
        return (input < 0) ? _releaseNum != 0 : indexOf(_release, input) >= 0;
    }
    
    public static function enable()
    {
        if (!_enabled)
        {
            //may as well keep it at priority 2 for now
            //will fuck with it eventually
            Core.instance.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false,  2);
            Core.instance.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp, false,  2);
            Core.instance.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false,  2);
            Core.instance.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false,  2);
            Core.instance.stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel, false,  2);
            
        #if !js
            Core.instance.stage.addEventListener(MouseEvent.MIDDLE_MOUSE_DOWN, onMiddleMouseDown, 2);
            Core.instance.stage.addEventListener(MouseEvent.MIDDLE_MOUSE_UP, onMiddleMouseUp, 2);
            Core.instance.stage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, onRightMouseDown, 2);
            Core.instance.stage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, onRightMouseUp, 2);
        #end
        
            // multiTouchSupported = Multitouch.supportsTouchEvents;
            // if (multiTouchSupported)
            // {
            //     Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

            //     Core.stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
            //     Core.stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
            //     Core.stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
            // }

// #if ((nme || openfl) && (cpp || neko))
//             HXP.stage.addEventListener(JoystickEvent.AXIS_MOVE, onJoyAxisMove);
//             HXP.stage.addEventListener(JoystickEvent.BALL_MOVE, onJoyBallMove);
//             HXP.stage.addEventListener(JoystickEvent.BUTTON_DOWN, onJoyButtonDown);
//             HXP.stage.addEventListener(JoystickEvent.BUTTON_UP, onJoyButtonUp);
//             HXP.stage.addEventListener(JoystickEvent.HAT_MOVE, onJoyHatMove);
// #end

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

            _enabled = true;
        }
    }
    
    private static function onKeyDown(e:KeyboardEvent = null)
    {
        var code:Int = keyCode(e);
        if (code == -1) // No key
            return;
            
        lastKey = code;

        if (code == Key.BACKSPACE) keyString = keyString.substr(0, keyString.length - 1);
        else if ((code > 47 && code < 58) || (code > 64 && code < 91) || code == 32)
        {
            if (keyString.length > kKeyStringMax) keyString = keyString.substr(1);
            var char:String = String.fromCharCode(code);

            if (e.shiftKey != #if flash Keyboard.capsLock #else check(Key.CAPS_LOCK) #end)
                char = char.toUpperCase();
            else char = char.toLowerCase();

            keyString += char;
        }

        if (!_key[code])
        {
            _key[code] = true;
            _keyNum++;
            _press[_pressNum++] = code;
        }
        trace(code);
    }

    private static function onKeyUp(e:KeyboardEvent = null)
    {
        var code:Int = keyCode(e);
        if (code == -1) // No key
            return;
        
        if (_key[code])
        {
            _key[code] = false;
            _keyNum--;
            _release[_releaseNum++] = code;
        }
    }
    
    public static function keyCode(e:KeyboardEvent) : Int
    {
    #if (flash || js)
        return e.keyCode;
    #else       
        var code = _nativeCorrection.get(e.charCode + "_" + e.keyCode);
        
        if (code == null)
            return e.keyCode;
        else
            return code;
    #end
    }

    private static function onMouseDown(e:MouseEvent)
    {
        if (!mouseDown)
        {
            mouseDown = true;
            mouseUp = false;
            mousePressed = true;
        }
    }

    private static function onMouseUp(e:MouseEvent)
    {
        mouseDown = false;
        mouseUp = true;
        mouseReleased = true;
    }

    private static function onMouseWheel(e:MouseEvent)
    {
        mouseWheel = true;
        _mouseWheelDelta = e.delta;
    }

#if !js
    private static function onMiddleMouseDown(e:MouseEvent)
    {
        if (!middleMouseDown)
        {
            middleMouseDown = true;
            middleMouseUp = false;
            middleMousePressed = true;
        }
    }
    
    private static function onMiddleMouseUp(e:MouseEvent)
    {
        middleMouseDown = false;
        middleMouseUp = true;
        middleMouseReleased = true;
    }
    
    private static function onRightMouseDown(e:MouseEvent)
    {
        if (!rightMouseDown)
        {
            rightMouseDown = true;
            rightMouseUp = false;
            rightMousePressed = true;
        }
    }
    
    private static function onRightMouseUp(e:MouseEvent)
    {
        rightMouseDown = false;
        rightMouseUp = true;
        rightMouseReleased = true;
    }
#end

    private static function indexOf(a:Array<Int>, v:Int):Int
    {
        var i = 0;
        for( v2 in a ) {
            if( v == v2 )
                return i;
            i++;
        }
        return -1;
    }

    private static inline var kKeyStringMax = 100;

    private static var _enabled:Bool = false;
    // private static var _touchNum:Int = 0;
    private static var _key:Array<Bool> = new Array<Bool>();
    private static var _keyNum:Int = 0;
    private static var _press:Array<Int> = new Array<Int>();
    private static var _pressNum:Int = 0;
    private static var _release:Array<Int> = new Array<Int>();
    private static var _releaseNum:Int = 0;
    private static var _mouseWheelDelta:Int = 0;
#if haxe3
    // private static var _touches:Map<Int,Touch> = new Map<Int,Touch>();
    // private static var _joysticks:Map<Int,Joystick> = new Map<Int,Joystick>();
    private static var _control:Map<String,Array<Int>> = new Map<String,Array<Int>>();
    private static var _nativeCorrection:Map<String, Int> = new Map<String, Int>();
#else
    // private static var _touches:IntHash<Touch> = new IntHash<Touch>();
    // private static var _joysticks:IntHash<Joystick> = new IntHash<Joystick>();
    private static var _control:Hash<Array<Int>> = new Hash<Array<Int>>();
    private static var _nativeCorrection:Hash<Int> = new Hash<Int>();
#end
}