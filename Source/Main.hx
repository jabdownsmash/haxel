
import flash.display.Bitmap;
import flash.display.BitmapData;
import haxel.Core;
import haxel.ColorObject;
import haxel.Screen;
import haxel.Primitives;
import haxel.Text;
// import haxel.AudioObject;
import haxel.KeyboardInput;
import haxel.MouseInput;
import haxel.Time;
import openfl.Assets;

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
    }

    var init:Bool = false;
    var image:BitmapData;

    public function timerDraw(times:Float)
    {
        // trace(MouseInput.mouseX);

        if(!init)
        {
            image = Assets.getBitmapData("assets/openfl.png");
            Screen.scaleScreen(1);
            init = true;
        }
        // Screen.renderMode = SCREEN_RENDER;
        Screen.draw(image,320,190,image.rect.width/2,image.rect.height/2,.7,.8,Math.PI/2);
        // Primitives.drawLine(60,80,80,150,0xFFFFFF);
        Primitives.drawLine(10,15,60,70,new ColorObject(1,1,1), true);
        // Primitives.drawCircle(151,101,100,0xFFFFFF, true, 0);
        Primitives.drawCircle(101,101,100,new ColorObject(1,1,1), true, 1);
        Text.draw("hi pppl",30,40, new ColorObject(1,1,1),70);
        //Primitives.drawCircle(250,200,100,0xFFFFFF, 0);
        // Primitives.drawPolygon([[200, 200,],[200, 300],[300,300]], 0xFFFFFF);
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

    public function timerTest(timeBetweenCalls:Float)
    {
    }
}