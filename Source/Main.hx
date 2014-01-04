
import flash.display.Bitmap;
import flash.display.BitmapData;
import haxel.Core;
import haxel.Screen;
import haxel.Primitives;
import haxel.Audio;
import haxel.Input;
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
        var image = Assets.getBitmapData("assets/openfl.png");
        Screen.draw(image,320,190,image.rect.width/2,image.rect.height/2,.7,.8,Math.PI/2);
        Screen.scaleScreen(3);
        Primitives.drawLine(2,3,60,80,0xFFFFFF);
        Primitives.drawCircle(90,80,100,0xFFFFFF);
        Screen.resetScreenTransform();
        Screen.flip();

        var snd = new Audio("assets/test.wav");
        snd.pan = 1;
        snd.play();
        snd.volume = .4;
        snd.position = 600;
        snd.stop();
        // trace(snd.position);
        // snd.play();
        Time.callbackFunction = timerTest;
    }

    public function timerTest(timeBetweenCalls:Float)
    {
        trace(Input.mouseX);
    }
}