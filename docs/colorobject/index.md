---
layout: default
title: ColorObject
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
public var r:Float;
public var g:Float;
public var b:Float;
public var a:Float;
public var alpha(get,never):Bool;
{% endhighlight %}
<a name="functions"></a>

###Public functions:

{% highlight hx %}
public function new(r:Float,g:Float,b:Float,a:Float = 1)
public function new(?audioPath:String) 
public function load(audioPath:String)
public function play(?newPosition:Float, ?newVolume:Float, ?newLoop:Bool, ?newPan:Float):Void
public function stop():Void
{% endhighlight %}