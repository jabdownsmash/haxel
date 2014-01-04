package haxel;

class Touch
{

    public var id(default, null):Int;
    public var x:Float;
    public var y:Float;
    public var pressed(default, null):Bool;

    public function new(x:Float, y:Float, id:Int)
    {
        this.x = x;
        this.y = y;
        this.id = id;
        this.pressed = true;
    }

    public function update()
    {
        pressed = false;
    }
}
