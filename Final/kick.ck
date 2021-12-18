//sound chain
SndBuf kick => dac;

kick.gain(0.5);

//connect to conductor
Conductor conductor;

//load kick sample
conductor.load("kick_04", kick);

//Kick Patterns
[1,0,0,0,1,0,0,1,0,0,1,0,0,0,1,0] @=> int kickPattern1[];
[1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,1] @=> int kickPattern2[];

//loop kicks on quarters
while( true )
{
    
    //one bar loop
    for( 0 => int beat; beat < 16; beat++ )
    {
        if (kickPattern1[beat])
        {
            0 => kick.pos;
        }
        conductor.playInst("1/16");
    }
}




