class Oscillator {   

  PVector angle;
  PVector velocity;
  PVector amplitude;
  int randomLayerNumber;

  Oscillator() {   
    angle = new PVector();
    velocity = new PVector(random(-0.05, 0.05), random(-0.05, 0.05));
    amplitude = new PVector(random(width/2), random(height/2)); 
    randomLayerNumber = int (random(4));  // use this to infor the random layer selection
  }   

  void oscillate() {
    angle.add(velocity);
  }   

  void display() {   

    // Sin wave action____________________________________
    int x = int (cos(angle.x)*amplitude.x);
    int y = int (sin(angle.y)*amplitude.y);

    // Standard Movement
    // float x = amplitude.x;
    //float y = amplitude.y;

    /*
   // pushMatrix();
     image(layer[3], 10, 10, mouseX*2, mouseY*2);//ORIGINAL 3 
     //translate(width/2,height/2);
     stroke(255,0,0);
     fill(255,0,0);
     // draw circle and line
     //line(0,0,x,y);  
     //ellipse(x,y,26,26);  
     image(layer[img], x, y, mouseX*2, mouseY*2);//ORIGINAL 3 
     // popMatrix();
     */


//______________TEST
// blend(layer[0], x, y, mouseX/2, mouseY/2, x, y, displayWidth-mouseX, displayHeight-mouseY, LIGHTEST);
// layer[0].blend(layer[0], 0, 0, displayWidth, displayHeight, mouseX, mouseY, displayWidth-65, displayHeight-65, BLEND); // recursive
//______________TEST

//    image(layer[0], x, y, mouseX*2, mouseY*2);//ORIGINAL 3
//    image(layer[1], -10, -10, mouseY, mouseX);//ORIGINAL 4 inner extending out
//    image(layer[2], 0, 5, mouseX, mouseY/2);//ORIGINAL 5 inner circle
    
    //image(layer[2], mouseX/4, mouseY/4, mouseX, mouseY*2);//ORIGNIAL 6 yet not effect
    //layer[0].blend(layer[1], 10, 10, mouseX*2, mouseY*2, 0, 0, mouseX/2, mouseY/2, SUBTRACT);
    
    //test blend modes ADD, SUBTRACT, DARKEST, LIGHTEST. SOFT_LIGHT
     //   layer[1].blend(layer[2], -20, 10, mouseX, mouseY, 0, 0, mouseX/3, mouseY, LIGHTEST);//
    
//_____________TEST    
   // image(layer[0], mouseX-width/2, mouseY-height/2, width/2+(mouseX/5), height/4+(mouseX/10));  


/*
    //LOCKED
      //img.blend(x, y, width, height, dx, dy, dwidth, dheight, MODE)
      layer[0].blend(layer[0], 0, 0, width, height, mouseX, mouseY, width-65, height-65, BLEND);
      image(layer[0], -100, -100, width/2, height/2);//
      //rotate(radians(mouseX));
      layer[0].blend(layer[0], mouseX/4, mouseY/4, width-20, height+20, mouseX/4, mouseY/4, width-200+(mouseX/10), height-165, BLEND);
      image(layer[0], mouseX-width/2, mouseY-height/2, width/2+(mouseX/5), height/4+(mouseX/10));//
    // LOCKED
 */
  }
}   


