
package haxel;

import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Matrix;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//
//                                                                          //
//   Because of the nature of this project, please PLEASE test any change   //
//   on HTML5, Flash, AND native. Any changes made for compatibility or     //
//   optimization ABSOLUTELY NEED to be fully documented: reasons, effects  //
//   and changes made. -Aaron                                               //
//                                                                          //
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//

class GraphicObject
{

    public var bitmapData:BitmapData;

    private var hasAlpha:Bool;

    public var width(get,never):Int;
    public function get_width():Int
    {
        return Std.int(bitmapData.rect.width);
    }
    public var height(get,never):Int;
    public function get_height():Int
    {
        return Std.int(bitmapData.rect.height);
    }

    public function new(width:Int = 1,height:Int = 1,alpha:Bool= true,?fillColor:ColorObject)
    {
        if(fillColor == null)
        {
            bitmapData = new BitmapData(width,height,alpha);
            return;
        }
        bitmapData = new BitmapData(width,height,alpha,fillColor.getUInt());
        hasAlpha = alpha;
    }

    public function draw(image:Dynamic,?transformMatrix:Matrix,x:Float = 0,y:Float = 0, centerX:Float = 0, centerY:Float = 0, xScale:Float = 1, yScale:Float = 1, rotation:Float = 0)
    {
        if(transformMatrix != null)
        {
            if(Std.is(image, GraphicObject))
            {
                bitmapData.draw(image.bitmapData,transformMatrix);
            }
            else
            {
                bitmapData.draw(image,transformMatrix);
            }
        }
        else
        {
            var transformMatrix = Utils.generateTransformMatrix(x,y,centerX,centerY,xScale,yScale,rotation);
            draw(image,transformMatrix);
        }
    }

    public function clear(color:ColorObject)
    {
        bitmapData.fillRect(bitmapData.rect,color.getUInt());
    }

    public function getBitmap()
    {
        return new Bitmap(bitmapData);
    }

    public function getBitmapData()
    {
        return bitmapData;
    }

    public function lock()
    {
        bitmapData.lock();
    }

    public function unlock()
    {
        bitmapData.unlock();
    }

    public function setPixel(x:Int,y:Int,color:ColorObject)
    {
        if(hasAlpha)
        {    
            bitmapData.setPixel32(x,y,color.getAlphaUInt());
        }
        else
        {
            bitmapData.setPixel(x,y,color.getUInt());
        }
    }
    
    public function getPixel(x:Int,y:Int):ColorObject
    {
        if(hasAlpha)
        {
            var colorInt = bitmapData.getPixel32(x,y);
            return Utils.getColorFromInt(colorInt);
        }
        else
        {
            var colorInt = bitmapData.getPixel(x,y);
            return Utils.getAlphaColorFromInt(colorInt);
        }
    }

    public function drawPixel(x:Int,y:Int,color:ColorObject)
    {
        setPixel(x, y, Utils.blend(getPixel(x,y),color));
    }
}
