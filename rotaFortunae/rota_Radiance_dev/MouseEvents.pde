void mousePressed() {
  redArm.switchPhoto();
  greenArm.switchPhoto();
  blueArm.switchPhoto();
  
/*
  // for each mousePress, we cycle through all layers and assign a random index # from angelCard array  
  for (int i=0; i<totalLayers;i++) {
    layer [i] = createImage (width, height, ARGB);
    int q = int(random(totalCards-1));
    layer [i] = angelCard[q].get();  //have to use get OR the changes to layer[i] apply to angelCard!!!
    //5 hours that took....
  }

*/
}

