/*
 * Switch test program
 */

int switchPin = 21; // Switch connected to digital pin 2
int switchPower = 32; //
int buttonBlueLight = 52; //going to transitor


void setup()                    // run once, when the sketch starts
{
  Serial.begin(9600);           // set up Serial library at 9600 bps
  pinMode(switchPin, INPUT);    // sets the digital pin as input to read switch
  pinMode(switchPower, OUTPUT);
  pinMode(buttonBlueLight, OUTPUT);
  
}


void loop()                     // run over and over again
{
  digitalWrite(switchPower, HIGH);
  digitalWrite(buttonBlueLight, HIGH);
  
  Serial.print("Read switch input: ");
  Serial.println(digitalRead(switchPin));    // Read the pin and display the value
  delay(100);
}
