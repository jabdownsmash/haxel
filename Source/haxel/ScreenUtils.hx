
package haxel;

import haxel.Core;
import flash.geom.Matrix;
import flash.display.BitmapData;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//
//                                                                          //
//   Because of the nature of this project, please PLEASE test any change   //
//   on HTML5, Flash, AND native. Any changes made for compatibility or     //
//   optimization ABSOLUTELY NEED to be fully documented: reasons, effects  //
//   and changes made. -Aaron                                               //
//                                                                          //
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//

class ScreenUtils
{
    public static var screenTransformMatrix:Matrix;
    public static var virtualScreenStartX:Float;
    public static var virtualScreenStartY:Float;
    public static var virtualScreenWidth:Float;
    public static var virtualScreenHeight:Float;

    public static function init()
    {
    }

    public static function resizeVirtualScreen(width:Float, height:Float, x:Float, y:Float)
    {
        if(Core.renderMode == BUFFERED_RENDER)
        {
            var xDifference = virtualScreenStartX - x;
            var yDifference = virtualScreenStartY - y;
            virtualScreenWidth = width;
            virtualScreenHeight = height;
            virtualScreenStartX = x;
            virtualScreenStartY = y;
            if(Core.renderMode == BUFFERED_RENDER)
            {
                Core.createBuffer();
            }
            screenTransformMatrix.translate(xDifference,yDifference);
        }
        else
        {
            trace("Attempted to resize virtual screen which is only supported in BUFFERED_RENDER mode");
        }
    }

    public static function scaleScreen(scale:Float,centerX:Float = 0, centerY:Float = 0)
        changeScreenTransformMatrix(generateTransformMatrix(0,0,centerX,centerY,scale,scale));

    public static function scaleScreenX(scale:Float,centerX:Float = 0, centerY:Float = 0)
        changeScreenTransformMatrix(generateTransformMatrix(0,0,centerX,centerY,scale,1));

    public static function scaleScreenY(scale:Float,centerX:Float = 0, centerY:Float = 0)
        changeScreenTransformMatrix(generateTransformMatrix(0,0,centerX,centerY,1,scale));

    public static function rotateScreen(rotate:Float,centerX:Float = 0, centerY:Float = 0)
        changeScreenTransformMatrix(generateTransformMatrix(0,0,centerX,centerY,1,1,rotate));

    public static function translateScreen(x:Float,y:Float)
        changeScreenTransformMatrix(generateTransformMatrix(0,0));

    private static inline function changeScreenTransformMatrix(matrix:Matrix)
    {
        matrix = matrix.clone(); //in case the matrix is screenTransformMatrix
        screenTransformMatrix.concat(matrix);
        if(Core.renderMode == SCREEN_RENDER)
        {
            transformScreen(matrix);
        }
    }

    //is only called when renderMode is SCREEN_RENDER
    private static function transformScreen(matrix:Matrix)
    {
        var temp = new BitmapData (Std.int(Core.screen.rect.width),Std.int(Core.screen.rect.height),false,Core.fillColor);
        temp.draw(Core.screen,matrix);
        Core.clear(Core.fillColor);
        Core.screen.draw(temp);
    }

    public static function getScreenTransformMatrix():Matrix
        return screenTransformMatrix;

    public static function setScreenTransformMatrix(matrix:Matrix)
    {
        resetScreenTransform();
        changeScreenTransformMatrix(matrix);
    }

    public static function resetScreenTransform()
    {
        var matrix = screenTransformMatrix.clone();
        matrix.invert();
        changeScreenTransformMatrix(matrix);
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
}
