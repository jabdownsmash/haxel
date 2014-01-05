
package haxel;

import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import openfl.Assets;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//
//                                                                          //
//   Because of the nature of this project, please PLEASE test any change   //
//   on HTML5, Flash, AND native. Any changes made for compatibility or     //
//   optimization ABSOLUTELY NEED to be fully documented: reasons, effects  //
//   and changes made. -Aaron                                               //
//                                                                          //
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//

class Text
{
    
    private static inline var defaultFont:String = "assets/slkscr";
    
    public static function draw(text:String = "", font:FontObject, color:ColorObject, size:Float = 20, ?target:GraphicObject)
    {
        if(target == null)
        {
            target = Screen.getDrawTarget();
        }
        var _textField = new TextField();
        
        var _format = new TextFormat(defaultFont, size, color.getUInt());
        
        _textField.text = text;
        _textField.embedFonts = true;
        _textField.setTextFormat(_format);
        _textField.autoSize = TextFieldAutoSize.CENTER;

        target.draw(_textField);
    }
}
