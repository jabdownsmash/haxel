
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
    public static var buffer:BitmapData;
    public static var screen:BitmapData;
    public static var fillColor:Int = -1;

    private static var screenTransformMatrix:Matrix;
    private static var virtualScreenStartX:Float;
    private static var virtualScreenStartY:Float;
    private static var virtualScreenWidth:Float;
    private static var virtualScreenHeight:Float;

    public static function init()
    {
        var screenWidth = Core.instance.stage.stageWidth;
        var screenHeight = Core.instance.stage.stageHeight;

        if(fillColor == -1)
            fillColor = 0x000000;
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

        screen = new BitmapData (screenWidth,screenHeight,false,fillColor);
        Core.instance.addChild (new Bitmap(screen)); //creates a bitmap out of the screen BD and adds it to the sprite
    }

    public static function createBuffer()
    {
        buffer = new BitmapData (Std.int(virtualScreenWidth),Std.int(virtualScreenHeight),false,fillColor);
    }

    public static function getDrawTarget():BitmapData
    {
        if(renderMode == BUFFERED_RENDER)
        {
            return buffer;
        }
        else if(renderMode == SCREEN_RENDER)
        {
            return screen;
        }
        return buffer;
    }

    public static function draw(image:BitmapData,x:Float,y:Float, centerX:Float = 0, centerY:Float = 0, xScale:Float = 1, yScale:Float = 1, rotation:Float = 0)
    {
        x += virtualScreenStartX;
        y += virtualScreenStartY;
        var transformMatrix = generateTransformMatrix(x,y,centerX,centerY,xScale,yScale,rotation);
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

    public static function clear(color:Int)
    {
        if(renderMode == BUFFERED_RENDER)
        {
            buffer.fillRect(buffer.rect, color);
        }
        else if(renderMode == SCREEN_RENDER)
        {
            screen.fillRect(screen.rect, color);
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
        if(renderMode == SCREEN_RENDER)
        {
            transformScreen(matrix);
        }
    }

    //is only called when renderMode is SCREEN_RENDER
    private static function transformScreen(matrix:Matrix)
    {
        var temp = new BitmapData (Std.int(screen.rect.width),Std.int(screen.rect.height),false,fillColor);
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

    //wtf still was so easy
}
