---
layout: default
title: KeyboardInput
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
public static var keyString:String = "";
public static var lastKey:Int;
{% endhighlight %}
<a name="functions"></a>

###Public functions:

{% highlight hx %}
public static function check(input:Int):Bool
public static function pressed(input:Int):Bool
public static function released(input:Int):Bool
public static function init()
public static function update()
{% endhighlight %}