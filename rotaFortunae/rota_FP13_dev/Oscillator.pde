/*
// Moves the World

class Oscillator {   

  PVector angle;
  PVector velocity;
  PVector amplitude;
  int layerNumber;  // like page number, but designates layers position in stack

  Oscillator() {   
    angle = new PVector();
    velocity = new PVector(random(-0.05, 0.05), random(-0.05, 0.05));
    amplitude = new PVector(random(width/2), random(height/2)); 
    layerNumber = int (random(4));  // use this to infor the random layer selection
  }   

  void oscillate() {
    angle.add(velocity);
  }   

  void display() {   

    float x = sin(angle.x)*amplitude.x;
    float y = sin(angle.y)*amplitude.y;

    //image(layer[3], 10, 10, mouseX*2, mouseY*2);//ORIGINAL 3 

    stroke(255, 0, 0);
    fill(255, 0, 0);

    image(layer[img], x, y, mouseX*2, mouseY*2);//ORIGINAL 3
  }
}   


*/

