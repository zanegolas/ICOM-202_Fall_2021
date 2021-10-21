// Author: Zane Golas
// Date: September 17, 2021

<<< "Zane Golas - Assignment 1 (Hello ChucK!)" >>>;

// sound network
SinOsc s => dac;
SqrOsc lead => dac;

//init lead parameters
0.1 => float leadGain;
440 => float leadFreq;

// initialize and set note value variables for 128 bpm in ms
1875 => float whole;
whole/2 => float half;
whole/4 => float qurtr;
whole/8 => float eghth;
whole/16 => float sxtnt;

// init drum immutable parameters
0.5 => float drumGain;
300 => float drumFreq;
// low note of the kick in hz
40 => float drumNote;

// init instrument variables
drumGain => float gain;
drumFreq => float freq;
leadGain => float lGain;
leadFreq => float lFreq;
lFreq => lead.freq;

//init time count vars
0 => int drumTime;
0 => int leadTime;
0 => int leadNoteCount;
0 => int globalTime;


// loops instrument elements until 30 seconds have elapsed
while ( globalTime <= 30000 )
{
    //for loop counting up var t in ms to quarter note value
    if (drumTime <= qurtr)
    {
       gain - ( gain /  ( qurtr - ( drumTime + sxtnt) ) ) => gain;
       //hyperbolic slope of SinOsc s frequency 
       freq / (drumTime + 1) + drumNote => freq;
       //assign variables to SinOsc s
       gain => s.gain;
       freq => s.freq;
       drumTime++;
    }
    // reset drum parameters
    else
    {
        drumGain => gain;
        drumFreq => freq;
        0 => drumTime;
    }
    // lead gain envelope
    if (leadTime <= eghth )
    {
        lGain - leadGain / eghth => lGain;
        lGain => lead.gain;
        lFreq => lead.freq;
        leadTime++;
    }
    // reset lead parameters after note played
    else
    {
        leadGain => lGain;
        0 => leadTime;
        lFreq * .25 => lFreq;
        leadNoteCount++;
    }
    // move to next step in lead sequence
    if ( leadNoteCount > 4 )
    {
        leadFreq => lFreq;
        leadFreq * 1.25 => leadFreq;
        0 => leadNoteCount;
    }
        

// advance by 1 ms in track
1::ms => now;
// increase global time value by 1
globalTime++;
}   
    