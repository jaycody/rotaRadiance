float i;
float a=50;

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
  rotate (radians(a/3));
  //upper left
  if (mousePressed) {
    stroke(mouseY);
    fill(mouseY-i,mouseX-i,mouseY+i/5,pmouseY);
    rotate(PI/75.0);
    beginShape ();
    vertex(mouseX+50,mouseY+50);
    vertex (pmouseX, pmouseY);
    vertex (mouseX+75, mouseY+75);
    vertex (pmouseX+50, pmouseX+50);
    endShape(CLOSE);
    
  }
  
  else {
  stroke(mouseX);
  fill(mouseX-i,mouseY-i,mouseX+i/5,pmouseX);
  rotate(PI/50.0);
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
  a+=.01;

}

