
class Knob {

  int knobCount;  //which knob is it (0-9);
  int currentKnobVal;  //each Knob has a value
  
  // vars for sampling, averaging and returning averged, unspiked, smooth knob values 
  int averagedKnobVal; // stores the averaged result of sensor data stored in the sensorSample array
  int maxNumOfKnobSamples = 38; // sets the size of the array used to store the samples and prepare for averaging
  int currentSampleNum = 0; //  used as an index into the array to be incremented at the end of main loop
  int [] knobSampleForAveraging = new int [maxNumOfKnobSamples]; // holds 8 knobValues and holds for averaging
  
  Knob(int _knobCount, int _knobVal) {   //pass the knob info into here somehow   
    knobCount = _knobCount;  // pass this info into the object from the serial event.
    currentKnobVal = _knobVal;
  }


  // _______create functions which answer requests from the image objects for Knob info
  //-> what's this knob's current value?
  float getKnobVal() {
    return currentKnobVal;
  }
  
  //________*********** CALCULATE AND RETURN A KNOBS RUNNING AVERAGE ********************
  /* -> what's this knob's average value sampled across a max num of samples?
  this function returns an averaged sensor value.  The dot syntax call looks like this:
  float averagedKnobVal = knobs[foo].getAveragedKnobVal();  // get ohmite knob val and store it 
  */
  float getAveragedKnobVal() {
    /* start by checking to see if the current sample has reached our max threshold of samples for averaging.
    If current sample reaches the max threshold, then reset the counter.*/
    if (currentSampleNum == maxNumOfKnobSamples) {
      currentSampleNum = 0;
    }
    
    knobSampleForAveraging[currentSampleNum] = currentKnobVal; // assign the current value to sample index number 0-7
    
    // now we run a for loop to harness all 8 samples into one place
     // 1] cycle through each sample and add them all together.  store the result
    for (int i = 0; i < maxNumOfKnobSamples; i++) {
      averagedKnobVal += knobSampleForAveraging[i];
    }
      // 2] divide the totaled sensor data by the overall number of samples and store this in a var the average
      averagedKnobVal = averagedKnobVal/maxNumOfKnobSamples; 
      
      // 3] now increment through the array to the next sample by increasing the current sample number by 1
      currentSampleNum ++ ;
      
    // then return the averaged sensor data to whoever is asking for this information
   return averagedKnobVal; 
  }

//____________________________________________________________
  // use this to get information from the for loop passing values
  void update(int _val) {
    currentKnobVal= _val;
  }

  void display() {
    print(" ");
    print(knobCount);
    print(" = ");
    print(currentKnobVal);
    print ('\t');
  }
}


/*
NOTES:
// in order to smooth spikes in sensor data, sample the sensor (stored it into an array) and average the result.
int maxNumOfKnobSamples = 8;  // sets the size of the array used to store the samples and prepare for averaging
int currentSensorSample = 0 ; // used as an index into the array to be incremented at the end of main loop
int averagedKnobVal = 0; // stores the result of averaged sensor data from the sensorSample array
int[] sensorSamples = new int [maxNumOfSensorSamples];  // to smooth spikes in sensor data, store samples in array and average

*/
