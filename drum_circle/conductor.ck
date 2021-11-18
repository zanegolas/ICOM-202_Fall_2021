// Written By: Zane Golas (2021)

public class Conductor
{
    static float bpm;//init song BPM var
    1::second => static dur systemAudioRate;
    <<< "System audio rate of", systemAudioRate, "detected by conductor" >>>;
    dur timeTable[0];//stores float value in MS for note values between 1/32 and whole
    static dur quarterNote, eighthNote, sixteenthNote, thirtysecondNote, halfNote, wholeNote;
    0::second => static dur globalCount;//global count in seconds to return beat values
    setBPM(128.0);//sets default value to 120 bpm
    <<< "Session Conductor Initialized With Default Values" >>>; //provide status on load
    
    fun void updateTimeTable ( float bpmUpdate )//function to recalculate note duration whenever new BPM is received
    {
        60.0/(bpmUpdate) => float SPB;
        SPB::second => quarterNote => timeTable["1/4"]; //quarter note reference in ms
        <<< "1/4 note referenced to", timeTable["1/4"], "samples" >>>;
        //subdivide
        quarterNote / 2 => eighthNote => timeTable["1/8"]; //eighth note
        <<< "1/8 note referenced to", timeTable["1/8"], "samples" >>>;
        eighthNote / 2 => sixteenthNote => timeTable["1/16"];//sixteenth note
        <<< "1/16 note referenced to", timeTable["1/16"], "samples" >>>;
        sixteenthNote / 2 => thirtysecondNote => timeTable["1/32"];//thirty-second note
        <<< "1/32 note referenced to", timeTable["1/32"], "samples" >>>;
       //multiply
       quarterNote * 2 => halfNote => timeTable["1/2"]; //half note
        <<< "1/2 note referenced to", timeTable["1/2"], "samples" >>>;
       quarterNote * 4 => wholeNote => timeTable["bar"]; //whole note
        <<< "One bar referenced to", timeTable["bar"], "samples" >>>;
    }
        
    
    fun void setBPM ( float newBPM )//function to change bpm 
    {
        newBPM => bpm; //sets given BPM to object's bpm variable
        updateTimeTable( bpm ); //calculate's note lengths based on new data
        <<< "BPM is set to", bpm >>>; //verifies via console that the correct BPM has been stored
    }
    
    //FUNCTION void play(intiger quantity, string unit must be bar, 1/2, 1/4, 1/8, 1/16, or 1/32)   
    fun void play( int number, string noteLength )//moves time forward by desired amount
    {
        number * timeTable[noteLength] => dur playTime;
        (playTime / systemAudioRate) $ float => float timeInSeconds;
        <<< "Conductor is playing", number, "x", noteLength, "for a total of", timeInSeconds, "seconds" >>>; 
        playTime => now;
        globalCount + playTime => globalCount;
    }
    
    //FUNCTION void play(intiger quantity, string unit must be bar, 1/2, 1/4, 1/8, 1/16, or 1/32)   
    fun void play( string noteLength )//moves time forward by desired amount
    {
        timeTable[noteLength] => dur playTime;
        (playTime / systemAudioRate) $ float => float timeInSeconds;
        <<< "Conductor is playing", noteLength, "for a total of", timeInSeconds, "seconds" >>>; 
        playTime => now;
        globalCount + playTime => globalCount;
    }
    
    //FUNCTION void playInst(intiger quantity, string unit must be bar, 1/2, 1/4, 1/8, 1/16, or 1/32)   
    fun void playInst( int number, string noteLength )//moves time forward by desired amount without updating globalCount
    {
        number * timeTable[noteLength] => dur playTime;
        playTime => now;
    }
    
    //FUNCTION void playInst(string unit must be bar, 1/2, 1/4, 1/8, 1/16, or 1/32) 
    fun void playInst( string noteLength )//moves time forward by desired amount without updating globalCount
    {
        timeTable[noteLength] => dur playTime;
        playTime => now;
    }
    
    
    
    //FUNCTION time lookAhead(intiger quantity, string unit must be bar, 1/2, 1/4, 1/8, 1/16, or 1/32)
   fun time lookAhead( int number, string noteLength ) //returns input unit of time as dur in ms
   {
       number * timeTable[noteLength] => dur timeAhead; //figures out the user requested time difference from timeTable values
       now + timeAhead => time goalTime; //time in the future to return
       <<< "Conductor reports", number, "x", noteLength, "will have passed at", goalTime/second >>>;
       return goalTime;
    }
    
    
    
    //FUNCTION int count(number to count, unit)
    //returns repeating subdivided count of selected unit, eg. count(4, "1/4") would return 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3... as time advanced.
    fun int count( int number, string noteLength )
    {
        globalCount / timeTable[noteLength] => float notesElapsed;
        (notesElapsed % number) + 1 => float count;
        count $ int => int beat;
        <<< "Conductor reports beat", beat, "when subdivided by", number, "x", noteLength >>>;
        return beat;
    }
    
    //FUNCTION int countZero(number to count, unit)
    //returns repeating subdivided count of selected unit starting with zero, eg. count(4, "1/4") would return 0, 1, 2, 3, 0, 1, 2... as time advanced.
    fun int countZero( int number, string noteLength )
    {
        globalCount / timeTable[noteLength] => float notesElapsed;
        (notesElapsed % number) => float count;
        count $ int => int beat;
        <<< "Conductor reports beat", beat, "when subdivided by", number, "x", noteLength, "using zero index" >>>;
        return beat;
    }
    
    fun void load( string soundName, SndBuf playerName )
    {
        //WARNING: this function is only for ICOM-202 samples
        //function loads a single sound file from the ICOM-202 project folder based on only the normal file name to a SndBuf
        //sets play head to the end of the file
        
        me.dir(-1) + "audio/" + soundName + ".wav" => playerName.read; //filepath and .wav added to soundName then read by specified SndBuf
        playerName.samples() => playerName.pos; //set playhead
        <<< "Conductor loaded" + soundName + "in to" + playerName >>>; //print status of load      
    }
    
    fun int cue( string ckFile)
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


    
}





    
    
    
    

