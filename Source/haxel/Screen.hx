
package haxel;

import flash.geom.Matrix;
import flash.display.BitmapData;
import flash.display.Bitmap;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//
//                                                                          //
//   Because of the nature of this project, please PLEASE test any change   //
//   on HTML5, Flash, AND native. Any changes made for compatibility or     //
//   optimization ABSOLUTELY NEED to be fully documented: reasons, effects  //
//   and changes made. -Aaron                                               //
//                                                                          //
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//

enum RenderMode
{
    BUFFERED_RENDER;
    SCREEN_RENDER;
}

class Screen
{
    public static var renderMode:RenderMode;
    public static var buffer:GraphicObject;
    public static var screen:GraphicObject;
    public static var fillColor:ColorObject;

    private static var screenTransformMatrix:Matrix;
    private static var virtualScreenStartX:Float;
    private static var virtualScreenStartY:Float;
    private static var virtualScreenWidth:Float;
    private static var virtualScreenHeight:Float;

    public static function init()
    {
        var screenWidth = Core.instance.stage.stageWidth;
        var screenHeight = Core.instance.stage.stageHeight;

        if(fillColor == null)
            fillColor = new ColorObject(0,0,0);
        if(renderMode == null)
            renderMode = BUFFERED_RENDER;

        screenTransformMatrix = new Matrix();
        virtualScreenStartX = 0;
        virtualScreenStartY = 0;
        virtualScreenWidth = screenWidth;
        virtualScreenHeight = screenHeight;

        if(renderMode == BUFFERED_RENDER)
        {
            createBuffer();
        }

        screen = new GraphicObject(screenWidth,screenHeight,false,fillColor);
        Core.instance.addChild(screen.getBitmap()); //creates a bitmap out of the screen BD and adds it to the sprite
    }

    public static function createBuffer()
    {
        buffer = new GraphicObject(Std.int(virtualScreenWidth),Std.int(virtualScreenHeight),false,fillColor);
    }

    public static function getDrawTarget():GraphicObject
    {
        if(renderMode == SCREEN_RENDER)
        {
            return screen;
        }
        return buffer;
    }

    public static function draw(image:Dynamic,x:Float,y:Float, centerX:Float = 0, centerY:Float = 0, xScale:Float = 1, yScale:Float = 1, rotation:Float = 0)
    {
        x += virtualScreenStartX;
        y += virtualScreenStartY;
        var transformMatrix = Utils.generateTransformMatrix(x,y,centerX,centerY,xScale,yScale,rotation);
        if(renderMode == BUFFERED_RENDER)
        {
            buffer.draw(image,transformMatrix);
        }
        else if(renderMode == SCREEN_RENDER)
        {
            transformMatrix.concat(screenTransformMatrix);
            screen.draw(image,transformMatrix);
        }
    }

    public static function flip()
    {
        if(renderMode == BUFFERED_RENDER)
        {
            screen.draw(buffer,screenTransformMatrix);
        }
    }

    public static function clear(color:ColorObject)
    {
        if(renderMode == BUFFERED_RENDER)
        {
            buffer.clear(color);
        }
        else if(renderMode == SCREEN_RENDER)
        {
            screen.clear(color);
        }
    }

    public static function resizeVirtualScreen(width:Float, height:Float, x:Float, y:Float)
    {
        if(renderMode == BUFFERED_RENDER)
        {
            var xDifference = virtualScreenStartX - x;
            var yDifference = virtualScreenStartY - y;
            virtualScreenWidth = width;
            virtualScreenHeight = height;
            virtualScreenStartX = x;
            virtualScreenStartY = y;
            if(renderMode == BUFFERED_RENDER)
            {
                createBuffer();
            }
            screenTransformMatrix.translate(xDifference,yDifference);
        }
        else
        {
            trace("Attempted to resize virtual screen which is only supported in BUFFERED_RENDER mode");
        }
    }

    public static function scaleScreen(scale:Float,centerX:Float = 0, centerY:Float = 0)
        changeScreenTransformMatrix(Utils.generateTransformMatrix(0,0,centerX,centerY,scale,scale));

    public static function scaleScreenX(scale:Float,centerX:Float = 0, centerY:Float = 0)
        changeScreenTransformMatrix(Utils.generateTransformMatrix(0,0,centerX,centerY,scale,1));

    public static function scaleScreenY(scale:Float,centerX:Float = 0, centerY:Float = 0)
        changeScreenTransformMatrix(Utils.generateTransformMatrix(0,0,centerX,centerY,1,scale));

    public static function rotateScreen(rotate:Float,centerX:Float = 0, centerY:Float = 0)
        changeScreenTransformMatrix(Utils.generateTransformMatrix(0,0,centerX,centerY,1,1,rotate));

    public static function translateScreen(x:Float,y:Float)
        changeScreenTransformMatrix(Utils.generateTransformMatrix(0,0));

    private static inline function changeScreenTransformMatrix(matrix:Matrix)
    {
        matrix = matrix.clone(); //in case the matrix is screenTransformMatrix
        screenTransformMatrix.concat(matrix);
        if(renderMode == SCREEN_RENDER)
        {
            transformScreen(matrix);
        }
    }

    //is only called when renderMode is SCREEN_RENDER
    private static function transformScreen(matrix:Matrix)
    {
        var temp = new GraphicObject (Std.int(screen.width),Std.int(screen.height),false,fillColor);
        temp.draw(screen,matrix);
        clear(fillColor);
        screen.draw(temp);
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

    //wtf still was so easy
}
