/*What the world does:
 translates
 rotates
 fades
 receives Knob info
 takes screen shots
 clears the screen
 organizes the PImages?
 */


class World {


  PVector trans; // the world translates, and we want to direct it's homebase 
  float rot; // the world rotates
  int rotBlur; // the world fades away at an adjustable rate

  World ( ) {
    trans = new PVector (width/2, height/2);  //initial setting is center
    rot = 0;  // initial rotation is 0
    //c = color(0,0);  //initial world is black with no fade alpha
  }

  void fade () {
    pushMatrix(); // check to see if pushpop will allow fade to be global
    fill (0, 5); // this sets the background to black and sets alpha to fade
    rect(0, 0, width, height); //this creates the fading
    popMatrix();
  }

  void display () {
    float locX = knobs[8].getKnobVal(); // hells yeah, adjust translate y axis
    float locY = knobs[9].getKnobVal(); // adjust the translate x axis
    float transX = map(locX, 0, 1023, -width/2, width+width/2); // map the knobs to the width
    float transY = map(locY, 0, 1023, height+height/2, -height/2); //map the knobs to the height
    translate (transX, transY); //dot syntax to access the PVector for translate
    
    float knobVal = knobs[3].getKnobVal();  // get knob val from knob[3] object and store it into r
    float r = map (knobVal, 0, 1023, 6, 13); // use the knobVal to inform velocity
    rot += r; // add mapped velocity to rotational velocity
    //rotateX(rot);
    //rotateY(rot);
    rotate (rot);  //rotate the world by rot value in radians
  }
}

