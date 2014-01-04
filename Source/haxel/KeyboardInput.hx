package haxel;

import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//
//                                                                          //
//   Because of the nature of this project, please PLEASE test any change   //
//   on HTML5, Flash, AND native. Any changes made for compatibility or     //
//   optimization ABSOLUTELY NEED to be fully documented: reasons, effects  //
//   and changes made. -Aaron                                               //
//                                                                          //
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//

class KeyboardInput 
{
    public static var keyString:String = "";
    public static var lastKey:Int;

    public static function check(input:Int):Bool
    {
        return input < 0 ? _keyNum > 0 : _key[input];
    }

    public static function pressed(input:Int):Bool
    {
        return (input < 0) ? _pressNum != 0 : indexOf(_press, input) >= 0;
    }

    public static function released(input:Int):Bool
    {
        return (input < 0) ? _releaseNum != 0 : indexOf(_release, input) >= 0;
    }
    
    public static function init()
    {
        if (!_initialized)
        {
            //may as well keep it at priority 2 for now
            //will fuck with it eventually
            Core.instance.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false,  2);
            Core.instance.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp, false,  2);
            Key.init();
            _initialized = true;
        }
    }

    public static function update()
    {
        while (_pressNum-- > -1) _press[_pressNum] = -1;
        _pressNum = 0;
        while (_releaseNum-- > -1) _release[_releaseNum] = -1;
        _releaseNum = 0;
    }
    
    private static function onKeyDown(e:KeyboardEvent = null)
    {
        var code:Int = Key.keyCode(e);
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
    }

    private static function onKeyUp(e:KeyboardEvent = null)
    {
        var code:Int = Key.keyCode(e);
        if (code == -1) // No key
            return;
        
        if (_key[code])
        {
            _key[code] = false;
            _keyNum--;
            _release[_releaseNum++] = code;
        }
    }

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

    private static var _initialized:Bool = false;
    // private static var _touchNum:Int = 0;
    private static var _key:Array<Bool> = new Array<Bool>();
    private static var _keyNum:Int = 0;
    private static var _press:Array<Int> = new Array<Int>();
    private static var _pressNum:Int = 0;
    private static var _release:Array<Int> = new Array<Int>();
    private static var _releaseNum:Int = 0;
}