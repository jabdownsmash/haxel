package haxel;

import flash.events.TouchEvent;
import flash.ui.Multitouch;
import flash.ui.MultitouchInputMode;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//
//                                                                          //
//   Because of the nature of this project, please PLEASE test any change   //
//   on HTML5, Flash, AND native. Any changes made for compatibility or     //
//   optimization ABSOLUTELY NEED to be fully documented: reasons, effects  //
//   and changes made. -Aaron                                               //
//                                                                          //
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//

class TouchInput 
{

    // DOES NOT WORK AT ALL YET
    // NOPENOPENOPENOPENOPENOPENOPENOPE
    // NOT WORKING LEL 

    public static var multiTouchSupported(default, null):Bool = false;


    public static function touchPoints(touchCallback:Touch->Void)
    {
        for (touch in _touches)
        {
            touchCallback(touch);
        }
    }

#if haxe3
    public static var touches(get_touches, never):Map<Int,Touch>;
    private static inline function get_touches():Map<Int,Touch> { return _touches; }
#else
    public static var touches(get_touches, never):IntHash<Touch>;
    private static inline function get_touches():IntHash<Touch> { return _touches; }
#end
    
    public static function init()
    {
        if (!_initialized)
        {
            
            multiTouchSupported = Multitouch.supportsTouchEvents;
            if (multiTouchSupported)
            {
                Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

                Core.instance.stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
                Core.instance.stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
                Core.instance.stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
            }

            _initialized = true;
        }
    }

    public static function update()
    {
        if (multiTouchSupported)
        {
            for (touch in _touches) touch.update();
        }
    }

    private static function onTouchBegin(e:TouchEvent)
    {
        // var touchPoint = new Touch(e.stageX / HXP.screen.fullScaleX, e.stageY / HXP.screen.fullScaleY, e.touchPointID);
        // _touches.set(e.touchPointID, touchPoint);
        _touchNum += 1;
    }

    private static function onTouchMove(e:TouchEvent)
    {
        var point = _touches.get(e.touchPointID);
        // point.x = e.stageX / HXP.screen.fullScaleX;
        // point.y = e.stageY / HXP.screen.fullScaleY;
    }

    private static function onTouchEnd(e:TouchEvent)
    {
        _touches.remove(e.touchPointID);
        _touchNum -= 1;
    }

    private static var _initialized:Bool = false;
    private static var _touchNum:Int = 0;
#if haxe3
    private static var _touches:Map<Int,Touch> = new Map<Int,Touch>();
#else
    private static var _touches:IntHash<Touch> = new IntHash<Touch>();
#end
}