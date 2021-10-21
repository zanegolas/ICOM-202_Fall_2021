//Zane Golas Assignment 2 for ICOM-202

//audio network
SawOsc sawTop => LPF filterOne => Pan2 topPan => dac;
SawOsc sawLow => LPF filterThree => Pan2 lowPan => dac;
SawOsc sawBass => LPF filterFour => dac;

//set filter cutoffs
1000 => filterOne.freq;
700 => filterThree.freq;
500 => filterFour.freq;

//osc gain control
.7 => sawLow.gain;
.6 => sawBass.gain;
.5 => sawTop.gain;


//init variables
.5::second => dur stepLength;
32 => int compSteps;
.3 => float panOne;


//init melody array
[52, 42, 52, 48, 50, 52] @=> int melodyArrayTop[];
[45, 47, 43, 45, 43, 45] @=> int melodyArrayLow[];
[33, 31, 33, 36, 31, 33] @=> int melodyArrayBass[];

//init note length per voice
[8, 3, 9, 4, 3, 5] @=> int lengthArrayTop[];
[4, 4, 12, 4, 4, 4] @=> int lengthArrayLow[];
[4, 8, 8, 4, 4, 4] @=> int lengthArrayBass[];

while ( true )
{
    //per voice step tracking
    0 => int topStep;
    0 => int lowStep;
    0 => int bassStep;
    
    //per voice note count
    0 => int countHigh;
    0 => int countLow;
    0 => int countBass;
    
    for ( 0 => int n; n < compSteps; n++)
    {
        Std.mtof( melodyArrayTop [countHigh] ) => sawTop.freq;
        Std.mtof( melodyArrayLow [countLow] ) => sawLow.freq;
        Std.mtof( melodyArrayBass [countBass] ) => sawBass.freq;
        
        
        if ( topStep == lengthArrayTop[countHigh] ) 
        {
            countHigh++;
            0 => topStep;
            Math.random2f( -.5, .5) => panOne;
        }
        
        if ( lowStep == lengthArrayLow[countLow] ) 
        {
            countLow++;
            0 => topStep;
        }
        
        if ( bassStep == lengthArrayBass[countBass] ) 
        {
            countBass++;
            0 => bassStep;
        }

        panOne => topPan.pan;
        panOne * -1 => lowPan.pan;
        stepLength => now;
        
        topStep++;
        lowStep++;
        bassStep++;
    }
}
