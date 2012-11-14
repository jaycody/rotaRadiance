
////////////////////////////
//  INDIVIDUAL APP STATES
////////////////////////////


//
// "ResetArms" sets the initial x/y/w/h of the arms to random values
//

float r(float min, float max) {
  return random(min,max);  
}


///////////////  SET TO FALSE TO DO RANDOM RESET
boolean RESET_STATIC = true;

class ResetArms extends AppState {
  ResetArms() {
     super("ResetArms"); 
  }

  void onStart(AppState lastState) {
    if (RESET_STATIC) {
      resetStatic();
    } else {
      resetRandom();
    } 
  }
  
  // reset arms with static values
  void resetStatic() {
    // reset red arm (lowest)
    redArm.reset( /*min size:  w,h */  .4,  .4,
                  /*max size:  w,h */   2,   2,
                  /*min dist:  x,y */ -.2, -.2,
                  /*max dist:  x,y */  .8,  .8 );

    // reset blue arm (middle)
    blueArm.reset( /*min size:  w,h */ -1, -1,
                   /*max size:  w,h */ 5, 5,
                   /*min dist:  x,y */ -1, -1,
                   /*max dist:  x,y */ 5, 5 );

    // reset green arm (top)
    greenArm.reset( /*min size:  w,h */ .5, .5,
                    /*max size:  w,h */ 2, 2,
                    /*min dist:  x,y */ 1, 1,
                    /*max dist:  x,y */ 5, 5 );
    
  }
  
  
  // reset arms with random values
  void resetRandom() {
    //   void reset(_minW, _minH, _maxW, _maxH, _minX, _minY, _maxX, _maxY)

    // reset red arm (lowest)
    redArm.reset( /*min size:  w,h */ r( .3, .5), r( .3, .5),
                  /*max size:  w,h */ r( .8,  2), r( .8,  2),
                  /*min dist:  x,y */ r(-.2, .2), r(-.2, .2),
                  /*max dist:  x,y */ r(-.8, .8), r(-.8, .8) );

    // reset blue arm (middle)
    blueArm.reset( /*min size:  w,h */ r(-1, 1), r(-1, 1),
                   /*max size:  w,h */ r(-5, 5), r(-5, 5),
                   /*min dist:  x,y */ r(-1, 1), r(-1, 1),
                   /*max dist:  x,y */ r(-5, 5), r(-5, 5) );

    // reset green arm (top)
    greenArm.reset( /*min size:  w,h */ r(.5, .2), r(.5, .2),
                    /*max size:  w,h */ r(.1, .3), r(.1, .3),
                    /*min dist:  x,y */ r(.5, .2), r(.5, .2),
                    /*max dist:  x,y */ r(.1, .3), r(.1, .3) );
  }
}


class Mode0Start extends AppState {
  boolean snapperWasDown = false;

  Mode0Start() {
    super("Mode0Start");
  }

  void onStart(AppState lastState) {
    snapperWasDown = false;
    redButton.flash(); 
    greenButton.flash(); 
    blueButton.flash(); 
    snapper.flash();
  }

  void onStop(AppState nextState) {
    redButton.lightOff(); 
    greenButton.lightOff(); 
    blueButton.lightOff();
    snapper.flash();
  }


  void checkControls() {
    updateRGBPhotos();

    if (redButton.isOn()) redButton.lightOn();
    else                  redButton.flash();

    if (greenButton.isOn()) greenButton.lightOn();
    else                    greenButton.flash();

    if (blueButton.isOn()) blueButton.lightOn();
    else                   blueButton.flash();

    if (snapper.isOn()) {
//        enterState("Mode0End");
      snapperWasDown = true;
    } 
    else {
      if (snapperWasDown) {
         enterState("Mode0End");
       }
    }
  }
}

class Mode0End extends AppState {
  boolean snapperWasDown = false;

  Mode0End() {
    super("Mode0End");
  }

  void onStart(AppState lastState) {
    snapperWasDown = false;
    snapper.flash();
  }

  void onStop(AppState nextState) {
    snapper.lightOff();
  }


  void checkControls() {
    if (snapper.isOn()) {
      snapperWasDown = true;
    } 
    else {
      if (snapperWasDown) {
        enterState("ResetArms");
        enterState("Mode0Start");
      }
    }
  } 

  void updateDisplay() {
    return;
  }
}



