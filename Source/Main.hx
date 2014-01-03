
import flash.display.Bitmap;
import flash.display.BitmapData;
import haxel.Core;
import haxel.ScreenUtils;
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
        var image = Assets.getBitmapData ("assets/openfl.png");
        Core.draw(image,320,190,image.rect.width/2,image.rect.height/2,.7,.8,Math.PI/2);
        ScreenUtils.scaleScreen(.2);
        // ScreenUtils.resetScreenTransform();
        Core.flip();

        var snd = new Audio("assets/test.wav");
        snd.pan = 1;
        snd.play();
        snd.volume = .4;
        snd.position = 600;
        snd.stop();
        trace(snd.position);
        snd.play();
        //none of this seems to work for html5 QQQQQQQQQ
        Input.enable();
        Time.init();
        Time.callbackFunction = thing;
    }

    public function thing(thingy:Float)
    {
        trace(thingy);
    }
}