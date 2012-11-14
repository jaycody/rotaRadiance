

// Current keyCode for the pressed key
int currentKey = -1;

// Remember the current key when it goes down.
void keyPressed() {
  currentKey = keyCode;
}

// Clear the current key when it goes up.
void keyReleased() {
  currentKey = -1;
}

// Clear the state of all of the buttons
void clearButtons() {
   redButton.setValue(0);
   greenButton.setValue(0);
   blueButton.setValue(0);
   snapper.setValue(0); 
}

void updateControlsFromKeyboard() {
  // if no key is currently down, make sure all of the buttons are up and bail  
  if (currentKey == -1) {
    clearButtons();
    return;
  }
  
  //saves an image everytime the ENTER is pressed.
  if (currentKey==ENTER) {
    saveFrame("screen-####.png");
    noCursor();
  } 
  else {
    //println(currentKey);rg
    cursor();
    // TAB key clears background (to black)
    if (currentKey==TAB) {
      background(0);
    } 
    
    // red button
    else if (currentKey == 'R') {
      redButton.setValue(1);
    }
    
    // red left knob
    else if (currentKey == 'W') {
      redLeft.decrease();  
    } else if (currentKey == 'E') {
      redLeft.increase();
    }
    
    // red right knob
    else if (currentKey == 'T') {
      redRight.decrease();  
    } else if (currentKey == 'Y') {
      redRight.increase();
    }
    
    // green button
    else if (currentKey == 'G') {
      greenButton.setValue(1); 
    } 
    
    // green left knob
    else if (currentKey == 'D') {
      greenLeft.decrease();  
    } else if (currentKey == 'F') {
      greenLeft.increase();
    }
    
    // green right knob
    else if (currentKey == 'H') {
      greenRight.decrease();  
    } else if (currentKey == 'J') {
      greenRight.increase();
    }

    
    // blue button
    else if (currentKey == 'B') {
      blueButton.setValue(1); 
    } 
    
    // blue left knob
    else if (currentKey == 'C') {
      blueLeft.decrease();  
    } else if (currentKey == 'V') {
      blueLeft.increase();
    }
    
    // blue right knob
    else if (currentKey == 'N') {
      blueRight.decrease();  
    } else if (currentKey == 'M') {
      blueRight.increase();
    }


    // ohm knob
    else if (currentKey == LEFT) {
       ohm.decrease(); 
    } else if (currentKey == RIGHT) {
       ohm.increase();
    }
    
    // snapper (space bar)
    else if (currentKey == ' ') {
      snapper.setValue(1);
    }
  }
}

