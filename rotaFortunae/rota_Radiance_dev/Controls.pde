// constants for button state
int ON = 1;
int OFF = 0;

// constant for LEDState
int DARK = 0;
int FLASH = 1;
int LIGHT = 2;



class Control {
  String name;           // name for this control
  int inputPin = 0;      // input pin for the control
  int outputPin = 0;     // output in for the control
  int value = 0;         // current value
  int minValue = 0;      // minimum value  (make sure to set this at the head of your constructor)
  int maxValue = 0;      // maximum value  (make sure to set this at the head of your constructor)
  int LEDValue = DARK; // current value of our light pin       
  
  Control(String _name, int _initialValue, int _minValue, int _maxValue) {
    // what's my name, bitch?
    name = _name;
    
    // assume no input and output pins from aduino
    inputPin = -1;
    outputPin = -1;
    
    // remember min and max
    minValue = _minValue;
    maxValue = _maxValue;
    
    // set our initial value
    value = validate(_initialValue); 
    
    // add me to the controls list
    controls[CONTROL_NUM++] = this; 
    // add me to the controls map
    controlMap.put(name, this);
  }

    // Return the current value as a float percentage of 0 - 1
  float asPercentage() {
    return float(value) / float(maxValue);
  }
  

  // Change the value of the control, making sure the value is valid.
  int setValue(int newValue) {
    value = validate(newValue);
    return value;
  }
  
  // validate the current value
  //   use this after manipulating the value to ensure it's always in range.
  int validate(int newValue) {
    if (newValue < minValue) newValue = minValue;
    if (newValue > maxValue) newValue = maxValue;
    return newValue;
  }

  // return the value of this control as a nicely formatted string
  String asString() {
      return padInt(value);
  }
  
  
  // manipulate our LEDs
  
  // steady on
  void lightOn() {
    LEDValue = LIGHT;
     // TODO: actually activate the pins to turn on!
  }
  
  // steady off
  void lightOff() {
    LEDValue = DARK;
    // TODO: actually activate the pins to turn off!
  }
  
  // start flashing
  void flash() {
    LEDValue = FLASH;
    // TODO: actually activate the pins to turn flash!
  }
  
  String LEDAsString() {
    if (LEDValue == LIGHT) return "LIGHT";
     if (LEDValue == DARK)  return " DARK";
     return "FLASH";
  }
  
  
  //
  // update from our sensors
  //
  void updateFromSensor(int sensorValue) {
    setValue(sensorValue);
  }

  // print a debug message for the control
  void debug() {
     println("  "+name+" = "+asString()); 
  }  
}




//////////////////////
//  BUTTON CLASS
//////////////////////

class Button extends Control {
  Button(String _name, int _initialValue) {
     super(_name, _initialValue, OFF, ON);
  }   

  void updateFromSensor(int sensorValue) {
 //   println(name+":"+sensorValue);
    setValue(sensorValue);
  }

  // Are we turned on?
  boolean isOn() {
    return (value == ON); 
  }
  
  String asString() {
      return (value == ON ? "  ON" : " OFF");
  }
}  



///////////////////////////
//  POTENTIOMETER CLASS
///////////////////////////

int INCREASE_DELTA = 1;
int DECREASE_DELTA = -1;

class Potentiometer extends Control {   
  int[] samples;
  int currentSample;
  
  Potentiometer(String _name, int _initialValue) {
     super(_name, _initialValue, 0, 1023);
     samples = new int[SAMPLE_COUNT];
     currentSample = 0;
  }
  
  
  // When the sensor value changes, set our new value to a running average of the last few values.
  //  This should smooth out the change in a pleasing way...
  void updateFromSensor(int sensorValue) {
    samples[currentSample++] = sensorValue;
    if (currentSample >= SAMPLE_COUNT) currentSample = 0;
    
    int totalValue = 0;
    for (int i = 0; i < SAMPLE_COUNT; i++) {
      totalValue += samples[i];  
    }
    int averageValue = totalValue / SAMPLE_COUNT;
    setValue(averageValue);
  }

  
  // increase the value of the potentiometer by delta
  void increase() {
    setValue(value + INCREASE_DELTA);
  }
  
  // decrease the value of the potentiometer by delta
  void decrease() {
    setValue(value + DECREASE_DELTA);
  }
}  


void debugControls() {
   println("");
   if (CurrentState != null) {
     println(" Current state: "+CurrentState.name);
   }
   println("            left   button    right        LED");
   println("          -----------------------------------");
   println("    RED     "+redLeft.asString()+"    "+redButton.asString()+"     "+redRight.asString()+"        "+redButton.LEDAsString());
   println("  GREEN     "+greenLeft.asString()+"    "+greenButton.asString()+"     "+greenRight.asString()+"        "+greenButton.LEDAsString());
   println("   BLUE     "+blueLeft.asString()+"    "+blueButton.asString()+"     "+blueRight.asString()+"        "+blueButton.LEDAsString());
   println("SNAPPER              "+snapper.asString()+"                  "+snapper.LEDAsString());
   println("    OHM     "+ohm.asString()+"                         "+ohm.LEDAsString());
   println("          -----------------------------------");
}


