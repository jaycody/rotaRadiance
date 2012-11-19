class Arm {   
  String name;
  
  Control distanceControl;  // Control which provides our distance multiplier
  Control sizeControl;      // Control which provides our size multiplier
  
  int imageNum;       // index of the image we're displaying

  float minX;           // delta x from world center point if potentiometer at 0
  float minY;           // delta y from world center point if potentiometer at 0
  float minW;         // image percent of screen size if potentiometer at 0
  float minH;         // image percent of screen size if potentiometer at 0

  float maxX;           // delta x from world center point if potentiometer at max
  float maxY;           // delta y from world center point if potentiometer at max
  float maxW;         // image percent of screen size if potentiometer at max
  float maxH;         // image percent of screen size if potentiometer at max

  float angle;        // angle of top-left point of image from it's (x,y) as (top,left)
  int opacity;      // UNUSED:  0 = transparent, 1 = opaque
  
   float widthScalar;
   float heightScalar;
  
  
  Arm(String _name, Control _distanceControl, Control _sizeControl, int _opacity) {
   name = _name;
   distanceControl = _distanceControl;
   sizeControl = _sizeControl;
   opacity = _opacity;
   switchPhoto();
   
   widthScalar = random (1,4);
   heightScalar = random (1,4);
  
  }   
 
  // Reset our max/min values to those passed in
  void reset(float _minW, float _minH, float _maxW, float _maxH, float _minX, float _minY, float _maxX, float _maxY, float _angle) {
    minW = _minW;
    minH = _minH;
    minX = _minX;
    minY = _minY;

    maxW = _maxW;
    maxH = _maxH;
    maxX = _maxX;
    maxY = _maxY;
    
    angle = _angle;
  }
  
  // Return the value of our distance control as a percentage 0-1.
  // Returns 1 if distanceControl isn't set.
  float getDistancePercent() {
    if (distanceControl != null) return distanceControl.asPercentage();
    return 1; 
  }

  // Return the value of our size control as a percentage 0-1.
  // Returns 1 if sizeControl isn't set.
  float getSizePercent() {
    if (sizeControl != null) return sizeControl.asPercentage();
    return 1; 
  }
 
  void switchPhoto() {
    imageNum = int(random(totalCards-1));
    println("Switching photo for "+name+" arm to "+imageNum);
  }

  void display() {   
    PImage photo = getAngelCard(imageNum);
    
    float distanceMultiplier = getDistancePercent();
    float sizeMultiplier = getSizePercent();
   
    float centerX = SCREEN_WIDTH/2;
    float centerY = SCREEN_HEIGHT/2;
    
    int x = int(map(distanceMultiplier, 0, 1, minX, maxX) * centerX);
    int y = int(map(1-distanceMultiplier, 0, 1, minY, maxY) * centerY);
    int w = int(map(sizeMultiplier, 0, 1, minW, maxW) * centerX);
    int h = int(map(1-sizeMultiplier, 0, 1, minH, maxH) * centerY);
    
    println("  "+name+"   x,y: "+padInt(x)+", "+padInt(y)+"     w,h: "+padInt(w)+","+padInt(h));
 //   println(distanceMultiplier+"   "+sizeMultiplier);
   
    // rotate each individual arm a little bit separately
    rotate(angle);
   
    // set opacity 
    tint(255, opacity);
    // draw image at specified size
   
  // image(photo, x, y, w, h);
 /*  
     beginShape(); //was 'beginShape'
  texture(photo);
  vertex((x*heightScalar), (y*widthScalar), 0, 0);
  vertex(x +w, h+w, photo.width, 0);
  vertex((x+w)*2, y+h*heightScalar, photo.width, photo.height);
  vertex(x+w, (y+h), 0, photo.height);
  endShape(CLOSE);
  */
    
     beginShape(); //was 'beginShape'
  texture(photo);
  vertex(x*heightScalar, y*widthScalar, 0, 0);
  vertex(x +w, y*(1.5), photo.width, 0);
  vertex(x+w*widthScalar, y+h*heightScalar, photo.width, photo.height);
  vertex((x+w), (y+h), 0, photo.height);
  endShape(CLOSE);
  
  
    // reset opacity for next time
    tint(255, 255);
  }
}   


