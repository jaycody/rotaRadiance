/*
//PLang Class.  Now We getting crazy

class PLang {
  // standard stuff
  // missing a PImage img?

  PVector location; //because it's gotta exist somewhere
  PVector widthHeight; // why not treat the x and y as a PVector sheeet
  
  PImage img; // just added this today

    //  float rot; //rotation is theta in motion.  individual rots = 0
  //  float rotOffSet; //incase it wants to spin faster or slower
  //  float theta; //theta would add or sub from the World angle
  //  float thetaOffSet; //so one can be trailing or ahead of another??
  //oscillation stuff 
  //  PVector angle;
  //  PVector oscillationVel; // velocity of oscillation 
  //  PVector oscillationAmp; //amplitude of the oscillation


  Plang (PImage _img, float _xPos, float _yPos, float _width, float _height ) {
    img = _img;
    location = new PVector (__xPos, _yPos);
    widthHeight = new PVector (_width, _height);

    //thetaOffSet = _thetaOffSet; // angled slightly ahead or behind the curve

    //oscillation methods
    //    angle = new PVector();
    //    oscillationVel = new PVector;
  }


  void display () {
    image(img, location.x, location.y, widthHeight.x, widthHeight.y); //initial settings
   
  }

  void oscillate() {
  }
}



//float locX = knobs[8].getKnobVal(); // hells yeah, adjust translate y axis
//    float locY = knobs[9].getKnobVal(); // adjust the translate x axis
//    float transX = map(locX, 0, 1023, -width/2, width+width/2); // map the knobs to the width
//    float transY = map(locY, 0, 1023, height+height/2, -height/2); //map the knobs to the height


*/
