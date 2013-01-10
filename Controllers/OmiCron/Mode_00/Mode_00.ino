/* VideoAlchemy_Controller
 2012.10::Radiance Art Gallery Project
 JasonStephens and Michael Colombo
 
 Mode_00: 
   buttonLights = ON
   
 TODO:
 [ ] comment out all serial.prints except for 1, in order to test the serial system check in processing.
 
 */
 
//LIGHTS and POTENTIOMETERS_______________________________________________________________________
// 50-53 Digital Pins for the button lights
const int buttonRedLight =  50;// the number of the LED pin
const int buttonGreenLight =  51;
const int buttonBlueLight =  52;
const int buttonStarLight =  53;
//34-40 digital outs to power the potentiometers
int buttonRedPot1_Power = 34;
int buttonRedPot2_Power = 35;
int buttonGreenPot1_Power = 36;
int buttonGreenPot2_Power = 37;
int buttonBluePot1_Power = 38;
int buttonBluePot2_Power = 39;
int ohMitePot_Power = 40;
//A1-A7 analog reads from potentiometers
int buttonRedPot1Read = A12;
int buttonRedPot2Read = A1;
int buttonGreenPot1Read = A2;
int buttonGreenPot2Read = A3;
int buttonBluePot1Read = A4;
int buttonBluePot2Read = A5;
int ohMitePotRead = A6;
// variables to hold the values of each pot
int buttonRedPot1Value = 0;
int buttonRedPot2Value = 0;
int buttonGreenPot1Value = 0;
int buttonGreenPot2Value = 0;
int buttonBluePot1Value = 0;
int buttonBluePot2Value = 0;
int ohMitePotValue = 0;

// SWITCHES_________________________________________________________________________________________________
// 18-21 digital inputs from the buttons
int buttonRed = 18;
int buttonGreen = 19;
int buttonBlue = 20;
int buttonStar = 21;

// int to hold the values of the button states
int buttonRedState = LOW;
int buttonGreenState = LOW;
int buttonBlueState = LOW;
int buttonStarState = LOW;


void setup() {
  // start serial communication
  Serial.begin(9600);

  //LIGHTS_______________________________________________________________________________________________
  // set the digital pin as output to power the lights inside the buttons:
  pinMode(buttonRedLight, OUTPUT); 
  pinMode(buttonGreenLight, OUTPUT);      
  pinMode(buttonBlueLight, OUTPUT);      
  pinMode(buttonStarLight, OUTPUT);  
  
  //POTS________________________________________________________________________________________________
  // set the digital pins as output to power the potentiometers
  pinMode (buttonRedPot1_Power, OUTPUT); 
  pinMode (buttonRedPot2_Power, OUTPUT); 
  pinMode (buttonGreenPot1_Power, OUTPUT); 
  pinMode (buttonGreenPot2_Power, OUTPUT); 
  pinMode (buttonBluePot1_Power, OUTPUT); 
  pinMode (buttonBluePot2_Power, OUTPUT); 
  pinMode (ohMitePot_Power, OUTPUT); 

//SWITCHES_______________________________________________________________________________________________
  // set the inputs from the switches digital inputs
  pinMode(buttonRed, INPUT);
  pinMode(buttonGreen, INPUT);
  pinMode(buttonBlue, INPUT);
  pinMode(buttonStar, INPUT);

}

void loop()
{
  //LIGHTS_______________________________________________________________________________________________
  // set buttonLIGHTS to HIGH to turn ON the Lights inside the butttons
  digitalWrite(buttonRedLight, HIGH);
  digitalWrite(buttonGreenLight, HIGH);
  digitalWrite(buttonBlueLight, HIGH);
  digitalWrite(buttonStarLight, HIGH);
  
  //POTENTIOMETERS_______________________________________________________________________________________
  // set the Potentiometer Power Sources to HIGH
  digitalWrite(buttonRedPot1_Power, HIGH);
  digitalWrite(buttonRedPot2_Power, HIGH);
  digitalWrite(buttonGreenPot1_Power, HIGH);
  digitalWrite(buttonGreenPot2_Power, HIGH);
  digitalWrite(buttonBluePot1_Power, HIGH);
  digitalWrite(buttonBluePot2_Power, HIGH);
  digitalWrite(ohMitePot_Power, HIGH);
  
  // read the Potentiometer Analog ins and store the values into variables
  buttonRedPot1Value = analogRead(buttonRedPot1Read);
  buttonRedPot2Value = analogRead(buttonRedPot2Read);
  buttonGreenPot1Value = analogRead(buttonGreenPot1Read);
  buttonGreenPot2Value = analogRead(buttonGreenPot2Read);
  buttonBluePot1Value = analogRead(buttonBluePot1Read);
  buttonBluePot2Value = analogRead(buttonBluePot2Read);
  ohMitePotValue = analogRead(ohMitePotRead);

  //SWITCHES___________________________________________________________________________________________
  // read the state of the button and store it into the value.
  buttonRedState = digitalRead(buttonRed);
  buttonGreenState = digitalRead(buttonGreen);
  buttonBlueState = digitalRead(buttonBlue);
  buttonStarState = digitalRead(buttonStar);

  

  //Serial.print("buttonRedPot1Value = ");
  Serial.print("");
  Serial.print(buttonRedPot1Value);
  Serial.print(",");
  // Serial.print(" buttonRedPot2Value = ");
  Serial.print(buttonRedPot2Value);
  Serial.print(",");
  // Serial.print(" buttonGreenPot1Value = ");
  Serial.print(buttonGreenPot1Value);
  Serial.print(",");
  //Serial.print(" buttonGreenPot2Value = ");
  Serial.print(buttonGreenPot2Value);
  Serial.print(",");
  //Serial.print(" buttonBluePot1Value = ");
  Serial.print(buttonBluePot1Value);
  Serial.print(",");
  // Serial.print(" buttonBluePot2Value = ");
  Serial.print(buttonBluePot2Value);
  Serial.print(",");
  // Serial.print(" ohMitePotValue = ");
  Serial.print(ohMitePotValue);
  Serial.print(",");
  Serial.print(buttonRedState);
  Serial.print(",");
  Serial.print(buttonGreenState);
  Serial.print(",");
  Serial.print(buttonBlueState);
  Serial.print(",");
  Serial.println(buttonStarState);

  //delay in case things get crazy man
  delay(100);
}



