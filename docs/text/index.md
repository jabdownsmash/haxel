---
layout: default
title: Text
name: docs
sidebar_tags:
  - display: 'Public members'
    link: "#members"
  - display: 'Public functions'
    link: "#functions"
---
<a name="members"></a>

###Public members:

{% highlight hx %}
class Align
{
    public static inline var Left = 'left';
    public static inline var LeftRight = 'right';
    public static inline var Center = 'center';
    public static inline var Justify = 'justify';
}
{% endhighlight %}
<a name="functions"></a>

###Public functions:

{% highlight hx %}
public static function draw(?target:GraphicObject, text:String, x:Float, y:Float, font:String = "assets/slkscr.ttf", color:ColorObject, size:Float = 20, align:String = Align.Left, wordWrap:Bool = false, ?width:Float, ?height:Float, ?leading:Int)
{% endhighlight %}