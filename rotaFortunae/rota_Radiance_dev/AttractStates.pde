
// Blue button flashing to get them to press it
class RedAttract extends AppState {
  boolean redWasOn; 
  RedAttract() {
    super("RedAttract");
  }

  void onStart(AppState lastState) {
    redWasOn = false;
    redButton.flash();
  }

  void onStop(AppState nextState) {
    redButton.lightOff();
  }

  void checkControls() {
    if (redButton.isOn()) {
      redWasOn = true;
      redButton.lightOn(); 
      redArm.switchPhoto();
    } 
    else if (redWasOn) {
      enterState("GreenAttract");
    }
  }
}



// Green button flashing to get them to press it
class GreenAttract extends AppState {
  boolean greenWasOn; 
  GreenAttract() {
    super("GreenAttract");
  }

  void onStart(AppState lastState) {
    greenWasOn = false;
    greenButton.flash();
  }

  void onStop(AppState nextState) {
    greenButton.lightOff();
  }

  void checkControls() {
    if (greenButton.isOn()) {
      greenWasOn = true;
      greenButton.lightOn(); 
      greenArm.switchPhoto();
    } 
    else if (greenWasOn) {
      enterState("BlueAttract");
    }
  }
}

// Blue button flashing to get them to press it
class BlueAttract extends AppState {
  boolean blueWasOn; 
  BlueAttract() {
    super("BlueAttract");
  }

  void onStart(AppState lastState) {
    blueWasOn = false;
    blueButton.flash();
  }

  void onStop(AppState nextState) {
    blueButton.lightOff();
  }

  void checkControls() {
    if (blueButton.isOn()) {
      blueWasOn = true;
      blueButton.lightOn(); 
      blueArm.switchPhoto();
    } 
    else if (blueWasOn) {
      enterState("RedAttract");
    }
  }
}

