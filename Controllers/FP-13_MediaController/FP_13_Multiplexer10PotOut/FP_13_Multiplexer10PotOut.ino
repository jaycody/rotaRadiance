/* FP_13 Media Controller by JaiTronik 
 2011.12 ITP
 
 The Name_________________________________
 The F-P13 derives its name from the current possibility
 that 13 may be (P)regnant with (F)lynn.
 
 The Circuit______________________________
 Arduino UNO
 10 Potentiometers:    
 8 Pots wired to a 4051B Single 8-Channel Analog Multiplexer (to pin 3)
 2 Pots wired Analog Pins 4,5
 
 Purpose__________________________________
 Provide a control mechanism for the PImage PatternLanguage
 Processing sketch
 */

int sensorValue [10];  // an array to store the values of all 10 pots
int analogInput = 3; // this is where it all comes into Arduino from the mult

//setup for automating  the digitalPin reading from 3,4,5
int firstAddressPin = 3;


//taking care of the extra 2 pots
int pot8 = 5;
int pot8Val = 0;
int pot9 = 4;
int pot9Val = 0;

void setup () {
  //start serial communication 
  Serial.begin (9600);

  //Loop through all OUTPUT PINS from 3-4, set as OUTPUT, set as LOW
  for (int pinNumber = firstAddressPin; pinNumber < firstAddressPin + 3 ; pinNumber++) {
    pinMode (pinNumber, OUTPUT);
    //digitalWrite(pinNumber, LOW);  
  }
}

void loop() {

  //read Pots 8 and 9 sepearate from the multiplexer
  pot8Val = analogRead(pot8);
  pot9Val = analogRead(pot9);

  //Loop through all 8 of the incoming signals from the Multiplexer
  for (int thisChannel = 0; thisChannel < 8 ; thisChannel ++) {
    setChannel (thisChannel);  // A method that does something, I'm not sure of

    // read the analog input and store it in the value array
    sensorValue [thisChannel] = analogRead (analogInput);
    delay (10); // why??

    // print the value as a single tab-separated line:
    Serial.print(sensorValue [thisChannel], DEC);
    Serial.print(",");  // this comma is the sign required by processing to divide up the goods
  }

  //print a linefeed and carriage return once for loop cycles through
  Serial.print(pot8Val, DEC);
  Serial.print(",");

  Serial.print(pot9Val, DEC);
  Serial.print(",");
  Serial.println();
}


/* create the "setChannel" method to set the Multiplexers Binary Address Pins.
 This determines which Potentiometer is read
 */
void setChannel(int whichChannel) {
  for (int bitPosition = 0; bitPosition < 4; bitPosition++) {
    // shift value x bits to the right, and mask all but bit 0:
    int bitValue = (whichChannel >> bitPosition) & 1;
    // set the address pins:
    int pinNumber = firstAddressPin + bitPosition;
    digitalWrite(pinNumber, bitValue);
  }
}









