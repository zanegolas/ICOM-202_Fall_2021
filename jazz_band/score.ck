//score.ck

init("lead.ck") => int leadID;
5::second => now;
init("drums.ck") => int drumID;
5::second => now;
init("piano.ck") => int pianoID;
5::second => now;
init("bass.ck") => int bassID;
5::second => now;
kill(pianoID);
5::second => now;
kill(bassID);
5::second => now;
kill(drumID);
kill(leadID);



















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

fun int init( string ckFile)
{
    //this function initializes other chuck files for playback    
    me.dir() + ckFile => string chuckPath;
    return Machine.add(chuckPath);
    <<< chuckPath + " initialized as per user request">>>; //print status of load      
}

fun void kill( int soundID )
{
    //this function removes the shred input by user
    Machine.remove(soundID);
     <<< "Shred " + soundID + " killed as per user request">>>; //print status of kill
 }
    