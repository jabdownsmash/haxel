
package haxel;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.MovieClip;
import flash.display.Stage;
import flash.Lib;
import flash.geom.Point;
import flash.geom.Matrix;

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

class Core extends Sprite
{
    public static var renderMode:RenderMode;
    public static var buffer:BitmapData;
    public static var screen:BitmapData;
    public static var instance:Core;

    public static var fillColor:UInt;

    public function new (bgColor = 0x000000, ?render:RenderMode)
    {
        super ();

        if(render == null)
        {
            render = BUFFERED_RENDER;
        }
        
        fillColor = bgColor;
        renderMode = render;

        // ScreenUtils.init();
        ScreenUtils.screenTransformMatrix = new Matrix();
        ScreenUtils.virtualScreenStartX = 0;
        ScreenUtils.virtualScreenStartY = 0;
        ScreenUtils.virtualScreenWidth = stage.stageWidth;
        ScreenUtils.virtualScreenHeight = stage.stageHeight;

        if(renderMode == BUFFERED_RENDER)
        {
            createBuffer();
        }

        // Input.init();

        screen = new BitmapData (stage.stageWidth,stage.stageHeight,false,fillColor);

        addChild (new Bitmap(screen)); //creates a bitmap out of the screen BD and adds it to the sprite

        instance = this;
    }

    public static function createBuffer()
    {
        buffer = new BitmapData (Std.int(ScreenUtils.virtualScreenWidth),Std.int(ScreenUtils.virtualScreenHeight),false,fillColor);
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
        x += ScreenUtils.virtualScreenStartX;
        y += ScreenUtils.virtualScreenStartY;
        var transformMatrix = ScreenUtils.generateTransformMatrix(x,y,centerX,centerY,xScale,yScale,rotation);
        if(renderMode == BUFFERED_RENDER)
        {
            buffer.draw(image,transformMatrix);
        }
        else if(renderMode == SCREEN_RENDER)
        {
            transformMatrix.concat(ScreenUtils.screenTransformMatrix);
            screen.draw(image,transformMatrix);
        }
    }

    public static function flip()
    {
        if(renderMode == BUFFERED_RENDER)
        {
            screen.draw(buffer,ScreenUtils.screenTransformMatrix);
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

    //wtf that was so easy
}
