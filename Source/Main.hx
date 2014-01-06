
import haxel.GraphicObject;
import haxel.Core;
import haxel.ColorObject;
import haxel.Screen;
import haxel.Primitives;
import haxel.Text;
// import haxel.AudioObject;
import haxel.KeyboardInput;
import haxel.Key;
import haxel.MouseInput;
import haxel.Time;
import haxel.Utils;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//
//                                                                          //
//   Because of the nature of this project, please PLEASE test any change   //
//   on HTML5, Flash, AND native. Any changes made for compatibility or     //
//   optimization ABSOLUTELY NEED to be fully documented: reasons, effects  //
//   and changes made. -Aaron                                               //
//                                                                          //
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//

class Main extends Core
{
    public function new ()
    {
        super();
        Time.callbackFunction = timerTest;
        Time.postCallbackFunction = timerDraw;
        points = new Array<Array<Float>>();
        points.push([0,0]);

    }

    var init:Bool = false;
    var antiAlias:Bool = true;
    var image:GraphicObject;

    var points:Array<Array<Float>>;

    public function timerDraw(times:Float)
    {
        // trace(MouseInput.mouseX);

        if(!init)
        {
            // image = Utils.loadImage("assets/openfl.png");
            // Screen.scaleScreen(1);
            init = true;
            // Screen.renderMode = SCREEN_RENDER;
            // Screen.draw(image,320,190,image.width/2,image.height/2,.7,.8,Math.PI/2);
            // Primitives.drawLine(60,80,80,150,0xFFFFFF);
            // Primitives.drawLine(10,15,60,70,new ColorObject(1,1,1), true);
            // Primitives.drawLine(20,200,20,250,new ColorObject(1,1,1), false);
            // Primitives.drawCircle(151,101,100,0xFFFFFF, true, 0);
            // Primitives.drawCircle(101,101,100,new ColorObject(1,1,1), true, 1);
            // Primitives.drawPolygon([[20, 250,],[20, 350],[120,350],[70,300],[120,250]], new ColorObject(1,1,1), 0, false);
            // Text.draw("hi pppl",30,40, new ColorObject(1,1,1),70);
            //Primitives.drawCircle(250,200,100,0xFFFFFF, 0);
            // Primitives.drawPolygon([[200, 200,],[200, 300],[300,300]], new ColorObject(1, 1, 1), 1, true);
            //Primitives.drawEllipse(200,200,100,50,0xFFFFFF);
            // ScreenUtils.resetScreenTransform();

            // var snd = new Audio("assets/test.wav");
            // snd.pan = 1;
            // snd.play();
            // snd.volume = .4;
            // snd.position = 600;
            // snd.stop();
            // trace(snd.position);
            // snd.play();
            //none of this seems to work for html5 QQQQQQQQQ
            Screen.flip();
            Screen.clear(Screen.fillColor);
        }
        Primitives.drawCircle(101,101,100,new ColorObject(1,1,1), antiAlias, 1);
        Primitives.drawPolygon(points, new ColorObject(1, 1, 1), 0, antiAlias);
        Text.draw(""+times,30,40, new ColorObject(1,1,1),20);
        Screen.flip();
        Screen.clear(new ColorObject(0,0,0));
    }

    public function timerTest(timeBetweenCalls:Float)
    {

        if(MouseInput.mousePressed)
        {
            if(points.length == 1 && points[0][0] == 0 && points[0][1] == 0){
                points[0] = [MouseInput.mouseX, MouseInput.mouseY];
            }
            else
            {   
                points.push([MouseInput.mouseX, MouseInput.mouseY]);
            }
        }
        if(KeyboardInput.pressed(Key.SPACE))
        {
            points = new Array<Array<Float>>();
            points.push([0,0]);
        }
        if(KeyboardInput.pressed(Key.A)){
            antiAlias = !antiAlias;
        }
    }
}