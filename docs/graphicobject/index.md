---
layout: default
title: GraphicObject
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
public var bitmapData:BitmapData;
public var width(get,never):Int;
public var height(get,never):Int;
{% endhighlight %}
<a name="functions"></a>

###Public functions:

{% highlight hx %}
public function new(width:Int = 1,height:Int = 1,alpha:Bool= true,?fillColor:ColorObject)
public function draw(image:Dynamic,?transformMatrix:Matrix,x:Float = 0,y:Float = 0, centerX:Float = 0, centerY:Float = 0, xScale:Float = 1, yScale:Float = 1, rotation:Float = 0)
public function clear(color:ColorObject)
public function getBitmap()
public function getBitmapData()
public function lock()
public function unlock()
public function setPixel(x:Int,y:Int,color:ColorObject)
public function getPixel(x:Int,y:Int):ColorObject
public function drawPixel(x:Int,y:Int,color:ColorObject)
{% endhighlight %}