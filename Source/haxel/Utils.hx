
package haxel;

import flash.geom.Matrix;

class Utils
{
    private static var m = Math;

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
        var r:Float = Std.int(Std.int(intColor/256)/256)/255;
        var g:Float = Std.int(intColor/256)/255;
        var b:Float = intColor/255;
        return new ColorObject(r,g,b);
    }

    public static function blend(color1:ColorObject,color2:ColorObject,alpha:Float):ColorObject
    {
        var finalColor = new ColorObject(0,0,0);
        finalColor.r = color2.r + (color1.r - color2.r)*(1-alpha);
        finalColor.g = color2.g + (color1.g - color2.g)*(1-alpha);
        finalColor.b = color2.b + (color1.b - color2.b)*(1-alpha);
        return finalColor;
    }
}