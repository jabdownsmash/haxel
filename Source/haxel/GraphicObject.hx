
package haxel;

import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Matrix;

class GraphicObject
{

    private var bitmapData:BitmapData;

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

    public function new(?width:Int,?height:Int,?alpha:Bool,?fillColor:ColorObject)
    {
        bitmapData = new BitmapData(width,height,alpha,fillColor.getUInt());
    }

    public function draw(image:GraphicObject,?transformMatrix:Matrix,x:Float = 0,y:Float = 0, centerX:Float = 0, centerY:Float = 0, xScale:Float = 1, yScale:Float = 1, rotation:Float = 0)
    {
        if(transformMatrix != null)
        {
            bitmapData.draw(image.bitmapData,transformMatrix);
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
        bitmapData.setPixel(x,y,color.getUInt());
    }
    
    public function getPixel(x:Int,y:Int):ColorObject
    {
        var colorInt = bitmapData.getPixel(x,y);
        return Utils.getColorFromInt(colorInt);
    }

    public function drawPixel(x:Int,y:Int,color:ColorObject,alpha:Float)
    {
        setPixel(x, y, Utils.blend(getPixel(x,y),color,alpha));
    }
}
