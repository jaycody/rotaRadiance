/* rota_Radiance_dev
 jason stephens
 2012.10 VideoAlchemy Exhibit
 
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
boolean USING_RADIANCE_CONTROLLER = true;



////////////////
//  GLOBALS FOR DRAWING 
////////////////
int SCREEN_WIDTH = 1280;
int SCREEN_HEIGHT = 768;



import processing.opengl.*;
import processing.serial.*;
Serial myPort; 
World world;  // a background reality onto which all else happens

// total # of Angel Cards
int totalCards = 20; //20; // 20=troubleshooting #Angels, 839=total#Angels
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



//_________________________________________________________________________________________
void setup() {
  // set the size of the window:
  //size(800, 600, OPENGL); use this for diagnostic test with the sensor Graph

  //size(displayWidth, displayHeight, OPENGL);  //large scale
  size(SCREEN_WIDTH, SCREEN_HEIGHT); // troublshooting phase
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
  // set up the initial set of angelCards
  //
  for (int i=0; i<totalCards;i++) {   //these are the place holding PImages
    // angelCard [i] = createImage(width, height, ARGB);
    angelCard[i] = loadImage("F_P" + i + ".png");
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
  arms[0] = redArm = new Arm("red", redLeft, redRight);
  arms[1] = greenArm = new Arm("green", greenLeft, greenRight);
  arms[2] = blueArm = new Arm("blue", blueLeft, blueRight);

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
}

void draw() {
  //background(99, 234, 120);  // nice green background

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

  //try world fading again see what happens
  //world.fadingTrailsTransparentRectOverlay(-1);  
  // world.moveWorldCenter ();
  // world.rotateWorld (-1);  // 1 is clockwise, -1 is counterClockWise


  // if we don't have an arduino hooked up, 
  //  simulate button presses via keys on the keyboard
 // updateControlsFromKeyboard();

  // print out the current state of the controls
  debugControls();

  // tell the current state to update the state of the controls
  CurrentState.checkControls();

  // tell the current state to update the display!
  CurrentState.updateDisplay();
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


