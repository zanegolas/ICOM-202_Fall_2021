//soundChain
SndBuf cow => Echo cowEcho => NRev verb => Pan2 cowPan => dac;

//set fx params
.05 => verb.mix;
351::ms => cowEcho.delay;
702::ms => cowEcho.max; 
.10 => cowEcho.mix;

//connect to conductor
Conductor conductor;

//load kick sample
conductor.load("click_05", cow);

//cowbell patterns
[0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0] @=> int cowPattern1[];
[0,0,0,0,1,0,0,0,0,0,0,0,1,0,1,1] @=> int cowPattern2[];

Math.random2f(-1.0, 1.0) => cowPan.pan;

conductor.lookAhead(8,"bar") => time passage;
while( now < passage )
{
    
    //one bar loop
    for( 0 => int beat; beat < 16; beat++ )
    {
        if (cowPattern1[beat])
        {
            0 => cow.pos;
            Math.random2f(-1.0, 1.0) => cowPan.pan;
        }
        conductor.playInst("1/16");
    }
}


while( true )
{
    
    //one bar loop
    for( 0 => int beat; beat < 16; beat++ )
    {
        if (cowPattern2[beat])
        {
            0 => cow.pos;
            Math.random2f(-1.0, 1.0) => cowPan.pan;
        }
        conductor.playInst("1/16");
    }
}
