<<< "week 3 assignment for icom-202 by zane golas" >>>;

//sound chain
Gain master => dac;
SndBuf kick => master;
SndBuf snare => master;
SndBuf hihat => Pan2 hatPan => NRev verb => master;
SawOsc sawLead => ADSR lead => LPF filter => Echo delayLead => verb => master;

.5 => master.gain;

//file directory
me.dir() => string path;
<<< "project directory is " + path >>>;

//create arrays
string hatSamples[2];

//store melody
[57, 64, 62, 53, 57, 64, 77, 74] @=> int melodyArray[];
<<< "melody loaded" >>>;

//set synth params
lead.set(10::ms, 50::ms, .5, 5::ms);
.10 => verb.mix;
351::ms => delayLead.delay;
702::ms => delayLead.max; 
.10 => delayLead.mix;

//drum gain
.5 => hihat.gain;
1.0 => snare.gain;

//load file paths to array
path + "audio/hihat_02.wav" => hatSamples[0];
path + "audio/hihat_03.wav" => hatSamples[1];
<<< hatSamples.cap() + " hihat samples loaded to array" >>>;

//load single samples
path + "audio/kick_04.wav" => kick.read;
path + "audio/snare_01.wav" => snare.read;
hatSamples[0] => hihat.read;

<<< "percussion loaded" >>>;

//init play positions at end of samples
kick.samples() => kick.pos;
snare.samples() => snare.pos;
hihat.samples() => hihat.pos;

0 => int beat;
0 => int leadNote;

<<< "starting playback" >>>;

for (0 => int count; count < 256; count++)
{
     count % 16 => beat;
     //play kicks 
     if ((beat == 0) || (beat == 3) || (beat == 4) || (beat == 7) || (beat == 8) || (beat == 10) || (beat == 12) || (beat == 15))
     {
         0 => kick.pos;
     }
     
     if (beat % 4 == 0)
     {
         1.0 => kick.gain;
     }
     else
     {
         .7 => kick.gain;
     }
     //play snare on 2 and 4
     if ((beat == 4) || (beat == 12) || (beat > 13))
     {
         0 => snare.pos;
     }
     //open hat on the and, else closed hat
     if ((beat == 2) || (beat == 6) || (beat == 10) || (beat == 14))
     {
         hatSamples[1] => hihat.read;
     }
     else 
     {
         hatSamples[0] => hihat.read;
     }
     //play syncopated lead notes
     if (beat % 3 == 0)
     {
        1 => lead.keyOn;
        Math.random2f(.6, .8) => sawLead.gain;
     }
     else
     {
        1 => lead.keyOff;
     }
     
     //advance through notes in melody each bar
     if (beat == 0)
     {
         Std.mtof( melodyArray[leadNote] ) => sawLead.freq;
         Std.mtof( melodyArray[leadNote] ) * 3 => filter.freq;
         leadNote++;
         if (leadNote >= melodyArray.cap())
         {
             0 => leadNote;
         }
         
     }
     
     
     0 => hihat.pos;
     Math.random2f(-.4, .4) => hatPan.pan;
         
     
     
     
     
     117::ms => now;
     
 }
 
 <<< "goodbye, world!" >>>;
