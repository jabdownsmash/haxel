
package haxel;

import flash.geom.Matrix;
import openfl.Assets;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//
//                                                                          //
//   Because of the nature of this project, please PLEASE test any change   //
//   on HTML5, Flash, AND native. Any changes made for compatibility or     //
//   optimization ABSOLUTELY NEED to be fully documented: reasons, effects  //
//   and changes made. -Aaron                                               //
//                                                                          //
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//

class Utils
{
    private static var m = Math;

    public static function loadImage(path:String):GraphicObject
    {
        var image = new GraphicObject();
        image.bitmapData = Assets.getBitmapData(path);
        return image;
    }

    public static function generateTransformMatrix(translateX:Float,translateY:Float, centerX:Float = 0, centerY:Float = 0, xScale:Float = 1, yScale:Float = 1, rotation:Float = 0):Matrix
    {
        //there is a function createBox() that is rotate,scale, and translate in one
        //but for some reason the html5 target doesn't have it
        //also I'm a dumbass for not realizing but order is important here, lol
        //the scale and rotate transform around centerX and centerY, and the translation centers around it too
        var transformMatrix = new Matrix();

        transformMatrix.translate(-centerX,-centerY);
        transformMatrix.rotate(rotation);
        transformMatrix.scale(xScale, yScale);
        transformMatrix.translate(translateX,translateY);

        return transformMatrix;
    }

    public static function getColorFromInt(intColor:UInt):ColorObject
    {
        var r:Float = (Std.int(Std.int(intColor/256)/256)%256)/255;
        var g:Float = (Std.int(intColor/256)%256)/255;
        var b:Float = (intColor%256)/255;
        return new ColorObject(r,g,b);
    }

    public static function getAlphaColorFromInt(intColor:UInt):ColorObject
    {
        var color = getColorFromInt(intColor);
        color.a = (Std.int(Std.int(Std.int(intColor/256)/256)/256)%256)/255;
        return color;
    }

    public static function blend(targetColor:ColorObject,newColor:ColorObject):ColorObject
    {
        var finalColor = new ColorObject(0,0,0);
        finalColor.r = newColor.r + (targetColor.r - newColor.r)*(1-newColor.a);
        finalColor.g = newColor.g + (targetColor.g - newColor.g)*(1-newColor.a);
        finalColor.b = newColor.b + (targetColor.b - newColor.b)*(1-newColor.a);
        finalColor.a = newColor.a + (1 - newColor.a)*targetColor.a;
        return finalColor;
    }
}