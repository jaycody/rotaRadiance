/*jason stephens
 PatternLang  LowHighSym  -  
 
 *Phase Locking vs Noise
 *THe ADJACENT POSSIBLE
 
 The more disorganized your brain, the smarter your are.  IQ correlated to chaos mode
 in between Phase Locking Mode.  PhaseLocking mode is where brain actually executes;
 Chaos mode is a background dreaming.  Longer time in Chaos mode increases IQ, but longer times
 in Phase Lock mode reduces the IQ.
 
 
 2011.11.25
 
 Combines 
 -420 angel (and unedited angel) 
 -and 418 1st and 2nd Batch PImage [Mostly Low Symmetry (and best High Sym)]
 
 The 1st and 2nd Batches of PImages both had complexity not found in the other set
 1st Batch:  
 1. made with "unedited" angels
 2. included 2nd iteration and was thus Recursive
 2nd Batch
 1. made with "Angel Cards" proper
 2. but had no 2nd iteration and was thus NOT recursive
 
 LowHighSym is an attempt to create High Level Symmetry from Low Level 1st Gen + Angel Cards.
 
 Functionality To ADD:
 Agent Based Steering Behavior for layers when not directly controlled by user
 Potentiometers for Size X and Y for Each layer
 Switches for Turning Off and ON each layer.  Move from 1 to 5 layers
 Switches and Controls for Activating and Changing Layer effects (opacity, etc.)
 Oscillation COS and SIN rotation with potentiometer to control parameters
 Potentiometer to Control location of Image
 
 ADD Drunken movement to rotation
 
 
 
 -
 TODO:
 ____Maybe Each Layer is it's OWN PImage.????
 DONE What What!!____set numberPicts variable
 _____Make a spinnning class?  Oh SNAP.  
 DONE Biotches_____Why is it crashing???
 
 _____ADD Sin Wave for outside perimeter spin spin
 _____create Perlin Noise for other rect sizes
 _____create Perlin noise for other rect positions
 _____placement and position of each image with perlin noise
 
 ____IPad Control WTF??  Oh SNAP
 
 DONE _____create a clear screen button
 DONE _____import 1 pot to adjust width on one image
 DONE _____Import 2 pots to adjust Height and Width of one Image. (8 hours of work)
 */

//start with the serial library
//import processing.serial.*;

//create an instance of the serial library
//Serial myPort; // create a new instance of the serial library


//let's get this openGl party started
import processing.opengl.*;  //in order to do 3D affine transformations



float x, y;  //translate amount
float rot = 0;
float r= 0;

// total # of Angel Cards and Total # of Layers
int totalCards = 20; //20; // 20=troubleshooting #Angels, 839=total#Angels
int totalLayers=5;

// 1-D arrays.  Enough INDEX for every image.  1 Index for each layer, will each receive 1 index
PImage [] angelCard = new PImage [totalCards];  // array of Cards.  each card is one of the "totalCards"
PImage [] layer = new PImage [totalLayers]; //array of layers.  each layer in the array is one of many "layer(s)"

//2-D Array Bitches....for what I don't yet know
int [][] rotater;

// An array of Oscillating objects
int maxNumOfOscillators = 3;
Oscillator[] oscillators = new Oscillator[maxNumOfOscillators];



void setup() {
  size(displayWidth, displayHeight, OPENGL);  //large scale
  //size(640, 480); // troublshooting phase
  smooth();
  background(0);
  x=width/2;
  y=height/2.0;

  //load the totalCards into each angelCard index (Index of 800 Images)
  for (int i=0; i<totalCards;i++) {   //these are the place holding PImages
    // angelCard [i] = createImage(width, height, ARGB);
    angelCard [i] = loadImage("LowHighSymm" + i + ".png");
  }

  //load each layer in the layer array with a random index number from the angelCard array
  for (int i=0; i<totalLayers;i++) {
    layer [i] = createImage (width, height, ARGB);
    int j = int(random(totalCards-1));
    PImage img = angelCard [j]; // pass it to an intermediary so the origanal doesn't change
    layer [i] = img.get();
  }

  //initialize the Oscillating Objects
  for (int i =0; i< oscillators.length; i++) {
    oscillators[i] = new Oscillator ();
  }
}

void draw() {
  //imageMode(CENTER);
  //fill(0,5); //go for the fade
  //rect(0,0,width,height);
  //tint(255,255,255,50);//ORIGNIAL
  //background(0,0,0,255);

  translate(x, y);
  rotate(rot);//the original

  //run all Oscillator Objects
  for (int i = 0; i < oscillators.length; i++) {
    oscillators [i].oscillate();
    oscillators [i].display();
  }

  /*
//images for rotation
   image(layer[3], 10, 10, mouseX*2, mouseY*2);//ORIGINAL 3 
   image(layer[2], -10, -10, mouseY, mouseX);//ORIGINAL 4 inner extending out
   image(layer[1], 0, 5, mouseX, mouseY/2);//ORIGINAL 5 inner circle
   image(layer[4], mouseX/4, mouseY/4, mouseX, mouseY*2);//ORIGNIAL 6 yet not effect
   layer[0].blend(layer[1], 10, 10, mouseX*2, mouseY*2, 0, 0, mouseX/2, mouseY/22, SOFT_LIGHT);
   */




  float r = map(mouseX, 0, width, 0.1, 13); // 6,13 = original.  where r is acceleration
  rot +=r; // where rot = velocity
  //rot += 10.021; //ORIGINAL from Oct 2010 ICM.  creates constant rotation of 5 fold



  //Troubleshooting Print
  print(" r=");
  print(r);
  print(" rot=");
  println(rot);
}


void mousePressed() {

  // for each mousePress, we cycle through all layers and assign a random index # from angelCard array  
  for (int i=0; i<totalLayers;i++) {
    layer [i] = createImage (width, height, ARGB);
    int q = int(random(totalCards-1));
    layer [i] = angelCard[q].get();  //have to use get OR the changes to layer[i] apply to angelCard!!!
    //5 hours that took....
  }
}


void keyPressed() {     //saves an image everytime the ENTER is pressed.
  if (keyCode==ENTER) {
    saveFrame("screen-####.png");
    noCursor();
  } 
  else {
    cursor();
  }
  if (keyCode==TAB) {
    background(0);
  }
}

