/*j.stephens
2012.11
A Variation of Kojo Opuni's Rotation sketch

separated rotational velocity from n-fold symmetry generation
*/


float i;
float a=0;  // rotation location
float delta = 0; // rotational velocity defined by the distance from width/2 where center = 0 velocity;

void setup() {
  size(800,800);
  smooth(); 
  noStroke(); 
  fill(150);
  background(255);
  ellipse (400,400,50,50);
 // frameRate(25);
  
}

void draw() {
  translate (400, 400); 
  for(i=0; i<100; i++)
  {
  smooth();
  //lower right
  arc (700,700,a+1,a,0,7);
  arc (750,750,mouseX+1,pmouseY,0,7);
  arc (650,650,a+1,a,0,7);
  arc (600,650,mouseY+1,a,0,7);
  arc (550,650,a+1,a,0,7);
 /*j: */ // rotate (radians(a/3));
 rotate (radians(a));
  //upper left
  if (mousePressed) {
    //stroke(mouseY);
    fill(mouseY-i,mouseX-i,mouseY+i/5,pmouseY);
    /*j:  original = 75.0 */ rotate(PI/150.0);
    beginShape ();
    vertex(mouseX+50,mouseY+50);
    vertex (pmouseX, pmouseY);
    vertex (mouseX+75, mouseY+75);
    vertex (pmouseX+50, pmouseX+50);
    endShape(CLOSE);
    
  }
  
  else {
  stroke(255*(mouseX/width),255*(mouseY/height),255*((mouseX-width)/width));
  //stroke(255,255,0);
  //fill(mouseX-i,mouseY-i,mouseX+i/5,pmouseX);
  //fill(255*(mouseX/width),255*(mouseY/height),255*((mouseX-width)/width));
  float r = map (mouseX, 0, width, 0, 255);
   float g = map (mouseY, 0, height, 255, 0);
    float b = map (mouseX, height, 0, 0, 255);
  fill(r,g,b,50+(delta*100));
  println(width);
  println(mouseX + "= mouseX");
  //****************Controlling the N-Fold Symmetry by Varying the division of 2PI**************
  //********************************************************************************************
  //try controlling the rotation of the world seperate from the division of 2*PI such that:
  float varPIdivisor = map (mouseY, 0, height, 0.0, 6.0);
  rotate ((2*PI)/varPIdivisor);
  /*J: original:: */   //rotate((2*PI)/6);//j: original PI/5
  /*dividing 2*PI by 4 results in 5 fold symmetry.  The image starts at original location, and is then rotated. */
  //____________________________________________________________________________
  
  triangle (mouseX,50,50,70,70,70);
  triangle (a,a,50,70,70,70);
  triangle (a,50,50,a,a,70);
  triangle (50,50,50,70,mouseX,a);
  triangle (50,a,50,a,70,70);
  ellipse (a,a,mouseY,a);
  arc (700,700,a,a,2,7);
  arc (750,750,pmouseX,a,2,7);
  arc (650,650,pmouseX,a,2,7);
  arc (600,650,a,a,2,7);
  arc (550,650,a,pmouseY,2,7);
  }
  } 
 /*j: */  // a+=.01;
 
/*j: */ delta = map (mouseX, 0, width, -1, 1);
//a = 0;
/*j: */ a += delta;
println("a = " + a + " delta = " + delta);
}

