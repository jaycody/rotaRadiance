/*
##TODO:
 [x] get git working:
 1. [x]attach this local repository to the git repository
 2. []get the servers ssh code setup
 [] rather than high speed rotation for symetries.  Create the symmetries by RE-displaying each arm at (2*PI)/5 radians for 5 fold symmetry.  
 1. see John Whitney's demo http://www.youtube.com/watch?v=5eMSPtm6u5Y&sns=em
 2. let OHMITE be rotational velocity with easing, but only in 2*(2*PI) [2 complete circles]
 [] Use the code and technique from 'computational feedback loops' http://itp.nyu.edu/~js5346/jayblog/2012/04/20/computational-feedback-loops/
 [] use one knob to control the division of 2*PI / between 0-10, this will allow control over symmetries.  either that, or every restart is a new multiple.
 
 [] Added rounded rectangles via rect(x, y, w, h, radius) and rect(x, y, w, h, tl, tr, br, bl). 
 [] adjust the order of the worldMovers in loop to begin handle looping
 [] use easing from crossHairs project 
 [] update 'world' class to 
 [] Capture and organize SCREENSHOTS  
 [] clear screen
 [] use PVector for Translate (and eventually adding extra forces)
 [] Combine Sin/Cos with Perlin Noise to create additive waves:  see shiffman's additive wave example
 
 ______Add Sin/Cos from the Rotate 1 and 2 examples
 ______assign knobs to sin/cos
 ______smooth world rotation
 ______create PImage class
 ______import data file
 ______create Oscillator class
 ______create a Banking class
 
 
 
/* DONE: // the flipside of TODO_______________________________________________________
 [x] push changes
 [x] create World class
 [x] add openGL
 
 [x] setup to receive inputs from new controller (7 pots)
 [x] setup to receive inputs from Buttons (4)
 [x] control World class rotation with knob 3
 [x] make variables for the number of sensors for each controller
 [x] smooth the worldRotation using the averaging example from the Interactivity Book
 
 */
