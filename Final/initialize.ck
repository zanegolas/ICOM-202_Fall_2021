//initialize.ck
<<< "Final by Zane Golas" >>>;

init("conductor.ck");
init("score.ck");

//////////////////////////////////////////////////////FUNCTIONS//////////////////////////////////////////////////////////////////////////
fun void init( string ckFile)
{
    //this function initializes other chuck files for playback    
    me.dir() + ckFile => string chuckPath;
    Machine.add(chuckPath);
    <<< chuckPath + " initialized as per user request">>>; //print status of load      
}
