
package haxel;

import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import openfl.Assets;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//
//                                                                          //
//   Because of the nature of this project, please PLEASE test any change   //
//   on HTML5, Flash, AND native. Any changes made for compatibility or     //
//   optimization ABSOLUTELY NEED to be fully documented: reasons, effects  //
//   and changes made. -Aaron                                               //
//                                                                          //
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//

class Align
{
    public static inline var Left = 'left';
    public static inline var LeftRight = 'right';
    public static inline var Center = 'center';
    public static inline var Justify = 'justify';
}

class Text
{
    
    public static function draw(?target:GraphicObject, text:String, x:Float, y:Float, font:String = "assets/slkscr.ttf", color:ColorObject, size:Float = 20, align:String = Align.Left, wordWrap:Bool = false, ?width:Float, ?height:Float, ?leading:Int)
    {
        if(target == null)
        {
            target = Screen.getDrawTarget();
        }
        var textField = new TextField();
        
        var fontObj = Assets.getFont(font);
        var format = new TextFormat(fontObj.fontName, size, color.getUInt());
        if(align == Align.Left)
        {
            format.align = TextFormatAlign.LEFT;
        }
        if(align == Align.Justify)
        {
            format.align = TextFormatAlign.JUSTIFY;
        }
        if(align == Align.Center)
        {
            format.align = TextFormatAlign.CENTER;
        }
        if(align == Align.Justify)
        {
            format.align = TextFormatAlign.JUSTIFY;
        }
        if(leading != null)
        {
            format.leading = leading;
        }
        
        textField.text = text;
        textField.embedFonts = true;
        textField.setTextFormat(format);
        // textField.autoSize = TextFieldAutoSize.CENTER;
        textField.selectable = false;

        textField.wordWrap = wordWrap;
        if(width != null)
        {
            textField.width = width;
        }
        else
        {
            textField.width = Std.int(textField.textWidth + 4);
        }
        if(height != null)
        {
            textField.height = height;
        }
        else
        {
            textField.height = Std.int(textField.textHeight + 4);
        }

        target.draw(textField);
    }
}
