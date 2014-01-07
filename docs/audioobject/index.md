---
layout: default
title: AudioObject
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
public var volume(get, set):Float;
public var pan(get, set):Float;
public var playing(default, null):Bool;
public var position(get, set):Float;
public var callbackFunction:AudioObject->Bool->Void;
public var callbackBeforeEnd:Bool;
public var callbackAfterEnd:Bool;
public var loop:Bool;
{% endhighlight %}
<a name="functions"></a>

###Public functions:

{% highlight hx %}
public function new(?audioPath:String) 
public function load(audioPath:String)
public function play(?newPosition:Float, ?newVolume:Float, ?newLoop:Bool, ?newPan:Float):Void
public function stop():Void
{% endhighlight %}