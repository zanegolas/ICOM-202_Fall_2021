<<< "STK by Zane Golas" >>>;
////////////////////////////////////////////////////SETUP///////////////////////////////////////////////////////////////////////////

//sound chain
Gain master => dac;
SndBuf kick => master;
SndBuf loclick => Echo delayLead => master;
SndBuf hiclick => NRev verb => Pan2 clickPan => master;
Bowed swell => verb => master;
Bowed augment => delayLead => verb => master;

//set group gain levels
.9 => master.gain;

//set fx params
.05 => verb.mix;
351::ms => delayLead.delay;
702::ms => delayLead.max; 
.10 => delayLead.mix;

//drum gain
.5 => hiclick.gain;
1.0 => loclick.gain;

//time tracking
0 => int beat;
0 => int bar;
0 => int phrase;

//load sounds
load("kick_04", kick);
load("click_01", loclick);
load("click_02", hiclick);

<<< "inital setup complete" >>>;

/////////////////////////////////////////////////SEQUENCES////////////////////////////////////////////////////////////////////////////

//kick
[1,0,0,0,1,0,0,1,0,0,1,0,0,0,1,0] @=> int kickPattern1[];
[1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,1] @=> int kickPattern2[];

//loclick
[0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0] @=> int loclickPattern1[];
[0,0,0,0,1,0,0,0,0,0,0,0,1,0,1,1] @=> int loclickPattern2[];

//hiclick
[0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0] @=> int hiclickPattern1[];
[0,0,1,1,0,0,1,1,0,0,1,1,0,1,1,1] @=> int hiclickPattern2[];

//melody
[57,57,57,57,57,57,57,57] @=> int rootNote[];

<<< "sequences loaded" >>>;

////////////////////////////////////////////////MAIN PROGRAM/////////////////////////////////////////////////////////////////////////////////

for (0 => int count; count < 256; count++)
{
    count % 16 => beat;
    //play instruments
    if (phrase == 0)
    {
        playDrums(kickPattern1, loclickPattern1, hiclickPattern1);
    }
    
    else
    {
        playDrums(kickPattern1, loclickPattern2, hiclickPattern2);
    }
    
    if ((bar == 4) || (bar == 7)){
        playQuick();
    }
    
    else{
        playSwell();
    }

    //keep track of time
    if (beat == 0)
    {
        bar++;
        if (bar >= rootNote.cap())
        {
            0 => bar;
            phrase++;
        }
    }
    
    
    
        
    
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

fun void playSwell()
{
    //this function plays a string swell on the twelve count of each 16 step sequence
    if (beat == 12){
        Std.mtof(rootNote[bar]) => swell.freq;
        swell.noteOn(1.0);
    }
    
    if (beat == 0){
        swell.noteOff(1.0);
        augment.noteOff(1.0);
    }
}

fun void playQuick()
{
    //this function plays an eight note note pattern with two string ugens for pattern variation
    if (beat == 12){
        Std.mtof(61) => swell.freq;
        Std.mtof(56) => augment.freq;
        swell.noteOn(1.0);
    }
    if (beat == 14){
        swell.noteOff(1.0);
        augment.noteOn(1.0);
    }
    if (beat == 0){
        swell.noteOff(1.0);
        augment.noteOff(1.0);
    }
}
    


fun void playDrums (int firstPattern[], int secondPattern[], int thirdPattern[])
{
    //this function reads pattern arrays for kick, loclick, and hiclick
    if (firstPattern[beat])
    {
        0 => kick.pos;
    }   
    if (secondPattern[beat])
    {
        0 => loclick.pos;
    }
    if (thirdPattern[beat])
    {
        0 => hiclick.pos;
        Math.random2f(-1.0, 1.0) => clickPan.pan;
    }
}

//////////////////////////////////////////////////////////END OF LINE////////////////////////////////////////////////////////
