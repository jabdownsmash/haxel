---
layout: default
title: Utils
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
public static function loadImage(path:String):GraphicObject
public static function generateTransformMatrix(translateX:Float,translateY:Float, centerX:Float = 0, centerY:Float = 0, xScale:Float = 1, yScale:Float = 1, rotation:Float = 0):Matrix
public static function getColorFromInt(intColor:UInt):ColorObject
public static function getAlphaColorFromInt(intColor:UInt):ColorObject
public static function blend(targetColor:ColorObject,newColor:ColorObject):ColorObject
{% endhighlight %}