//initialize.ck

//SOMETHING SUPER DUPER IMPORTANT THAT WE AREN"T COOL ENOUGH TO LEARN YET


init("score.ck");

//////////////////////////////////////////////////////FUNCTIONS//////////////////////////////////////////////////////////////////////////
fun void init( string ckFile)
{
    //this function initializes other chuck files for playback    
    me.dir() + ckFile => string chuckPath;
    Machine.add(chuckPath);
    <<< chuckPath + " initialized as per user request">>>; //print status of load      
}
