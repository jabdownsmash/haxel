---
layout: default
title: docs
name: docs
sidebar_tags:
  - display: 'General'
    link: "#general"
  - display: 'Graphics'
    link: "#graphics"
  - display: 'Sound'
    link: "#sound"
  - display: 'Input'
    link: "#input"
  - display: Utils
    link: "#utils"
---

<a name="general"></a>
Welcome to the main docs page! Here you'll find a brief overview of what each class has to offer.

###General
Haxel is built to be clear and powerful. We wanted to put as much flexibility into haxel while still making the API make sense.

####Classes
Haxel's classes are one of two types: static classes or object classes. If the class ends in 'Object', it is an object class. All classes can be imported from the package haxel:

{% highlight hx %}
import haxel.GraphicObject;
import haxel.Screen;
import haxel.Text;
import haxel.ColorObject;
{% endhighlight %}

Object classes are instanced, meaning to utilize them, you have to make a variable instance of them:

{% highlight hx %}
var image = new GraphicObject()
{% endhighlight %}

Static classes are just that, static, so you use them by their name:

<a name="graphics"></a>
{% highlight hx %}
if(KeyboardInput.check(Key.SPACE))
{
    trace('Space key pressed!')
}
{% endhighlight %}

###Graphics
In terms of graphics, the main classes to worry about are Screen and GraphicObject. Drawing to the screen is as easy as using Screen.draw() and calling Screen.flip().

ColorObjects are strictly used for representing colors in haxel.

<a name="sound"></a>
Available classes:

 - [ColorObject]({{ site.baseurl }}/docs/colorobject)
 - [GraphicObject]({{ site.baseurl }}/docs/graphicobject)
 - [Primitives]({{ site.baseurl }}/docs/primitives)
 - [Screen]({{ site.baseurl }}/docs/screen)
 - [Text]({{ site.baseurl }}/docs/text)

###Sound
<a name="input"></a>
The only sound class in haxel is AudioObject, but that is only a testament to how simple it is. Note that due to OpenFL issues, sound manipulation does not work in the HTML5 target.

Available classes:

 - [AudioObject]({{ site.baseurl }}/docs/audioobject)

###Input
Input in haxel is very straightforward: it is strictly a state checking system. KeyboardInput holds functions to check key states, using the items in Key to access the key indices. MouseInput is a very simple class to check the mouse button states and the mouse position.
<a name="utils"></a>

Available classes:

 - [KeyboardInput]({{ site.baseurl }}/docs/keyboardinput)
 - [Key]({{ site.baseurl }}/docs/key)
 - [MouseInput]({{ site.baseurl }}/docs/mouseinput)

###Utils
In haxel, Core and Time are the heart of the operation. Your Main() must extend Core for haxel to work, and setting callback functions for the Time() class is the only way to get haxel to do anything.

The Utils class holds some miscellaneous functions that don't fit in any of the others, but don't deserve their own class.

Available Classes:

 - [Core]({{ site.baseurl }}/docs/core)
 - [Time]({{ site.baseurl }}/docs/time)
 - [Utils]({{ site.baseurl }}/docs/utils)