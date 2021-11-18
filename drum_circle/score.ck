//wake up conductor
Conductor conductor;

//shred ids
int kickID, hatID, cowID;

//set bpm
conductor.setBPM(128);


//cue instruments
conductor.cue("kick.ck") => kickID;
    
//cue hihat
conductor.cue("hat.ck") => hatID;
    
//play 4 bars
conductor.play(4,"bar");
    
//cue cowbell
conductor.cue("cow.ck") => cowID;
    
conductor.play(12,"bar");
//end of line man
conductor.kill(kickID);
conductor.kill(hatID);
conductor.kill(cowID);