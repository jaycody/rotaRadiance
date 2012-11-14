
class Knob {

  int knobCount;  //which knob is it (0-9);
  int knobVal;  //each Knob has a value

  Knob(int _knobCount, int _knobVal) {   //pass the knob info into here somehow   
    knobCount = _knobCount;  // pass this info into the object from the serial event.
    knobVal = _knobVal;
  }


  // create functions which answer requests from the image objects for Knob info
  float getKnobVal() {
    return knobVal;
  }


  // use this to get information from the for loop passing values
  void update(int _val) {
    knobVal= _val;
  }

  void display() {
    print(knobCount);
    print(" = ");
    print(knobVal);
    print ('\t');
  }
}

