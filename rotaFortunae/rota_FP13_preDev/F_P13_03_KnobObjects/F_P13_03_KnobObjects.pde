/* F_P13_03_KnobObjects
 jason stephens
 ITP 2011.12
 
 F-P13 derives its name from the current possibility
 that 13 may be Pregnant with Flynn.
 
 Version_03 : KnobObjects :
 This is the starting point for any other use of the F-P13.  Each knob is now a Knob Object
 numbered 0-9.  Access through dot.syntax
 */


// import the serial library:
import processing.serial.*;

Serial myPort;    // instance of the serial library
int[] sensorValues = new int[10];  // array to hold the sensor values
Knob [] knobs = new Knob [10];  // create an array of knobs from the Knob class

void setup() {
  // set the size of the window:
  size(800, 600);

  // initialize the array of Knob Objects
  for (int i = 0; i < knobs.length; i++) {  //
    knobs[i] = new Knob (i, 0); // assign a knobCount to each knob AND and initial value
  }


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
  background(99, 234, 120);

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

