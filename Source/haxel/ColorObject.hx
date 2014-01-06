
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
    public var alpha(get,never):Bool;
    public function get_alpha():Bool
    {
        return a == 1;
    }

    public function new(r:Float,g:Float,b:Float,a:Float = 1)
    {
        this.r = r;
        this.g = g;
        this.b = b;
        this.a = a;
    }

    public function getUInt():UInt
    {
        return Std.int(r*255) * 256 * 256 + Std.int(g*255) * 256 + Std.int(b*255);
    }

    public function getAlphaUInt():UInt
    {
        return Std.int(a*255) * 256 * 256 * 256 +  getUInt();
    }
}
