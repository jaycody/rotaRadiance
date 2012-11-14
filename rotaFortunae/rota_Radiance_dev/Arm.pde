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
  float opacity;      // UNUSED:  0 = transparent, 1 = opaque
  
  Arm(String _name, Control _distanceControl, Control _sizeControl) {
   name = _name;
   distanceControl = _distanceControl;
   sizeControl = _sizeControl;
   switchPhoto();
  }   
 
  // Reset our max/min values to those passed in
  void reset(float _minW, float _minH, float _maxW, float _maxH, float _minX, float _minY, float _maxX, float _maxY) {
    minW = _minW;
    minH = _minH;
    minX = _minX;
    minY = _minY;

    maxW = _maxW;
    maxH = _maxH;
    maxX = _maxX;
    maxY = _maxY;
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
    PImage photo = angelCard[imageNum];
    
    float distanceMultiplier = getDistancePercent();
    float sizeMultiplier = getSizePercent();
   
    float centerX = SCREEN_WIDTH/2;
    float centerY = SCREEN_HEIGHT/2;
    
    int x = int(map(distanceMultiplier, 0, 1, minX, maxX) * centerX);
    int y = int(map(distanceMultiplier, 0, 1, minY, maxY) * centerY);
    int w = int(map(sizeMultiplier, 0, 1, minW, maxW) * centerX);
    int h = int(map(sizeMultiplier, 0, 1, minH, maxH) * centerY);
    
    println(name+"   x,y: "+x+", "+y+"    w,h: "+w+","+h+"    "+centerX+","+centerY);
 //   println(distanceMultiplier+"   "+sizeMultiplier);
    
   // image(photo, x, y, w, h);
    image(photo, x, y, w, h);
  }
}   


