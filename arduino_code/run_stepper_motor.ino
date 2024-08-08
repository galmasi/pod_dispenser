////////////////////////////////////////////////
// This code is copied and modified from
// https://cdn.velleman.eu/downloads/29/vma401_a4v01.pdf
//  (with thanks)
////////////////////////////////////////////////

//declare variables for the motor pins
int motorPin1 = 8; // Blue - 28BYJ48 pin 1
int motorPin2 = 9; // Pink - 28BYJ48 pin 2
int motorPin3 = 10; // Yellow - 28BYJ48 pin 3
int motorPin4 = 11; // Orange - 28BYJ48 pin 4
int sensorPin = 12;
int ledPin=13;


// Red - 28BYJ48 pin 5 (VCC)
int motorSpeed = 2000; //variable to set stepper speed
int countsperrev = 512; // number of steps per full revolution
int runtime = countsperrev  *  7  / 6; // our gear reduction ratio is 1 to 7, and we need to make a 30 degree angle per run

// status information
int runcount = runtime; // count of steps remaining while running
int stopcount = 0;   // this counts off to blink the LED when stopped
int run = 0;         // are we running right now?
int ledValue = 0;
int lookup[9] = {B01000, B01100, B00100, B00110, B00010, B00011, B00001, B01001,0};
//////////////////////////////////////////////////////////////////////////////
void setup() {
//declare the motor pins as outputs
  pinMode(motorPin1, OUTPUT);
  pinMode(motorPin2, OUTPUT);
  pinMode(motorPin3, OUTPUT);
  pinMode(motorPin4, OUTPUT);
  pinMode(sensorPin, INPUT);
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);
}
//////////////////////////////////////////////////////////////////////////////
void loop(){
  if (run) {
    anticlockwise();
    runcount--;
    if (runcount==0) {
      run = 0;
      runcount = runtime;
    }
  } else stopped();
  sampleInput();
}

//////////////////////////////////////////////////////////////////////////////
//set pins to ULN2003 high in sequence from 1 to 4
//delay "motorSpeed" between each pin setting (to determine speed)
void anticlockwise()
{
  ledValue=1;
  digitalWrite(ledPin, ledValue);
  for(int i = 0; i < 8; i++)
  {
    setOutput(i);
    delayMicroseconds(motorSpeed);
  }
}

// run the motor for 8 cycles
void clockwise()
{
  for(int i = 7; i >= 0; i--)
  {
    setOutput(i);
    delayMicroseconds(motorSpeed);
  }
}

// spend some amount of time with the motor stopped and all power off
void stopped()
{
  setOutput(8); // disable all steppers
  delayMicroseconds(motorSpeed*8);
  digitalWrite(ledPin, ledValue);
  if (stopcount-- <= 0) {
    stopcount=20;
    ledValue = !ledValue;
  }
}

// sample input and set "run" if the button is pressed
// the button is pulldown so input is low when pressed
void sampleInput()
{
  if (digitalRead(sensorPin) == 0) {
    run = 1;
  }
}


void setOutput(int out)
{
  digitalWrite(motorPin1, bitRead(lookup[out], 0));
  digitalWrite(motorPin2, bitRead(lookup[out], 1));
  digitalWrite(motorPin3, bitRead(lookup[out], 2));
  digitalWrite(motorPin4, bitRead(lookup[out], 3));
}
