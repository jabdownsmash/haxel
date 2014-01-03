
    //testing quake invsqrt

    // public function prepare() {
    //     var b = new flash.utils.ByteArray();
    //     b.length = 1024;
    //     flash.Memory.select(b);
    // }

    // public function invSqrt( x : Float ) : Float {
    //     var half = 0.5 * x;
    //     flash.Memory.setFloat(0,x);
    //     var i = flash.Memory.getI32(0);
    //     i = 0x5f3759df - (i>>1);
    //     flash.Memory.setI32(0,i);
    //     x = flash.Memory.getFloat(0);
    //     x = x * (1.5 - half*x*x);
    //     return x;
    // }

    //this is some magic that i want to hold on to
// var m = Math;
// for( p in array )
//      p.invDist = 1.0 / m.sqrt(p.x*p.x + p.y*p.y);
    //simply a bunch of calls to math.sqrt BUT
    //you hold the entire Math lib in memory apparently making it
    //62% faster
    //should keep this in mind for optimization

    public function draw(source:IBitmapDrawable, matrix:Matrix = null, colorTransform:flash.geom:ColorTransform = null, blendMode:String = null, clipRect:Rectangle = null, smoothing:Boolean = false):void
    blendMode = 'normal'
        
ColorTransform(redMultiplier:Number = 1.0, greenMultiplier:Number = 1.0, blueMultiplier:Number = 1.0, alphaMultiplier:Number = 1.0, redOffset:Number = 0, greenOffset:Number = 0, blueOffset:Number = 0, alphaOffset:Number = 0)