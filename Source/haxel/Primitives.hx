
package haxel;

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
    
    private static function setAAPixel(drawTarget:GraphicObject, x:Float, y:Float, color:ColorObject, alpha:Float=1, antiAlias:Bool=false)
    {
        if(!antiAlias)
        {
            drawTarget.drawPixel(m.floor(x), m.floor(y), color,alpha);
        }
        else
        {
            var xDecimal:Float = x % 1;
            var yDecimal:Float = y % 1;
            
            if(xDecimal < yDecimal)
            {
                xDecimal = 0;
            }
            else
            {
                yDecimal = 0;
            }

            if(xDecimal == 0 && yDecimal == 0)
            {
                drawTarget.drawPixel(m.round(x), m.round(y), color,alpha);
            }
            else if (yDecimal == 0)
            {
                drawTarget.drawPixel(m.floor(x), m.floor(y), color,alpha*(1-xDecimal));
                drawTarget.drawPixel(m.ceil(x), m.floor(y), color,alpha*xDecimal);
            }
            else if (xDecimal == 0)
            {
                drawTarget.drawPixel(m.floor(x), m.floor(y), color,alpha*(1-yDecimal));
                drawTarget.drawPixel(m.floor(x), m.ceil(y), color,alpha*yDecimal);
            }
        }
    }

    private static function drawSolidLine(drawTarget:GraphicObject, startX:Float, startY:Float, endX:Float, endY:Float, color:ColorObject, alpha:Float)
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
                drawTarget.drawPixel(m.floor(startX+x), m.floor(startY+y), color, alpha);
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
                drawTarget.drawPixel(m.floor(x), y, color, alpha);
            }
        }
    }

    private static function drawAALine(drawTarget:GraphicObject, startX:Float, startY:Float, endX:Float, endY:Float, color:ColorObject, alpha:Float)
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
            drawTarget.drawPixel(startPixelY,   startPixelX, color, (1 - (endpointY % 1)) * xGap);
            drawTarget.drawPixel(startPixelY+1, startPixelX, color, (endpointY % 1) * xGap);
        }
        else
        {
            drawTarget.drawPixel(startPixelX, startPixelY  , color, (1 - (endpointY % 1)) * xGap);
            drawTarget.drawPixel(startPixelX, startPixelY+1, color, (endpointY % 1) * xGap);
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
            drawTarget.drawPixel(endPixelY,   endPixelX, color, (1 - (endpointY % 1)) * xGap);
            drawTarget.drawPixel(endPixelY + 1, endPixelX, color, (endpointY % 1) * xGap);
        }
        else
        {
            drawTarget.drawPixel(endPixelX, endPixelY, color, (1 - (endpointY % 1)) * xGap);
            drawTarget.drawPixel(endPixelX, endPixelY + 1, color, (endpointY % 1) * xGap);
        }
        // trace(xGap);
        // trace(endpointY);
     
         // main loop
     
        for(x in (startPixelX + 1)...(endPixelX))
        {
            if(steep)
            {
                drawTarget.drawPixel(m.floor(yIntercept)  , x, color, 1 - (yIntercept%1));
                drawTarget.drawPixel(m.floor(yIntercept)+1, x, color, yIntercept%1);
            }
            else
            {
                drawTarget.drawPixel(x, m.floor(yIntercept),  color, 1 - (yIntercept%1));
                drawTarget.drawPixel(x, m.floor(yIntercept)+1, color, yIntercept%1);
            }
            yIntercept = yIntercept + slope;
        }
        // trace(steep);
    }
    
    public static function drawLine(?drawTarget:GraphicObject, startX:Float, startY:Float, endX:Float, endY:Float, color:ColorObject, ?alpha:Float, ?lineWidth:Float, ?antiAlias:Bool)
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
                drawSolidLine(drawTarget,startX,startY,endX,endY,color,alpha);
            else
                drawAALine(drawTarget,startX,startY,endX,endY,color,alpha);
        }
        else
        {
            // drawWidthLine(drawTarget,startX,startY,endX,endY,color,alpha,lineWidth);
        }
        
        //releases control of drawTarget
        //should optimize this with a rectangle that encapsulates 
        //the changes
        drawTarget.unlock();
    }
    
    public static function drawCircle(?drawTarget:GraphicObject, centerX:Float, centerY:Float, radius:Float, color:ColorObject, alpha:Float=1, antiAlias:Bool=false, lineWidth:Float=1)
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
                drawSolidLine(drawTarget, m.round(centerX+x), m.round(centerY), m.round(centerX + x), m.round(centerY+y), color, alpha);
                drawSolidLine(drawTarget, m.round(centerX+x), m.round(centerY), m.round(centerX + x), m.round(centerY-y), color, alpha);
                drawSolidLine(drawTarget, m.round(centerX-x), m.round(centerY), m.round(centerX - x), m.round(centerY+y), color, alpha);
                drawSolidLine(drawTarget, m.round(centerX-x), m.round(centerY), m.round(centerX - x), m.round(centerY-y), color, alpha);
                drawSolidLine(drawTarget, m.round(centerX+y), m.round(centerY), m.round(centerX + y), m.round(centerY+x), color, alpha);
                drawSolidLine(drawTarget, m.round(centerX+y), m.round(centerY), m.round(centerX + y), m.round(centerY-x), color, alpha);
                drawSolidLine(drawTarget, m.round(centerX-y), m.round(centerY), m.round(centerX - y), m.round(centerY+x), color, alpha);
                drawSolidLine(drawTarget, m.round(centerX-y), m.round(centerY), m.round(centerX - y), m.round(centerY-x), color, alpha);
            }
            else
            {
                var y:Float = m.sqrt(radius*radius - x*x);
                setAAPixel(drawTarget, centerX + x, centerY+y, color, alpha, antiAlias);
                setAAPixel(drawTarget, centerX + x, centerY-y, color, alpha, antiAlias);
                setAAPixel(drawTarget, centerX - x, centerY+y, color, alpha, antiAlias);
                setAAPixel(drawTarget, centerX - x, centerY-y, color, alpha, antiAlias);
                setAAPixel(drawTarget, centerX + y, centerY+x, color, alpha, antiAlias);
                setAAPixel(drawTarget, centerX + y, centerY-x, color, alpha, antiAlias);
                setAAPixel(drawTarget, centerX - y, centerY+x, color, alpha, antiAlias);
                setAAPixel(drawTarget, centerX - y, centerY-x, color, alpha, antiAlias);
            }
        }
        if(antiAlias)
        {
            var x:Float = m.floor(c);
            var y:Float = m.sqrt(radius*radius - x*x);
            setAAPixel(drawTarget, centerX + x, centerY+y, color, alpha, antiAlias);
            setAAPixel(drawTarget, centerX + x, centerY-y, color, alpha, antiAlias);
            setAAPixel(drawTarget, centerX - x, centerY+y, color, alpha, antiAlias);
            setAAPixel(drawTarget, centerX - x, centerY-y, color, alpha, antiAlias);
            // setAAPixel(drawTarget, centerX + y, centerY+x, color, alpha, antiAlias);
            // setAAPixel(drawTarget, centerX + y, centerY-x, color, alpha, antiAlias);
            // setAAPixel(drawTarget, centerX - y, centerY+x, color, alpha, antiAlias);
            // setAAPixel(drawTarget, centerX - y, centerY-x, color, alpha, antiAlias);
        }
        drawTarget.unlock();
    }

    public static function drawEllipse(?drawTarget:GraphicObject, centerX:Float, centerY:Float, a:Float, b:Float, color:ColorObject, ?AntiAlias:Bool)
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

    public static function drawPolygon(?drawTarget:GraphicObject, points:Array<Array<Float>>, color:ColorObject, ?lineWidth, ?antiAlias:Bool)
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
                drawLine(drawTarget, lastX, lastY, x, y, color, lineWidth, antiAlias);
                
                lastX = x;
                lastY = y;
            }
        }
        
        drawTarget.unlock();
    }
}