
package haxel;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import haxel.Core;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//
//                                                                          //
//   Because of the nature of this project, please PLEASE test any change   //
//   on HTML5, Flash, AND native. Any changes made for compatibility or     //
//   optimization ABSOLUTELY NEED to be fully documented: reasons, effects  //
//   and changes made. -Aaron                                               //
//                                                                          //
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//

class PrimitiveUtils
{
    public static function drawLine(startX:Float, startY:Float, endX:Float, endY:Float, ?drawTarget:BitmapData, ?opt2:Float)
    {
        if(opt2 != null)
        {
            trace('yeeeeps\n');
        }
        // if(drawTarget == null)
        // {
        //     drawTarget = Core.getDrawTarget();
        // }
    }
}