/////////////////
//  APP STATES
/////////////////

class AppState {
  String name;           // name for this control

  AppState(String _name) {
    // Remember 
    name = _name;

    // add us to the map of app states
    StateMap.put(name, this);
  }

  // We've just entered this state
  void onStart(AppState lastState) {
    println("GENERIC onStart");
  }

  // We're exiting this state.
  void onStop(AppState nextState) {
  }

  // Adjust the UI according to the current state of the controls
  void checkControls() {
    updateRGBPhotos();
  }

  // Update the display for the current set of controls.
  // Default is to just redraw the arms.
  void updateDisplay() {
    updateArms();
  }

  //
  //  generic routines used by many states
  //

  // update the arm photos as the RGB buttons are pressed
  void updateRGBPhotos() {
    if (redButton.isOn()) redArm.switchPhoto();
    if (greenButton.isOn()) greenArm.switchPhoto();
    if (blueButton.isOn()) blueArm.switchPhoto();
    
    if (redButton.isOn() && greenButton.isOn() && blueButton.isOn()) {
       String lastState = CurrentState.name;
       enterState("ResetArms");
       enterState(lastState);
    } 
  } 

  // tell the arms to draw their current state
  void updateArms() {
    // display each arm
    for (int i = 0; i < arms.length; i++) {
      arms[i].display();
    }
  }
}


// current app state -- mediates how the controls affect the UI
AppState CurrentState;

// named map of app states
HashMap StateMap = new HashMap();

// return a state specified by name
AppState getState(String stateName) {
  AppState state = (AppState) StateMap.get(stateName);
  return state;
}

// enter a particular app state
void enterState(String stateName) {
  println("ENTERING STATE "+stateName); 

  AppState lastState = null;
  lastState = CurrentState;
  AppState nextState = getState(stateName);

  // tell the old state that it's time has come...
  if (lastState != null) lastState.onStop(nextState);

  // set up the new state
  nextState.onStart(lastState);

  // remember the current state
  CurrentState = nextState;
}




