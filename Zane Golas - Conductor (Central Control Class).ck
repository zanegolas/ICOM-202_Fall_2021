// Written By: Zane Golas

class Conductor
{
    float bpm;//init song BPM var
    float timeTable[0];//stores float value in MS for note values between 1/32 and whole
    0 => float globalCount;//global count in ms to return beat values
    60000.0 => float MSPM;//ms per minute constant
    setBPM(120.0);//sets default value to 120 bpm
    <<< "Session Conductor Initialized With Default Values" >>>; //provide status on load
    
    fun void updateTimeTable ( float bpmUpdate )//function to recalculate note duration whenever new BPM is received
    {
        (MSPM / bpmUpdate) => timeTable["1/4"]; //quarter note reference in ms
        <<< "1/4 note referenced to ", timeTable["1/4"] >>>;
        //subdivide
        timeTable["1/4"] / 2 => timeTable["1/8"]; //eigth note
        <<< "1/8 note referenced to ", timeTable["1/8"] >>>;
        timeTable["1/8"] / 2 => timeTable["1/16"];//sixteenth note
        <<< "1/16 note referenced to ", timeTable["1/16"] >>>;
        timeTable["1/16"] / 2 => timeTable["1/32"];//thirty-second note
        <<< "1/32 note referenced to ", timeTable["1/32"] >>>;
       //multiply
       timeTable["1/4"] * 2 => timeTable["1/2"]; //half note
        <<< "1/2 note referenced to ", timeTable["1/2"] >>>;
       timeTable["1/4"] * 4 => timeTable["bar"]; //whole note
        <<< "One bar referenced to ", timeTable["bar"] >>>;
    }
        
    
    fun void setBPM ( float newBPM )//function to change bpm 
    {
        newBPM => bpm; //sets given BPM to object's bpm variable
        updateTimeTable( bpm ); //calculate's note lengths based on new data
        <<< "BPM is set to ", bpm >>>; //verifies via console that the correct BPM has been stored
    }
    
    //FUNCTION void play(intiger quantity, string unit must be bar, 1/2, 1/4, 1/8, 1/16, or 1/32) #######TODO:Write function overflows to only require note length variable or ms input  
    fun void play( int number, string noteLength )//moves time forward by desired amount
    {
        number * timeTable[noteLength] => float playTime;
        <<< "Conductor is playing ", number, " x ", noteLength, " for a total of ", playTime, "ms" >>>; 
        playTime::ms => now;
        globalCount + playTime => globalCount;
    }
    
    
    
    //FUNCTION time lookAhead(intiger quantity, string unit must be bar, 1/2, 1/4, 1/8, 1/16, or 1/32)
   fun time lookAhead( int number, string noteLength ) //returns input unit of time as dur in ms
   {
       number * timeTable[noteLength] => float timeAhead; //figures out the user requested time difference from timeTable values
       now + timeAhead::ms => time goalTime; //time in the future to return
       <<< "Conductor reports ", number, " x ", noteLength, " will have passed at ", goalTime >>>;
       return goalTime;
    }
    
    
    
    //FUNCTION int count(number to count, unit)
    //returns repeating subdivided count of selected unit, eg. count(4, "1/4") would return 0, 1, 2, 3, 0, 1, 2, 3, 0, 1... as time advanced.
    
    
}

///////////////DEMO

//Create Conductor object named "z"
Conductor z;

//Change bpm from default 120 to 128
z.setBPM(128);

//Find out what time in the future we will have gone tthrough 2 bars
z.lookAhead(2,"bar") => time end;

//play aka move time forward by two bars
z.play(2, "bar");




    
    
    
    

