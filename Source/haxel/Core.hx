
package haxel;

import flash.display.Sprite;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//
//                                                                          //
//   Because of the nature of this project, please PLEASE test any change   //
//   on HTML5, Flash, AND native. Any changes made for compatibility or     //
//   optimization ABSOLUTELY NEED to be fully documented: reasons, effects  //
//   and changes made. -Aaron                                               //
//                                                                          //
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//


class Core extends Sprite
{
    public static var instance:Core;

    public function new()
    {
        super();
        instance = this;

        Screen.init();
        KeyboardInput.init();
        MouseInput.init();
        // TouchInput.init();
        Time.init();
    }

    public static function updateFrame()
    {
        KeyboardInput.update();
        MouseInput.update();
        // TouchInput.update();
    }

    public static function updatePostFrame()
    {

    }
}
