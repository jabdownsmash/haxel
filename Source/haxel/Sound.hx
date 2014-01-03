package haxel;

import flash.events.Event;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import openfl.Assets;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//
//                                                                          //
//   Because of the nature of this project, please PLEASE test any change   //
//   on HTML5, Flash, AND native. Any changes made for compatibility or     //
//   optimization ABSOLUTELY NEED to be fully documented: reasons, effects  //
//   and changes made. -Aaron                                               //
//                                                                          //
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//


class Sound
{
    public var volume(get, set):Float;
    public var pan(get, set):Float;
    public var playing(default, null):Bool;
    public var position(get, set):Float;
    public var callbackFunction:Sound->Bool->Void;
    public var callbackBeforeEnd:Bool;
    public var callbackAfterEnd:Bool;
    public var loop:Bool;
    
    private var sound:Sound;
    private var soundChannel:SoundChannel;
    private var soundTransform:SoundTransform;
    
    public function new(?audioPath:String) 
    {
        soundTransform = new SoundTransform();
        if(audioPath != null)
        {
            load(audioPath);
        }
        loop = false;
        callbackBeforeEnd = false;
        callbackAfterEnd = false;
        // sound = new Sound(); ??
        // should implement lower level sound functions eventually
    }
    
    public function load(audioPath:String)
    {
        sound = Assets.getSound(audioPath);
    }
    
    public function play(restart:Bool = false, ?newVolume:Float, ?newLoop:Bool, ?newPan:Float):Void
    {
        if(newVolume != null)
            soundTransform.volume = newVolume;
        if(newPan != null)
            soundTransform.pan = newPan;
        if(newLoop != null)
            loop = newLoop;
        playing = true;
        if(restart = true)
        {
            position = 0;
        }
        soundChannel = sound.play(position, 0, soundTransform);
        soundChannel.addEventListener(Event.SOUND_COMPLETE, soundComplete);
    }
    
    public function stop():Void
    {
        playing = false;
        if (soundChannel != null)
        {
            position = soundChannel.position;
            
            soundChannel.stop();
            soundChannel.removeEventListener(Event.SOUND_COMPLETE, soundComplete);
        }
    }
    
    private function soundComplete(e:Event):Void 
    {
        if(callbackBeforeEnd == true && callbackFunction != null)
        {
            callbackFunction(this,false);
        }
        if (loop)
        {
            play(true);
        }
        else
        {
            stop();
        }
        if(callbackAfterEnd == true && callbackFunction != null)
        {
            callbackFunction(this,true);
        }

    }
    
    private function get_volume():Float
    {
        return soundTransform.volume;
    }

    public function set_volume(volume:Float):Float
    {
        return soundTransform.volume = volume;
    }
    
    private function get_pan():Float
    {
        return soundTransform.pan;
    }

    public function set_pan(newPan:Float):Float
    {
        return soundTransform.pan = newPan;
    }
}