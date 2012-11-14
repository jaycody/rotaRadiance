/*What the world does:

 translates: 
   -> places the center of the world into the center of the screen by:
       1. display method, gets 2 knob values and assigns them to variables, which are then mapped to (screen width + .5(screen)).
       2. the mapped variables holding knob values are then used to inform the translate function.
   -> [] imporove TRANSLATE fucntion :: ADD FEATURE:  control worldCenter using PVector.
       1. use the PVector 'trans' from the constructor to store the worldCenter, (and change the name)    
       2. contructor method initially assigns the screen center to a PVector called trans (soon to be "worldCenter")
       3. getKnobValues and assign to PVector worldCenter using dot syntax .x .y
 
 rotates:
   -> uses one knob to control rotation by 1. mapping the 0-1023 to 6-13, then 2. adding this value to rotational radians
   -> rotateX and rotateY are commented out
   
 fades:
   -> no knob yet, this function push/pops a separate Matrix, and on it, draws screen-sized rectangle colored black with 5% opacity
   -> creates trails, man.
   
 receives Knob info:
   -> evidently, the knob array is global and can be called upon from anywhere (as the name "global scope" implies)
   -> actually, it's more complex.  Knobs are objects with the ability to get and return their own values.  Just use dot syntax
       to call the getKnobVal() function for each knob object.  store the returned value in a local variable.
       example:  Changing image1's width using the first knob:
                       float image_01_width = knobs[1].getKnobVal();
                       
[] takes screen shots:
    -> not yet
    
[] clears the screen:
    -> not yet
    
[] organizes the PImages:
    -> not yet
      1. screen shot gets labeled
      2. screen shot gets filed
      3. copy of screen shot goes to flickr
      4. returns url of screen shot's flickr address
      5. posts the URL to the screen for user to copy
      6. or simpler version.  Flickr address is of gallery, while each image is timestamped for easy search by user
 */


class World {


  PVector trans; // the world translates, and we want to direct it's homebase 
  float rot; // the world rotates
  int rotBlur; // the world fades away at an adjustable rate

  World ( ) {
    trans = new PVector (width/2, height/2);  //initial setting is center
    rot = 0;  // amount of initial rotation is 0 radians
    //c = color(0,0);  //initial world is black with no fade alpha
  }
  // create fadeWorldTrails
  void fade () {
    pushMatrix(); // check to see if pushpop will allow fade to be global
    fill (0, 5); // this sets the background to black and sets alpha to fade
    rect(0, 0, width, height); //this creates the fading
    popMatrix();
  }
  // moveWorldCenter
  void display () {
    float locX = knobs[1].getKnobVal(); // hells yeah, adjust translate y axis
    float locY = knobs[2].getKnobVal(); // adjust the translate x axis
    float transX = map(locX, 0, 1023, -width/2, width+width/2); // map the knobs to the width
    float transY = map(locY, 0, 1023, height+height/2, -height/2); //map the knobs to the height
    translate (transX, transY); //dot syntax to access the PVector for translate
    
    // rotateWorld
    float knobVal = knobs[3].getKnobVal();  // get knob val from knob[3] object and store it into r
    float r = map (knobVal, 0, 1023, 6, 13); // use the knobVal to inform velocity
    rot += r; // add mapped velocity to rotational velocity
    //rotateX(rot);
    //rotateY(rot);
    rotate (rot);  //rotate the world by rot value in radians
  }
}

