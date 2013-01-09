/* rota_Radiance_dev
 jason stephens
 2012.10 VideoAlchemy Exhibit
 
 DIRECTIONS FOR RADIANCE HOUSEMATES:
 1. Does the word 'Processing' appear in the top left of this computer screen?
    - If no, then select this window to make PROCESSING the active program
    - If YES, then go to step 2.
 2. From the choices on the top left you should see the following options:
    Processing   File   Edit   Sketch   Tools   Help
   
  3. select 'Sketch'
  4. observe the drop down menu from 'Sketch'  It reads:  Run  Present  Stop  ...etc
  5. Keep Reading ALL the instructions before going to the next step.
  6. Select 'Present'
  7. Wait about 1 minute for the Video Alchemy application to begin.  
  8. after about 1 minute, you should see spinning graphics.
  9. In order to center the rotation of the graphics on the screen, select the bottom
        right button on the big wooden console.  it's the bottom right button, it's read, it has
        a star on it;
   10. Hit the bottom right button AGAIN.  This should center the image.
   11. You're DONE!
   
   
 
 Keyboard Controls
 'R'
 'G'
 'B'
 Space = snapshot
 Mouse X = rotational velocity
 
 */

////////////////
//  GLOBALS FOR CHOOSING ENVIRONMENTS 
////////////////

int USB_SERIAL_PORT = 0;
boolean USING_FP13 = false;

// Set to true if using the Radiance podium controller setup.
boolean USING_RADIANCE_CONTROLLER = true;



////////////////
//  GLOBALS FOR DRAWING 
//

// Set to 'true' to preload all images before starting (slower).
// Set to 'false' to load images as they're used (good for development).
boolean PRELOAD_IMAGES = true;

// Size of our screen.  Use 'displayWidth' and 'displayHeight' for full screen size, or specify explicit size.
int SCREEN_WIDTH = 640;  //640;
int SCREEN_HEIGHT = 480;  //480;

// total # of Angel Cards
int totalCards = 417; //418; // 20=troubleshooting #Angels, 418=total#Angels

// Location where we'll save snapshots.
String SNAP_FOLDER_PATH = "/Users/jayPop/snaps/";

// Opacity levels for each arm
int RED_OPACITY = 255;
int GREEN_OPACITY = 240;
int BLUE_OPACITY = 200;

// Number of samples for each potentiometer.
int SAMPLE_COUNT = 3;

//
//  END GLOBALS FOR DRAWING 
////////////////


import java.awt.Toolkit;
//import processing.opengl.*;
import processing.serial.*;
Serial myPort; 
World world;  // a background reality onto which all else happens

PImage[] angelCard = new PImage[totalCards];  // array of Cards.  each card is one of the "totalCards"


//___________________________________________________________________________________

// create settings for both controllers.  
//these variables populate the arrays to determine the number of sensors
int sensorCount = (USING_RADIANCE_CONTROLLER ? 11 : 10);

// Arrays of Sensor Values and Knob IDs_______________________________________________
int[] sensorValues = new int[sensorCount];  // array to hold the sensor values
Knob [] knobs = new Knob [sensorCount];  // create an array of knobs from the Knob class


// Three image "arms"
Arm[] arms = new Arm[3];
Arm redArm;
Arm blueArm;
Arm greenArm;

// Physical (or virtual) controls

// controls as an array
int CONTROL_COUNT = 11;
Control[] controls = new Control[CONTROL_COUNT];
int CONTROL_NUM = 0;  // for adding to the controls list

// controls as a map
HashMap controlMap = new HashMap();

// red button and knobs
Button redButton; 
Potentiometer redLeft;
Potentiometer redRight;

// green button and knobs
Button greenButton;
Potentiometer greenLeft;
Potentiometer greenRight;

// blue button and knobs
Button blueButton;
Potentiometer blueLeft;
Potentiometer blueRight;

// big knob
Potentiometer ohm;

// button which "snaps" the picture
Button snapper;

PImage feedbackImage;


//_________________________________________________________________________________________
void setup() {
  
  println("Initializing window at " + SCREEN_WIDTH + " x " + SCREEN_HEIGHT);

  // set the size of the window:
  //size(800, 600, OPENGL); use this for diagnostic test with the sensor Graph

  size(displayWidth, displayHeight,P2D);  //large scale

 // size(displayWidth, displayHeight, P2D);  //large scale
  //size(displayWidth, displayHeight, OPENGL);  //large scale
  //size(SCREEN_WIDTH, SCREEN_HEIGHT); // troublshooting phase
  smooth();
  background(0);

  //_______________________SERIAL READ SETUP__________________________________________
  if (USB_SERIAL_PORT < Serial.list().length) {
    println(Serial.list());  // 1. List all the available serial ports
    /* 2. open the serial port.  If my Arduino shows up as the first port in the list,
     then Serial.list()[0] */
    myPort = new Serial(this, Serial.list()[USB_SERIAL_PORT], 9600); 
    /* 3. buffer the serial port until all sensors report-in AND linefeed (aka End of Line) arrives,
     then generate a serialEvent*/
    myPort.bufferUntil('\n');
    myPort.clear();  // 4. clear the serial buffer:
  }
  //__________________________________________________________________________________


  //
  // preload images if necessary
  //
  if (PRELOAD_IMAGES) {
     for (int i = 0; i < totalCards; i++) {
       getAngelCard(i);
     } 
  }

  //
  // set up our controls
  //

  // red button and knobs
  redButton = new Button("redButton", OFF); 
  redLeft = new Potentiometer("redLeft", 0);
  redRight = new Potentiometer("redRight", 0);

  // green button and knobs
  greenButton = new Button("greenButton", OFF);
  greenLeft = new Potentiometer("greenLeft", 0);
  greenRight = new Potentiometer("greenRight", 0);

  // blue button and knobs
  blueButton = new Button("blueButton", OFF);
  blueLeft = new Potentiometer("blueLeft", 0);
  blueRight = new Potentiometer("blueRight", 0);

  // big knob
  ohm = new Potentiometer("ohm", 0);

  // button which "snaps" the picture
  snapper = new Button("snapper", OFF);

  if (USING_RADIANCE_CONTROLLER) {
    setUpControlsForRadianceController();
  } else if (USING_FP13) {
    setUpControlsForFP13();
  } 
  
  
    //
  // set up our arms
  //
  arms[0] = redArm = new Arm("  red", redLeft, redRight, RED_OPACITY);
  arms[1] = greenArm = new Arm("green", greenLeft, greenRight, GREEN_OPACITY);
  arms[2] = blueArm = new Arm(" blue", blueLeft, blueRight, BLUE_OPACITY);

  //
  // Initialize app states
  //
  CurrentState = null;
  
  // AppState "ResetArms" sets up the initial conditions of the arms
  new ResetArms();
  enterState("ResetArms");

  // Mode0 = all buttons active, no knob action
  new Mode0Start();
  new Mode0End();
  enterState("Mode0Start");

  // RGBAttract = buttons active one at a time
  //new RedAttract();
  //new GreenAttract();
  //new BlueAttract();
  //enterState("RedAttract");


  ///// OLD STUFF

  // ____________initialize the array of Knob Objects_____________________________
  for (int i = 0; i < knobs.length; i++) {  //
    knobs[i] = new Knob (i, 0); // assign a knobCount and an initial value to each knob
  }

  ////// END OLD STUFF 

  //_______________initialize the world__________________________________________
  world = new World(); // it is the world that spins, the pattern language enjoys the ride

  // don't draw strokes around the shapes:
  //noStroke();
  
  //setup the feedback loop
  //feedbackImage = createImage(100, 100, ARGB); //setting up the feedback loop
}

void draw() {
  //background(99, 234, 120);  // nice green background

// feedback arm


  
  // graphSensorValuesTest();
  // if there are sensor values, graph them:  AND pass the values to the knob objects
  if (sensorValues != null) {
    // how many sensors? As many as are in the array:
    int sensorCount = sensorValues.length;
    // iterate over the array, draw a bar for each one:
    for (int thisSensor = 0; thisSensor < sensorCount; thisSensor++) {
      // calculate the horizontal position of the bar 
      // based on how many sensor reading you have:
      /*
      float hPos = (thisSensor* width/sensorCount);
       // calculate the height of the bar based on the sensor value:
       float sensorHeight = map(sensorValues[thisSensor], 0, 1023, 0, height);
       float barColor = map(sensorValues[thisSensor], 0, 1023, 0, 255);
       fill(barColor);
       //fill (255*(barColor/255), 255-barColor, 2*thisSensor);
       // calculate the starting vertitical position based on the height:
       float yPos = height+(thisSensor*20) - sensorHeight;
       // draw the bar:
       rect (hPos, height - sensorHeight, width/sensorCount, sensorHeight);
       */
      // println(sensorValues[9]);

      // use dot syntax to pass the values into each Knob Object
 //     knobs[thisSensor].update(sensorValues[thisSensor]);
      //O    knobs[thisSensor].display();
    }
    //O  println(); // so that the display has a carriage return
  }

  //world class
  // calls fade function -> draws a rect the size of the screen, colors it black with 5% opacity for TRAILS
  //world.fadingTrailsTransparentRectOverlay(0);  // 0 = knob 8 , 1 = knob 9
  world.moveWorldCenter();
  world.rotateWorld();
  
  //create some trails
 // fill(0,5);
 // rect(0,0,width,height);


// feedback image yo yo
   // acquire pixels within these dimensions and store in PImage varible 'img'
  

 
  //try world fading again see what happens
  //world.fadingTrailsTransparentRectOverlay(-1);  
  // world.moveWorldCenter ();
  // world.rotateWorld (-1);  // 1 is clockwise, -1 is counterClockWise


  // if we don't have an arduino hooked up, 
  //  simulate button presses via keys on the keyboard
 // updateControlsFromKeyboard();

// feedback image yo yo
   // acquire pixels within these dimensions and store in PImage varible 'img'
  //feedback layer
 
/*pushMatrix();
  rotate(0);
  beginShape();
  texture(feedbackImage);
  vertex(0, 0, 0, 0);
  vertex(200, 0, width/2, 0);
  vertex(200, 200, width/2, height/2);
  vertex(0, 200, 0, height/2);
  endShape(CLOSE);
  popMatrix();
  */

  
  // print out the current state of the controls
  debugControls();

  // tell the current state to update the state of the controls
  CurrentState.checkControls();

  // tell the current state to update the display!
  CurrentState.updateDisplay();
  
  
  // feedbackImage=get(mouseX, mouseY, width, height);
 
  
  

}


// Called automatically by serial library each "tick"
void serialEvent(Serial myPort) { 
  // read the serial buffer:
  String sensorString = myPort.readStringUntil('\n');
  // if we only got a linefeed, forget it
  if (sensorString == null) return;
  
  // split the string at the commas
  // and convert the sections into integers:
  sensorString = trim(sensorString);
  int sensors[] = int(split(sensorString, ','));
  
  // make sure we got enough readings
  if (sensors.length < sensorCount) return;
  
  // remember as the new global sensor values
  sensorValues = sensors;
  
  // loop through the controls,
  //   if the control has a valid inputPin, set its value to that of the sensor
  for (int i = 0; i < controls.length; i++) {
     Control control = controls[i];
     if (control != null) {
       int inputPin = control.inputPin;
       if (inputPin != -1 && inputPin < sensorCount) {
         int sensorValue = sensorValues[inputPin];
         control.updateFromSensor(sensorValue);
       }
     }
  }
}


// TODO: set up outputPins
void setUpControlsForRadianceController() {
   blueButton.inputPin = 7; 
   blueButton.outputPin = -1; 

   blueLeft.inputPin = 1; 
   blueLeft.outputPin = -1; 

   blueRight.inputPin = 2; 
   blueRight.outputPin = -1; 

   greenButton.inputPin = 8; 
   greenButton.outputPin = -1; 

   greenLeft.inputPin = 3; 
   greenLeft.outputPin = -1; 

   greenRight.inputPin = 4; 
   greenRight.outputPin = -1; 

   redButton.inputPin = 9; 
   redButton.outputPin = -1; 

   redLeft.inputPin = 5; 
   redLeft.outputPin = -1; 

   redRight.inputPin = 0;
   redRight.outputPin = -1; 
  
   ohm.inputPin = 6;
   ohm.outputPin = -1; 

   snapper.inputPin = 10; 
   snapper.outputPin = -1; 
}


// TODO:  set the input/output pin values to the correct ones for the controller!
void setUpControlsForFP13() {
   redButton.inputPin = 7; 
   redButton.outputPin = -1; 

   redLeft.inputPin = 1; 
   redLeft.outputPin = -1; 

   redRight.inputPin = 2; 
   redRight.outputPin = -1; 

   greenButton.inputPin = 8; 
   greenButton.outputPin = -1; 

   greenLeft.inputPin = 3; 
   greenLeft.outputPin = -1; 

   greenRight.inputPin = 4; 
   greenRight.outputPin = -1; 

   blueButton.inputPin = 9; 
   blueButton.outputPin = -1; 

   blueLeft.inputPin = 5; 
   blueLeft.outputPin = -1; 

   blueRight.inputPin = 0;
   blueRight.outputPin = -1; 
  
   ohm.inputPin = 6;
   ohm.outputPin = -1; 

   snapper.inputPin = 10; 
   snapper.outputPin = -1; 
}


void beep() {
   Toolkit.getDefaultToolkit().beep(); 
}


  // Format a 4-digit integer (positive or negative) with spaces for pretty printing
  String padInt(int value) {
      String prefix = " ";
      if (value < 0) {
         prefix = "-";
         value = value * -1;
      }
      
      if (value >= 1000) return prefix+value;
      if (value >= 100)  return " "+prefix+value;
      if (value >= 10)   return "  "+prefix+value;
      return "   "+prefix+value;
  }


// output right now as a string   YYYY.MM.DDHH.MM.SS
String nowAsString() {
  return nf(year(), 4)+"."+
         nf(month(), 2)+"."+
         nf(day(), 2)+"/"+
         nf(hour(), 2)+"."+
         nf(minute(), 2)+"."+
         nf(second(), 2);
}

// Save the current screen state as a .jpg in the SNAP_FOLDER_PATH,
// If you pass a filename, we'll use that, otherwise we'll default to the current date.
// NOTE: do NOT pass the ".jpg" or the path.
// Returns the name of the file saved.
String saveScreen() {
   return saveScreen(null); 
}
String saveScreen(String fileName) {
  if (fileName == null) {
    fileName = nowAsString(); 
  }
  
  save(SNAP_FOLDER_PATH + fileName + ".jpg");
  println("SAVED AS "+fileName);
  return fileName;
}


// Set the randomSeed to the current timestamp.
void updateUniversalRandomness() {
  randomSeed(millis());
}

// Return a random image from the angel card library,
//   loading them as necessary.
PImage getAngelCard(int cardNum) {
   if (angelCard[cardNum] == null) {
      println("loading card "+cardNum+" of "+totalCards);
      angelCard[cardNum] = loadImage("F_P"+cardNum+".png");
   }
   return angelCard[cardNum]; 
}


