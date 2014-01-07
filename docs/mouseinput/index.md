---
layout: default
title: MouseInput
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
public static var mouseDown:Bool;
public static var mouseUp:Bool;
public static var mousePressed:Bool;
public static var mouseReleased:Bool;

#if !js 
public static var rightMouseDown:Bool;
public static var rightMouseUp:Bool;
public static var rightMousePressed:Bool;
public static var rightMouseReleased:Bool;
public static var middleMouseDown:Bool;
public static var middleMouseUp:Bool;
public static var middleMousePressed:Bool;
public static var middleMouseReleased:Bool;
#end
    public static var mouseY(get_mouseY, never):Float;
    public static var mouseX(get_mouseX, never):Float;
    public static var mouseWheelDelta(get_mouseWheelDelta, never):Int;
    public static var mouseWheel:Bool;
{% endhighlight %}
<a name="functions"></a>

###Public functions:

{% highlight hx %}
    public static function init()
    public static function update()
{% endhighlight %}