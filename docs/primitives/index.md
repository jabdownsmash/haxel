---
layout: default
title: Primitives
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

{% endhighlight %}
<a name="functions"></a>

###Public functions:

{% highlight hx %}
public static function drawCircle(?drawTarget:GraphicObject, centerX:Float, centerY:Float, radius:Float, color:ColorObject, antiAlias:Bool=false, lineWidth:Float=1)
public static function drawEllipse(?drawTarget:GraphicObject, centerX:Float, centerY:Float, a:Float, b:Float, color:ColorObject, antiAlias:Bool=false)
public static function drawPolygon(?drawTarget:GraphicObject, points:Array<Array<Float>>, color:ColorObject, lineWidth:Int=1, antiAlias:Bool=false)
public static function drawLine(?drawTarget:GraphicObject, startX:Float, startY:Float, endX:Float, endY:Float, color:ColorObject, lineWidth:Float=1, antiAlias:Bool=false)
{% endhighlight %}