package haxel;

import flash.events.MouseEvent;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//
//                                                                          //
//   Because of the nature of this project, please PLEASE test any change   //
//   on HTML5, Flash, AND native. Any changes made for compatibility or     //
//   optimization ABSOLUTELY NEED to be fully documented: reasons, effects  //
//   and changes made. -Aaron                                               //
//                                                                          //
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//

class MouseInput 
{
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
    
    public static function init()
    {
        if (!_initialized)
        {
            //may as well keep it at priority 2 for now
            //will fuck with it eventually
            Core.instance.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false,  2);
            Core.instance.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false,  2);
            Core.instance.stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel, false,  2);
            
        // #if !js
        //     Core.instance.stage.addEventListener(MouseEvent.MIDDLE_MOUSE_DOWN, onMiddleMouseDown, 2);
        //     Core.instance.stage.addEventListener(MouseEvent.MIDDLE_MOUSE_UP, onMiddleMouseUp, 2);
        //     Core.instance.stage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, onRightMouseDown, 2);
        //     Core.instance.stage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, onRightMouseUp, 2);
        // #end

            _initialized = true;
        }
    }

    public static function update()
    {
        if (mousePressed) mousePressed = false;
        if (mouseReleased) mouseReleased = false;
        
    #if !js
        if (middleMousePressed) middleMousePressed = false;
        if (middleMouseReleased) middleMouseReleased = false;
        if (rightMousePressed) rightMousePressed = false;
        if (rightMouseReleased) rightMouseReleased = false;
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

    private static var _initialized:Bool = false;
    private static var _mouseWheelDelta:Int = 0;
}