###What is haxel?
Haxel aims to be a Haxe toolset that allows easy access to graphics, sound, and input, similar to what pygame is for Python. Haxel is built to be both powerful and simple, with a strong desire for clarity.

###What platforms does haxel support? 
Officially, haxel supports Linux, Windows, and OSX, along with Flash, iOS, and Android. The support for each of these platforms will be ensured with every update, and platform-specific optimizations are made behind the scenes so that the haxel API is completely platform-blind.

###What do you mean, clarity? Isn't that a bit lofty?
The limited scope of haxel allows for a very tightly integrated API. For example, all haxel classes are either objects or static classes: object classes are guaranteed to not have any static member, and static classes are never instanced. This is communicated in the classes' names, listed below.

###What exactly can haxel do?
Take a look at the docs(which are still being made): 
 - Graphics
  - ColorObject
  - GraphicObject
  - Primitives
  - Screen
  - Text
 - Sound
  - AudioObject
 - Input
  - KeyboardInput
  - Key
  - MouseInput
 - Utils
  - Core
  - Time
  - Utils

###What do I need to do to get started?
Simply make your Main extend haxel.Core, and within new(), call super() and set some callback functions for haxel.Time to use. No inits(), no buffer creation, no touchy settings. All parts of haxel are taken care of by haxel.Core. Skimming through the docs for haxel.Core, haxel.Time, and haxel.Screen will give you all you need to get started with haxel.

###How do I install haxel?
No clue.
