/* rota_FP13_dev
 jason stephens
 ITP 2011.12
 Updated 2012.10 during Video Alchemy at Radiance setup
 
       ****************************************
     F-P13 derives its name from the current possibility
     that 13 may be Pregnant with Flynn.
       ****************************************
 
 -> For use in conjunction with the PImage Processing Sketch
 
 TODO:
 DONE______create World class
 DONE______control World class rotation with knob 3
 DONE______add openGL
 ______Add Sin/Cos from the Rotate 1 and 2 examples
 ______assign knobs to sin/cos
 ______smooth world rotation
 ______create PImage class
 ______import data file
 ______create Oscillator class
 ______create a Banking class
 */


import processing.opengl.*;  //in order to do 3D affine transformations
import processing.serial.*;
Serial myPort; 
World world;  // a background reality onto which all else happens

// Arrays of Sensor Values and Knob IDs
int[] sensorValues = new int[10];  // array to hold the sensor values
Knob [] knobs = new Knob [10];  // create an array of knobs from the Knob class


void setup() {
  // set the size of the window:
  size(800, 600, OPENGL);

  // initialize the array of Knob Objects
  for (int i = 0; i < knobs.length; i++) {  //
    knobs[i] = new Knob (i, 0); // assign a knobCount to each knob AND and initial value
  }
  
  //initialize the world
  world = new World(); // so far, the world has no initial settings.

  // 1. List all the available serial ports
  println(Serial.list());
  
 /* 2. open the serial port.  If my Arduino shows up as the first port in the list,
   then Serial.list()[0] */
  myPort = new Serial(this, Serial.list()[4], 9600); 
  
  // 3. don't generate a serialEvent unless you get a linefeed in from the microcontroller:
  myPort.bufferUntil('\n');
  
  // 4. clear the serial buffer:
  myPort.clear();
  
  // don't draw strokes around the shapes:
  //noStroke();
}

void draw() {
  // nice green background:
  //background(99, 234, 120);
  
   //world class
  world.fade();
  world.display();

  // if there are sensor values, graph them:  AND pass the values to the knob objects
  if (sensorValues != null) {
    // how many sensors? As many as are in the array:
    int sensorCount = sensorValues.length;
    // iterate over the array, draw a bar for each one:
    for (int thisSensor = 0; thisSensor < sensorCount; thisSensor++) {
      // calculate the horizontal position of the bar 
      // based on how many sensor reading you have:
      float hPos = (thisSensor* width/sensorCount);
      // calculate the height of the bar based on the sensor value:
      float sensorHeight = map(sensorValues[thisSensor], 0, 1023, 0, height);
      float barColor = map(sensorValues[thisSensor], 0, 1023, 0, 255);
      fill (barColor);
      // calculate the starting vertitical position based on the height:
      float yPos = height - sensorHeight;
      // draw the bar:
      rect (hPos, height - sensorHeight, width/sensorCount, sensorHeight);
      
      // println(sensorValues[9]);
      // use dot syntax to pass the values into each Knob Object
      knobs[thisSensor].update(sensorValues[thisSensor]);
      knobs[thisSensor].display();
      
     
    }
    println(); // so that the display has a carriage return
  }
  
  //try world fading again see what happens
  world.fade();
  world.display();
  
  
}

void serialEvent(Serial myPort) { 
  // read the serial buffer:
  String myString = myPort.readStringUntil('\n');
  // if you got any bytes other than the linefeed:
  if (myString != null) {
    myString = trim(myString);
    // split the string at the commas
    // and convert the sections into integers:
    int sensors[] = int(split(myString, ','));
    // make sure you have enough readings:
    if (sensors.length >= sensorValues.length) {
      // put the readings into the global array:
      for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
        if (sensorNum < sensorValues.length) {
          sensorValues[sensorNum] = sensors[sensorNum];
        }
      }
    }
  }
}

