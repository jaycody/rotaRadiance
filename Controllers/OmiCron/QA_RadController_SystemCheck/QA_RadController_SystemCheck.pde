/* OmiCron_SystemsCheck
 [x] Verified in Processing 2.0b5 
 [x] verified in Processing 1.5.1
 
 jason stephens
 ITP 2011.12
 updated 2012.10 for the VideoAlchemy Exhibit at Radiance
 
 Version_01 : Systems Check : A calibration and testing application
 
 */


// import the serial library:
import processing.serial.*;

Serial myPort;    // instance of the serial library
int[] sensorValues = new int[11];  // array to hold the sensor values


void setup() {
  // set the size of the window:
  size(800, 600);

  // 1. List all the available serial ports
  println(Serial.list());

  /* 2. open the serial port.  If my Arduino shows up as the first port in the list,
   then Serial.list()[0] */
  myPort = new Serial(this, Serial.list()[4], 9600); // or, in this case, 4

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

  // if there are sensor values, graph them:
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
      // now handle the button states for inputs 8,9,10,11
      if (thisSensor > 6) {
        if (sensorValues[thisSensor] == 1) {
          rect (hPos, 0, width/sensorCount, height); // this should make a solid rectangle
        }
      }
      // println(sensorValues[9]);
    }
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

/*
TODO:  add 5th argument to rectangle to get rounded edges rect(30, 20, 55, 55, 7);
 
 */
