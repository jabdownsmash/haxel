---
layout: default
title: Screen
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
public static var renderMode:RenderMode;
public static var buffer:GraphicObject;
public static var screen:GraphicObject;
public static var fillColor:ColorObject;
{% endhighlight %}
<a name="functions"></a>

###Public functions:

{% highlight hx %}
public static function init()
public static function createBuffer()
public static function getDrawTarget():GraphicObject
public static function draw(image:Dynamic,x:Float,y:Float, centerX:Float = 0, centerY:Float = 0, xScale:Float = 1, yScale:Float = 1, rotation:Float = 0)
public static function flip()
public static function clear(color:ColorObject)
public static function resizeVirtualScreen(width:Float, height:Float, x:Float, y:Float)
public static function scaleScreen(scale:Float,centerX:Float = 0, centerY:Float = 0)
public static function scaleScreenX(scale:Float,centerX:Float = 0, centerY:Float = 0)
public static function scaleScreenY(scale:Float,centerX:Float = 0, centerY:Float = 0)
public static function rotateScreen(rotate:Float,centerX:Float = 0, centerY:Float = 0)
public static function translateScreen(x:Float,y:Float)
public static function getScreenTransformMatrix():Matrix
public static function setScreenTransformMatrix(matrix:Matrix)
public static function resetScreenTransform()
{% endhighlight %}