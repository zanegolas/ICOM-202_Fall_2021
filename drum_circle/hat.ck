//soundChain
SndBuf hihat => Echo hatEcho => NRev verb => Pan2 hatPan => dac;

//set fx params
.05 => verb.mix;
351::ms => hatEcho.delay;
702::ms => hatEcho.max; 
.10 => hatEcho.mix;
-.7 => float panN;

//connect to conductor
Conductor conductor;

//load kick sample
conductor.load("hihat_02", hihat);



//hat patterns
[1,0,1,0,1,0,1,1,0,1,1,0,1,0,1,1] @=> int hatPattern1[];
[1,1,1,0,1,0,1,1,1,1,1,1,1,1,1,1] @=> int hatPattern2[];

conductor.lookAhead(12,"bar") => time passage;
while( now < passage )
{
    
    //one bar loop
    for( 0 => int beat; beat < 16; beat++ )
    {
        if (hatPattern1[beat])
        {
            0 => hihat.pos;
            panN * -1 => panN => hatPan.pan;
        }
        conductor.playInst("1/16");
    }
}


while( true )
{
    
    //one bar loop
    for( 0 => int beat; beat < 16; beat++ )
    {
        if (hatPattern2[beat])
        {
            0 => hihat.pos;
            panN * -1 => panN => hatPan.pan;
        }
        conductor.playInst("1/16");
    }
}
