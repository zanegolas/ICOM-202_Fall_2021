//flute.ck
// sound chain
SawOsc lead => ADSR solo => JCRev rev => Gain master => dac;
solo => Delay d  => d => rev; 

//sound params
0.1 => rev.mix;
0.8::second => d.max => d.delay;
0.5 => d.gain;
0.6 => master.gain;

//scale data
[41, 43, 48, 50, 51, 52, 60, 63] @=> int scale[];


while ( true )
{
    (Math.random2(1,5) * 0.2)::second => now;
    
    //play
    if (Math.random2(0,3) > 1)
    {
        Math.random2(0,scale.cap()-1) => int note;
        Math.mtof(24+ scale[note]) => lead.freq;
        1 => solo.keyOn;
    }
    
    else
    {
        0 => solo.keyOff;
    }
    
}
        