
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
    
    private static function setAAPixel(drawTarget:GraphicObject, x:Float, y:Float, color:ColorObject, antiAlias:Bool=false)
    {
        if(!antiAlias)
        {
            drawTarget.drawPixel(m.floor(x), m.floor(y), color);
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
                drawTarget.drawPixel(m.round(x), m.round(y), color);
            }
            else if (yDecimal == 0)
            {
                drawTarget.drawPixel(m.floor(x), m.floor(y), new ColorObject(color.r,color.g,color.b,color.a*(1-xDecimal)));
                drawTarget.drawPixel(m.ceil(x), m.floor(y), new ColorObject(color.r,color.g,color.b,color.a*xDecimal));
            }
            else if (xDecimal == 0)
            {
                drawTarget.drawPixel(m.floor(x), m.floor(y), new ColorObject(color.r,color.g,color.b,color.a*(1-yDecimal)));
                drawTarget.drawPixel(m.floor(x), m.ceil(y), new ColorObject(color.r,color.g,color.b,color.a*yDecimal));
            }
        }
    }

    private static function drawSolidLine(drawTarget:GraphicObject, startX:Float, startY:Float, endX:Float, endY:Float, color:ColorObject)
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
                drawTarget.drawPixel(m.floor(startX+x), m.floor(startY+y), color);
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
                drawTarget.drawPixel(m.floor(x), y, color);
            }
        }
    }

    private static function drawAALine(drawTarget:GraphicObject, startX:Float, startY:Float, endX:Float, endY:Float, color:ColorObject)
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
            drawTarget.drawPixel(startPixelY,   startPixelX, new ColorObject(color.r,color.g,color.b, color.a * (1 - (endpointY % 1)) * xGap));
            drawTarget.drawPixel(startPixelY+1, startPixelX, new ColorObject(color.r,color.g,color.b, color.a * (endpointY % 1) * xGap));
        }
        else
        {
            drawTarget.drawPixel(startPixelX, startPixelY  , new ColorObject(color.r,color.g,color.b, color.a * (1 - (endpointY % 1)) * xGap));
            drawTarget.drawPixel(startPixelX, startPixelY+1, new ColorObject(color.r,color.g,color.b, color.a * (endpointY % 1) * xGap));
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
            drawTarget.drawPixel(endPixelY,   endPixelX, new ColorObject(color.r,color.g,color.b, color.a * (1 - (endpointY % 1)) * xGap));
            drawTarget.drawPixel(endPixelY + 1, endPixelX, new ColorObject(color.r,color.g,color.b, color.a * (endpointY % 1) * xGap));
        }
        else
        {
            drawTarget.drawPixel(endPixelX, endPixelY, new ColorObject(color.r,color.g,color.b, color.a * (1 - (endpointY % 1)) * xGap));
            drawTarget.drawPixel(endPixelX, endPixelY + 1, new ColorObject(color.r,color.g,color.b, color.a * (endpointY % 1) * xGap));
        }
        // trace(xGap);
        // trace(endpointY);
     
         // main loop
     
        for(x in (startPixelX + 1)...(endPixelX))
        {
            if(steep)
            {
                drawTarget.drawPixel(m.floor(yIntercept)  , x, new ColorObject(color.r,color.g,color.b, color.a * (1 - (yIntercept%1))));
                drawTarget.drawPixel(m.floor(yIntercept)+1, x, new ColorObject(color.r,color.g,color.b, color.a * yIntercept%1));
            }
            else
            {
                drawTarget.drawPixel(x, m.floor(yIntercept),  new ColorObject(color.r,color.g,color.b, color.a * (1 - (yIntercept%1))));
                drawTarget.drawPixel(x, m.floor(yIntercept)+1, new ColorObject(color.r,color.g,color.b, color.a * yIntercept%1));
            }
            yIntercept = yIntercept + slope;
        }
        // trace(steep);
    }
    
    public static function drawLine(?drawTarget:GraphicObject, startX:Float, startY:Float, endX:Float, endY:Float, color:ColorObject, lineWidth:Float=1, antiAlias:Bool=false)
    {
        if(drawTarget == null)
        {
            drawTarget = Screen.getDrawTarget();
        }
        //prevents things from trying to update the drawTarget
        //in between setpixels
        drawTarget.lock();
        
        if(lineWidth == 1)
        {
            if(antiAlias == false)
                drawSolidLine(drawTarget,startX,startY,endX,endY,color);
            else
                drawAALine(drawTarget,startX,startY,endX,endY,color);
        }
        else
        {
            if(antiAlias == false)
                drawSolidLine(drawTarget,startX,startY,endX,endY,color);
            else
                drawAALine(drawTarget,startX,startY,endX,endY,color);
            // drawWidthLine(drawTarget,startX,startY,endX,endY,color,lineWidth);
        }
        
        //releases control of drawTarget
        //should optimize this with a rectangle that encapsulates 
        //the changes
        drawTarget.unlock();
    }
    
    public static function drawCircle(?drawTarget:GraphicObject, centerX:Float, centerY:Float, radius:Float, color:ColorObject, antiAlias:Bool=false, lineWidth:Float=1)
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
                drawSolidLine(drawTarget, m.round(centerX+x), m.round(centerY), m.round(centerX + x), m.round(centerY+y), color);
                drawSolidLine(drawTarget, m.round(centerX+x), m.round(centerY), m.round(centerX + x), m.round(centerY-y), color);
                drawSolidLine(drawTarget, m.round(centerX-x), m.round(centerY), m.round(centerX - x), m.round(centerY+y), color);
                drawSolidLine(drawTarget, m.round(centerX-x), m.round(centerY), m.round(centerX - x), m.round(centerY-y), color);
                drawSolidLine(drawTarget, m.round(centerX+y), m.round(centerY), m.round(centerX + y), m.round(centerY+x), color);
                drawSolidLine(drawTarget, m.round(centerX+y), m.round(centerY), m.round(centerX + y), m.round(centerY-x), color);
                drawSolidLine(drawTarget, m.round(centerX-y), m.round(centerY), m.round(centerX - y), m.round(centerY+x), color);
                drawSolidLine(drawTarget, m.round(centerX-y), m.round(centerY), m.round(centerX - y), m.round(centerY-x), color);
            }
            else
            {
                var y:Float = m.sqrt(radius*radius - x*x);
                setAAPixel(drawTarget, centerX + x, centerY+y, color, antiAlias);
                setAAPixel(drawTarget, centerX + x, centerY-y, color, antiAlias);
                setAAPixel(drawTarget, centerX - x, centerY+y, color, antiAlias);
                setAAPixel(drawTarget, centerX - x, centerY-y, color, antiAlias);
                setAAPixel(drawTarget, centerX + y, centerY+x, color, antiAlias);
                setAAPixel(drawTarget, centerX + y, centerY-x, color, antiAlias);
                setAAPixel(drawTarget, centerX - y, centerY+x, color, antiAlias);
                setAAPixel(drawTarget, centerX - y, centerY-x, color, antiAlias);
            }
        }
        if(antiAlias)
        {
            var x:Float = m.floor(c);
            var y:Float = m.sqrt(radius*radius - x*x);
            setAAPixel(drawTarget, centerX + x, centerY+y, color, antiAlias);
            setAAPixel(drawTarget, centerX + x, centerY-y, color, antiAlias);
            setAAPixel(drawTarget, centerX - x, centerY+y, color, antiAlias);
            setAAPixel(drawTarget, centerX - x, centerY-y, color, antiAlias);
            // setAAPixel(drawTarget, centerX + y, centerY+x, color, antiAlias);
            // setAAPixel(drawTarget, centerX + y, centerY-x, color, antiAlias);
            // setAAPixel(drawTarget, centerX - y, centerY+x, color, antiAlias);
            // setAAPixel(drawTarget, centerX - y, centerY-x, color, antiAlias);
        }
        drawTarget.unlock();
    }

    public static function drawEllipse(?drawTarget:GraphicObject, centerX:Float, centerY:Float, a:Float, b:Float, color:ColorObject, antiAlias:Bool=false)
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

    public static function drawPolygon(?drawTarget:GraphicObject, points:Array<Array<Float>>, color:ColorObject, lineWidth:Int=1, antiAlias:Bool=false)
    {
        if(drawTarget == null)
        {
            drawTarget = Screen.getDrawTarget();
        }
        drawTarget.lock();
        

        if(lineWidth > 0){
            var lastX:Float = points[points.length-1][0];
            var lastY:Float = points[points.length-1][1];

            for(i in 0...points.length)
            {
                var x:Float = points[i][0];
                var y:Float = points[i][1];
                if (antiAlias) 
                {   
                    drawAALine(drawTarget, lastX, lastY, x, y, color);
                }
                else if(lineWidth > 0)
                {
                    drawSolidLine(drawTarget, lastX, lastY, x, y, color);
                }

                lastX = x;
                lastY = y;
            }
        }
        else
        {
            var minX:Int = m.floor(points[0][0]);
            var minY:Int = m.floor(points[0][1]);
            var maxX:Int = m.ceil(points[0][0]);
            var maxY:Int = m.ceil(points[0][1]);
            
            var lastX:Float = points[points.length-1][0];
            var lastY:Float = points[points.length-1][1];

            for(i in 0...points.length)
            {
                var x:Float = points[i][0];
                var y:Float = points[i][1];
                if (antiAlias) 
                {   
                    drawAALine(drawTarget, m.round(lastX), m.round(lastY), m.round(x), m.round(y), color);
                }

                lastX = x;
                lastY = y;

                minX = m.floor(m.min(minX, m.floor(x)));
                minY = m.floor(m.min(minY, m.floor(y)));
                maxX = m.ceil(m.max(maxX, m.ceil(x)));
                maxY = m.ceil(m.max(maxY, m.ceil(y)));
            }
            
            var xSize:Int = maxX-minX+1;
            var ySize:Int = maxY-minY+1;

            var b:Array<Array<Int>> = [];
            for(i in 0...ySize)
            {
                var row:Array<Int> = [];
                for(j in 0...xSize)
                {
                    row.push(0);
                }
                b.push(row);
            }

            // trace(xSize + ", " + ySize);
            // trace(minX + ", " + minY);
            // trace(maxX + ", " + maxY);

            var lastX:Int = m.round(points[points.length-1][0]);
            var lastY:Int = m.round(points[points.length-1][1]);

            for(i in 0...points.length)
            {
                var x0:Int = m.round(points[i][0]);
                var y0:Int = m.round(points[i][1]);

                // trace(x0 + ", " + y0 + ", " + lastX + ", " + lastY);

                var startX:Int;
                var startY:Int;

                var endX:Int;
                var endY:Int;

                if(lastX < x0)
                {
                    startX = lastX-minX;
                    startY = lastY-minY;
                    endX = x0-minX;
                    endY = y0-minY;
                }
                else
                {
                    startX = x0-minX;
                    startY = y0-minY;
                    endX = lastX-minX;
                    endY = lastY-minY;
                }

                lastX = x0;
                lastY = y0;

                var dx:Int = endX - startX;
                var dy:Int = endY - startY;

                if(dx != 0)
                {
                    var slope:Float = dy/dx;

                    // trace(startX + ", " + endX + ", " + startY + ", " + endY + ", " + dx + ", " + dy + ", " + slope);

                    for(x in startX...endX)
                    {
                        var y:Float = startY+slope*(x-startX);
                        // trace(x + ", " + y);
                        b[m.floor(y)][x]++;
                    }
                }
            }
            for(x in 0...xSize)
            {
                var draw:Int = 0;
                for(y in 0...ySize)
                {
                    draw = (draw + b[y][x]) % 2;
                    if(b[y][x]==0)
                    {
                        b[y][x] = draw;
                    }
                    else
                    {
                        if(antiAlias){
                            b[y][x] = (b[y][x] + draw)%2;
                        }
                    }

                }
            }
            for(i in 0...xSize)
            {
                for(j in 0...ySize)
                {
                    if(b[j][i] > 0)
                    {
                        var x:Int = minX + i;
                        var y:Int = minY + j;

                        drawTarget.drawPixel(x,y,color);
                    }
                }
            }
        }

        drawTarget.unlock();
    }
}