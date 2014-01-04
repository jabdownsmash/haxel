
package haxel;

import flash.display.Bitmap;
import flash.display.BitmapData;
import haxel.Core;

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

    private static function alphaSetPixel(x:Int,y:Int,color:UInt,alpha:Float,drawTarget:BitmapData)
    {

        //ENGAGE MAXIMUM OPTIMIZED mZ LELELEL

        // alpha = m.min(alpha,1);
        var colorR= ((m.floor(color / 256*256) %256));
        var colorG = ((m.floor(color / 256) %256));
        var colorB = ((color %256));

        var pixel = drawTarget.getPixel(x,y);
        var pixelR = ((m.floor(pixel / 256*256) %256));
        var pixelG = ((m.floor(pixel / 256) %256));
        var pixelB = ((pixel %256));

        var finalR = colorR + m.floor((pixelR - colorR)*(1-alpha));
        var finalG = colorG + m.floor((pixelG - colorG)*(1-alpha));
        var finalB = colorB + m.floor((pixelB - colorB)*(1-alpha));

        var finalColor = finalR * 256 * 256 + finalG * 256 + finalB;
        // trace(finalColor);
        drawTarget.setPixel(x, y, finalColor);
    }
    
    private static function setAAPixel(x:Float, y:Float, color:UInt, alpha:Float=1, antiAlias:Bool=false, drawTarget:BitmapData)
    {
        if(!antiAlias)
        {
            alphaSetPixel(m.floor(x), m.floor(y), color,alpha,drawTarget);
        }
        else
        {
            var xDecimal:Float = x % 1;
            var yDecimal:Float = y % 1;
            
            if(xDecimal < yDecimal)
            {
                xDecimal = 0;
            } else {
                yDecimal = 0;
            }

            if(xDecimal == 0 && yDecimal == 0)
            {
                alphaSetPixel(m.round(x), m.round(y), color,alpha,drawTarget);
            }
            else if (yDecimal == 0)
            {
                alphaSetPixel(m.floor(x), m.floor(y), color,alpha*(1-xDecimal),drawTarget);
                alphaSetPixel(m.ceil(x), m.floor(y), color,alpha*xDecimal,drawTarget);
            }
            else if (xDecimal == 0)
            {
                alphaSetPixel(m.floor(x), m.floor(y), color,alpha*(1-yDecimal),drawTarget);
                alphaSetPixel(m.floor(x), m.ceil(y), color,alpha*yDecimal,drawTarget);
            }
        }
    }

    private static function drawSolidLine(startX:Float, startY:Float, endX:Float, endY:Float, color:UInt, alpha:Float, drawTarget:BitmapData)
    {
        var dx:Float = m.abs(endX - startX);
        var dy:Float = m.abs(endY - startY);
        
        var slope:Float = dy/dx;
        
        if(dx >= dy)
        {
            if(startX > endX)
            {
                var t:Float = startX;
                startX = endX;
                endX = t;
                t = startY;
                startY = endY;
                endY = t;
            }
            for(x in 0...m.floor(dx))
            {
                var y:Float = slope*x;
                alphaSetPixel(m.floor(startX+x), m.floor(startY+y), color, alpha, drawTarget);
            }
        }
        else
        {
            if(startY > endY)
            {
                var t:Float = startX;
                startX = endX;
                endX = t;
                t = startY;
                startY = endY;
                endY = t;
            }
            for(y in m.floor(startY)...m.floor(endY))
            {
                var x = y/slope+startX;
                alphaSetPixel(m.floor(x), y, color, alpha, drawTarget);
            }
        }
    }

    private static function drawAALine(startX:Float, startY:Float, endX:Float, endY:Float, color:UInt, alpha:Float, drawTarget:BitmapData)
    {
        var steep:Bool = m.abs(endY - startY) > m.abs(endX - startX);
 
        if(steep)
        {
            var temp = startX;
            startX = startY;
            startY = temp;

            temp = endX;
            endX = endY;
            endY = temp;
        }

        if(startX > endX)
        {
            var temp = startX;
            startX = endX;
            endX = temp;

            temp = startY;
            startY = endY;
            endY = temp;
        }
        if(endX == startX)
        {
            // uhhh
        }
     
        var slope = (endY - startY) / (endX - startX);
     
         // handle first endpoint
        var endpointX = m.floor(startX);
        var endpointY = startY + slope * (endpointX - startX);
        var xGap:Float = 1 - (startX)%1;
        var startPixelX = endpointX;   //this will be used in the main loop
        var startPixelY = m.floor(endpointY);
        if(steep)
        {
            alphaSetPixel(startPixelY,   startPixelX, color, (1 - (endpointY % 1)) * xGap, drawTarget);
            alphaSetPixel(startPixelY+1, startPixelX, color, (endpointY % 1) * xGap, drawTarget);
        }
        else
        {
            alphaSetPixel(startPixelX, startPixelY  , color, (1 - (endpointY % 1)) * xGap, drawTarget);
            alphaSetPixel(startPixelX, startPixelY+1, color, (endpointY % 1) * xGap, drawTarget);
        }

        var yIntercept = endpointY + slope; // first y-intersection for the main loop
     
         // handle second endpoint
     
        endpointX = m.floor(endX);
        endpointY = endY + slope * (endpointX - endX);
        xGap = (endX)%1;
        var endPixelX = endpointX; //this will be used in the main loop
        var endPixelY = m.floor(endpointY);
        if(steep)
        {
            alphaSetPixel(endPixelY,   endPixelX, color, (1 - (endpointY % 1)) * xGap, drawTarget);
            alphaSetPixel(endPixelY + 1, endPixelX, color, (endpointY % 1) * xGap, drawTarget);
        }
        else
        {
            alphaSetPixel(endPixelX, endPixelY, color, (1 - (endpointY % 1)) * xGap, drawTarget);
            alphaSetPixel(endPixelX, endPixelY + 1, color, (endpointY % 1) * xGap, drawTarget);
        }
        // trace(xGap);
        // trace(endpointY);
     
         // main loop
     
        for(x in (startPixelX + 1)...(endPixelX))
        {
            if(steep)
            {
                alphaSetPixel(m.floor(yIntercept)  , x, color, 1 - (yIntercept%1), drawTarget);
                alphaSetPixel(m.floor(yIntercept)+1, x, color, yIntercept%1, drawTarget);
            }
            else
            {
                alphaSetPixel(x, m.floor(yIntercept),  color, 1 - (yIntercept%1), drawTarget);
                alphaSetPixel(x, m.floor(yIntercept)+1, color, yIntercept%1, drawTarget);
            }
            yIntercept = yIntercept + slope;
        }
        // trace(steep);
    }
    
    public static function drawLine(startX:Float, startY:Float, endX:Float, endY:Float, color:UInt, ?alpha:Float, ?lineWidth:Float, ?antiAlias:Bool, ?drawTarget:BitmapData)
    {
        if(drawTarget == null)
        {
            drawTarget = Screen.getDrawTarget();
        }
        if(alpha == null)
        {
            alpha = 1;
        }
        //prevents things from trying to update the drawTarget
        //in between setpixels
        drawTarget.lock();
        
        if(lineWidth == null || lineWidth == 0)
        {
            if(antiAlias == null || antiAlias == false)
                drawSolidLine(startX,startY,endX,endY,color,alpha,drawTarget);
            else
                drawAALine(startX,startY,endX,endY,color,alpha,drawTarget);
        }
        else
        {
            // drawWidthLine(startX,startY,endX,endY,color,alpha,lineWidth,drawTarget);
        }
        
        //releases control of drawTarget
        //should optimize this with a rectangle that encapsulates 
        //the changes
        drawTarget.unlock();
    }
    
    public static function drawCircle(centerX:Float, centerY:Float, radius:Float, color:UInt, alpha:Float=1, antiAlias:Bool=false, lineWidth:Float=1, ?drawTarget:BitmapData)
    {
        if(drawTarget == null)
        {
            drawTarget = Screen.getDrawTarget();
        }
        drawTarget.lock();
        var c:Int = m.ceil(0.71*radius);
        for(x in 0...m.floor(c))
        {
            if(lineWidth==0)
            {
                var y:Float = m.sqrt(radius*radius - x*x);
                drawSolidLine(m.round(centerX+x), m.round(centerY), m.round(centerX + x), m.round(centerY+y), color, alpha, drawTarget);
                drawSolidLine(m.round(centerX+x), m.round(centerY), m.round(centerX + x), m.round(centerY-y), color, alpha, drawTarget);
                drawSolidLine(m.round(centerX-x), m.round(centerY), m.round(centerX - x), m.round(centerY+y), color, alpha, drawTarget);
                drawSolidLine(m.round(centerX-x), m.round(centerY), m.round(centerX - x), m.round(centerY-y), color, alpha, drawTarget);
                drawSolidLine(m.round(centerX+y), m.round(centerY), m.round(centerX + y), m.round(centerY+x), color, alpha, drawTarget);
                drawSolidLine(m.round(centerX+y), m.round(centerY), m.round(centerX + y), m.round(centerY-x), color, alpha, drawTarget);
                drawSolidLine(m.round(centerX-y), m.round(centerY), m.round(centerX - y), m.round(centerY+x), color, alpha, drawTarget);
                drawSolidLine(m.round(centerX-y), m.round(centerY), m.round(centerX - y), m.round(centerY-x), color, alpha, drawTarget);
            }
            else
            {
                var y:Float = m.sqrt(radius*radius - x*x);
                setAAPixel(centerX + x, centerY+y, color, alpha, antiAlias, drawTarget);
                setAAPixel(centerX + x, centerY-y, color, alpha, antiAlias, drawTarget);
                setAAPixel(centerX - x, centerY+y, color, alpha, antiAlias, drawTarget);
                setAAPixel(centerX - x, centerY-y, color, alpha, antiAlias, drawTarget);
                setAAPixel(centerX + y, centerY+x, color, alpha, antiAlias, drawTarget);
                setAAPixel(centerX + y, centerY-x, color, alpha, antiAlias, drawTarget);
                setAAPixel(centerX - y, centerY+x, color, alpha, antiAlias, drawTarget);
                setAAPixel(centerX - y, centerY-x, color, alpha, antiAlias, drawTarget);
            }
        }
        if(antiAlias)
        {
            var x:Float = m.floor(c);
            var y:Float = m.sqrt(radius*radius - x*x);
            setAAPixel(centerX + x, centerY+y, color, alpha, antiAlias, drawTarget);
            setAAPixel(centerX + x, centerY-y, color, alpha, antiAlias, drawTarget);
            setAAPixel(centerX - x, centerY+y, color, alpha, antiAlias, drawTarget);
            setAAPixel(centerX - x, centerY-y, color, alpha, antiAlias, drawTarget);
            // setAAPixel(centerX + y, centerY+x, color, alpha, antiAlias, drawTarget);
            // setAAPixel(centerX + y, centerY-x, color, alpha, antiAlias, drawTarget);
            // setAAPixel(centerX - y, centerY+x, color, alpha, antiAlias, drawTarget);
            // setAAPixel(centerX - y, centerY-x, color, alpha, antiAlias, drawTarget);
        }
        drawTarget.unlock();
    }

    public static function drawEllipse(centerX:Float, centerY:Float, a:Float, b:Float, color:UInt, ?AntiAlias:Bool, ?drawTarget:BitmapData)
    {
        if(drawTarget == null)
        {
            drawTarget = Screen.getDrawTarget();
        }
        drawTarget.lock();
        
        //var c:Int = m.floor(0.71*a);
        for(x in 0...m.floor(a))
        {
            var y:Float = b*m.sqrt(1 - x*x/(a*a));
            drawTarget.setPixel(m.floor(centerX + x), m.floor(centerY+y), color);
            drawTarget.setPixel(m.floor(centerX + x), m.floor(centerY-y), color);
        }
        drawTarget.unlock();
    }

    public static function drawPolygon(points:Array<Array<Float>>, color:UInt, ?lineWidth, ?antiAlias:Bool, ?drawTarget:BitmapData)
    {
        if(drawTarget == null)
        {
            drawTarget = Screen.getDrawTarget();
        }
        drawTarget.lock();

        if(lineWidth == null)
        {
            lineWidth = 1;
        }
        
        if(lineWidth > 0)
        {
            var lastX:Float = points[points.length-1][0];
            var lastY:Float = points[points.length-1][1];

            for(i in 0...points.length)
            {
                var x:Float = points[i][0];
                var y:Float = points[i][1];
                //trace(lastX+", "+lastY+", "+x+", "+y);
                drawLine(lastX, lastY, x, y, color, lineWidth, antiAlias, drawTarget);
                
                lastX = x;
                lastY = y;
            }
        }
        
        drawTarget.unlock();
    }
}