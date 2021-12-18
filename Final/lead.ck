Bowed swell => NRev verb => dac;
Bowed augment => Echo delayLead => verb => dac;

int beat;

//set fx params
.05 => verb.mix;
351::ms => delayLead.delay;
702::ms => delayLead.max; 
.10 => delayLead.mix;

//connect to conductor
Conductor conductor;


while( true )
{
    
    //3 bar loop
    for( 0 => int count; count < 48; count++ )
    {
        count % 16 => beat;
        playSwell();
        conductor.playInst("1/16");
    }
    
    //1 bar loop
    for( 0 => beat; beat < 16; beat++ )
    {
        playQuick();
        conductor.playInst("1/16");
    }
}


////////////////////////////////////////FUNCTIONS//////////////////////////////////////////
fun void playSwell()
{
    //this function plays a string swell on the twelve count of each 16 step sequence
    if (beat == 12){
        Std.mtof(57) => swell.freq;
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
