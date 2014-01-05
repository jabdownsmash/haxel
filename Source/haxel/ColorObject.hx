
package haxel;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//
//                                                                          //
//   Because of the nature of this project, please PLEASE test any change   //
//   on HTML5, Flash, AND native. Any changes made for compatibility or     //
//   optimization ABSOLUTELY NEED to be fully documented: reasons, effects  //
//   and changes made. -Aaron                                               //
//                                                                          //
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//

class ColorObject
{

    public var r:Float;
    public var g:Float;
    public var b:Float;
    public var a:Float;
    public var alpha:Bool;

    public function new(r:Float,g:Float,b:Float,?a:Float)
    {
        this.r = r;
        this.g = g;
        this.b = b;
        if(a != null)
        {
            alpha = true;
            this.a = a;
        }
        else
        {
            alpha = false;
        }
    }

    public function getUInt():UInt
    {
        var color:UInt = Std.int(r*255) * 256 * 256 + Std.int(g*255) * 256 + Std.int(b*255);
        if(alpha)
        {
            color = Std.int(a*255) * 256 * 256 * 256 + color;
        }
        return color;
    }
}
