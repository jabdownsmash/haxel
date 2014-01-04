
package haxel;

import flash.display.Bitmap;
import flash.display.BitmapData;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//
//                                                                          //
//   Because of the nature of this project, please PLEASE test any change   //
//   on HTML5, Flash, AND native. Any changes made for compatibility or     //
//   optimization ABSOLUTELY NEED to be fully documented: reasons, effects  //
//   and changes made. -Aaron                                               //
//                                                                          //
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//

class Primitives
{
    private static var m = Math;
    public static function drawLine(startX:Float, startY:Float, endX:Float, endY:Float, color:UInt, ?drawTarget:BitmapData)
    {
        if(drawTarget == null)
        {
            drawTarget = Screen.getDrawTarget();
        }
        //prevents things from trying to update the drawTarget
        //in between setpixels
        drawTarget.lock();
        
        var dx:Float = endX - startX;
        var dy:Float = endY - startY;
        
        var slope:Float = dy/dx;
        
        if(dx >= dy)
        {
            if(startX > endX)
            {
                var t = startX;
                startX = endX;
                endX = t;
            }
            for(x in Std.int(startX)...Std.int(endX))
            {
                var y:Int = Std.int(slope*x+startY);
                drawTarget.setPixel(x, y, color);
            }
        }
        else
        {
            if(startY > endY)
            {
                var t = startY;
                startY = endY;
                endY = t;
            }
            for(y in Std.int(startY)...Std.int(endY))
            {
                var x:Int = Std.int(y/slope+startX);
                drawTarget.setPixel(x, y, color);
            }
        }
        //releases control of drawTarget
        //should optimize this with a rectangle that encapsulates 
        //the changes
        drawTarget.unlock();
    }
    
    public static function drawCircle(centerX:Float, centerY:Float, radius:Float, color:UInt, ?drawTarget:BitmapData)
    {
        if(drawTarget == null)
        {
            drawTarget = Screen.getDrawTarget();
        }
        drawTarget.lock();
        
        for(x in -Std.int(radius)...Std.int(radius))
        {
            var y:Float = m.sqrt(radius*radius - x*x);
            drawTarget.setPixel(Std.int(centerX + x), Std.int(centerY+y), color);
            drawTarget.setPixel(Std.int(centerX + x), Std.int(centerY-y), color);
        }
        drawTarget.unlock();
    }
}