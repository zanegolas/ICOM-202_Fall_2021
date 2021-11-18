//drums.ck

//soundchain
SndBuf hihat => Pan2 p => dac;

//load sounds
load("hihat_02", hihat);

//loop
while(true)
{
    Math.random2f(0.1, 0.3) => hihat.gain;
    Math.random2f(.9,1.1) => hihat.rate;
    (Math.random2(1,2) * 0.2):: second => now;
    Math.random2f(-1.0, 1.0) => p.pan;
    0 => hihat.pos;
} 








fun void load( string soundName, SndBuf playerName )
{
    //WARNING: this function is only for ICOM-202 samples stored in the directory above the program folder
    //function loads a single sound file from the git project folder based on only the normal file name to a SndBuf
    //sets play head to the end of the file
    
    me.dir(-1) + "audio/" + soundName + ".wav" => playerName.read; //filepath and .wav added to soundName then read by specified SndBuf
    playerName.samples() => playerName.pos; //set playhead
    <<< soundName + " loaded in to " + playerName >>>; //print status of load      
}