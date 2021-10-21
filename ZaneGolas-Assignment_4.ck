<<< "Function Junction by Zane Golas" >>>;
////////////////////////////////////////////////////SETUP///////////////////////////////////////////////////////////////////////////

//sound chain
TriOsc chord[3];
Gain master => dac;
Gain chordGain => master;
SndBuf kick => master;
SndBuf snare => master;
SndBuf hihat => NRev verb => master;
SawOsc sawLead => ADSR lead => LPF filter => Pan2 leadPan => Echo delayLead => verb => master;

//set group gain levels
.5 => master.gain;
.6 => chordGain.gain;

//use array to chuck unit generator to master
for ( 0 => int i; i < chord.cap(); i++ )
{
    chord[i] => chordGain;
    1.0/chord.cap() => chord[i].gain;
}

//set synth params
lead.set(10::ms, 50::ms, .5, 5::ms);
.10 => verb.mix;
351::ms => delayLead.delay;
702::ms => delayLead.max; 
.10 => delayLead.mix;

//drum gain
.5 => hihat.gain;
1.0 => snare.gain;

//time tracking
0 => int beat;
0 => int bar;
0 => int phrase;

//load sounds
load("kick_02", kick);
load("snare_01", snare);
load("hihat_02", hihat);

<<< "inital setup complete" >>>;

/////////////////////////////////////////////////SEQUENCES////////////////////////////////////////////////////////////////////////////

//kick
[1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0] @=> int kickPattern1[];
[1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,1] @=> int kickPattern2[];

//snare
[0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0] @=> int snarePattern1[];
[0,0,0,0,1,0,0,0,0,0,0,0,1,0,1,1] @=> int snarePattern2[];

//hihat
[0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0] @=> int hiHatPattern1[];
[0,0,1,1,0,0,1,1,0,0,1,1,0,1,1,1] @=> int hiHatPattern2[];

//melody
[57,50,55,52,57,50,52,54] @=> int rootNote[];
["minor","major","minor","major","minor","major","minor","major"] @=> string chordQuality[];

<<< "sequences loaded" >>>;

////////////////////////////////////////////////MAIN PROGRAM/////////////////////////////////////////////////////////////////////////////////

for (0 => int count; count < 256; count++)
{
    count % 16 => beat;
    
    if (phrase == 0)
    {
        playDrums(kickPattern1, snarePattern1, hiHatPattern1);
    }
    
    else
    {
        playDrums(kickPattern1, snarePattern2, hiHatPattern2);
    }

    
    if (beat == 0)
    {
        
        playChord(rootNote[bar],chordQuality[bar]);
        bar++;
        if (bar >= rootNote.cap())
        {
            0 => bar;
            phrase++;
        }
    }
    playLead();
    
        
    
    117::ms => now;
}

<<< "main program complete" >>>;

//////////////////////////////////////////////////////FUNCTIONS//////////////////////////////////////////////////////////////////////////
fun void load( string soundName, SndBuf playerName )
{
    //WARNING: this function is only for ICOM-202 samples
    //function loads a single sound file from the ICOM-202 project folder based on only the normal file name to a SndBuf
    //sets play head to the end of the file
    
    me.dir() + "audio/" + soundName + ".wav" => playerName.read; //filepath and .wav added to soundName then read by specified SndBuf
    playerName.samples() => playerName.pos; //set playhead
    <<< soundName + " loaded in to " + playerName >>>; //print status of load      
}


fun void playChord( int root, string quality)
{
    //function will make major or minor chords
    //root
    Std.mtof(root) => chord[0].freq;
    //third
    if( quality == "major" )
    {
        Std.mtof(root+4) => chord[1].freq;
    }
    else if( quality == "minor" )
    {
        Std.mtof(root+3) => chord[1].freq;
    }
    else
    {
        <<< "Must specify 'major' or 'minor'" >>>;
    }
    //fifth
    Std.mtof(root+7) => chord[2].freq;
    
}

fun void playLead()
{
    //this function controls sawlead ugen and picks a note at random from the currently playing chord to arpeggiate
    //note selection
    Math.random2(0,2) => int note;
    chord[note].freq() * 2 => sawLead.freq;
    //pitch track the low pass filter
    sawLead.freq() * 3 => filter.freq;
    //send key on message to adsr
    1 => lead.keyOn;
    //randomize gain and pan
    Math.random2f(.6, .8) => sawLead.gain;
    Math.random2f(-.4, .4) => leadPan.pan;
}

fun void playDrums (int kickPattern[], int snarePattern[], int hiHatPattern[])
{
    //this function reads pattern arrays for kick, snare, and hihat
    if (kickPattern[beat])
    {
        0 => kick.pos;
    }   
    if (snarePattern[beat])
    {
        0 => snare.pos;
    }
    if (hiHatPattern[beat])
    {
        0 => hihat.pos;
    }
}

//////////////////////////////////////////////////////////END OF LINE////////////////////////////////////////////////////////
