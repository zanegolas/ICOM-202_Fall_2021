//sound chain
SinOsc sineBass => ADSR bass => dac;

//set sine parameters
bass.set(117::ms, 351::ms, 0., 5::ms);
Std.mtof(33) => sineBass.freq;
bass.gain(.5);

//connect to conductor
Conductor conductor;

while( true )
{
    
    //one bar loop
    for( 0 => int beat; beat < 16; beat++ )
    {
        if (beat % 4 == 2)
        {
            bass.keyOn(1);
        }
        conductor.playInst("1/16");
    }
}