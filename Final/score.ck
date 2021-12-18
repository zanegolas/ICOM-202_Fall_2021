//wake up conductor
Conductor conductor;

//shred ids
int kickID, hatID, cowID, bassID, leadID;

//set bpm
conductor.setBPM(128);

//cue bass
conductor.cue("bass.ck") => bassID;

//play 4 bars
conductor.play(4,"bar");


//cue instruments
conductor.cue("kick.ck") => kickID;
    
//play 4 bars
conductor.play(8,"bar");
    
//cue cowbell
conductor.cue("cow.ck") => cowID;
    
conductor.play(8,"bar");

conductor.kill(kickID);
conductor.kill(bassID);
conductor.kill(cowID);


conductor.cue("lead.ck") => leadID;
conductor.play(4,"bar");

conductor.cue("cow.ck") => cowID;   
conductor.play(8,"bar");

conductor.cue("bass.ck") => bassID;
conductor.cue("kick.ck") => kickID;


conductor.play(16,"bar");
conductor.cue("hat.ck") => hatID;

conductor.play(16,"bar");











//end of line man
conductor.kill(kickID);
conductor.kill(hatID);
conductor.kill(cowID);
conductor.kill(leadID);
conductor.kill(bassID);
