
  //////////////////////////////////////////////////////////////////
 // Romanesco Unu 1.1.0 / version 27 / made with Processing 305 ///
//////////////////////////////////////////////////////////////////
/* 14.500 lines of code the 4th may 2015 !!!! */
String version = ("27") ;
String IAM = ("Prescene") ;
String prettyVersion = ("1.1.0") ;
String nameVersion = ("Romanesco Unu") ;
String preferencesPath = sketchPath("")+"preferences/" ;
//to work in dev, test phase
boolean testRomanesco = false ;

/*
Use true when you want 
display color
used sound
 maximum possibility of the object
 full frame rate
*/
boolean fullRendering = false ;

  
void setup() {
  if(fullRendering) frameRateRomanesco = 60 ; else frameRateRomanesco = 15 ;
  displaySetup(frameRateRomanesco) ; // the int value is the frameRate
  RG.init(this);  // Geomerative
  // common setup
  romanescoSetup() ;
  createVar() ;
  //specific setup
  presceneSetup() ; // the varObject setup of the Scene is more simple
  leapMotionSetup() ;
  OSCSetup() ;
  //common setup
  colorSetup() ;
  miroirSetup() ;
  varObjSetup() ;
  fontSetup() ;
  // here we ask for the testRomanesco true, because the Minim Library talk too much in the consol
  if(fullRendering && !testRomanesco) soundSetup() ;
  P3DSetup(modeP3D, numObj, numSettingCamera, numSettingOrientationObject) ;
}



//DRAW
void draw() {
  frame.setTitle(nameVersion + " " +prettyVersion+"."+version+ " | Préscène | FPS: "+round(frameRate));
  //setting
  initDraw() ;
  miroirDraw() ;
  // here we ask for the testRomanesco true, because the Minim Library talk too much in the consol
  if(fullRendering && !testRomanesco) soundDraw() ;
  updateVarRaw() ;
  OSCDraw() ;
  backgroundRomanesco() ;
  updateCommand() ;
  leapMotionUpdate() ;
  loadPrescene() ;
  
  //ROMANESCO
  cameraDraw() ;
  lightPosition() ;
  //use romanesco object
  romanescoManager.displayObject(ORDER_ONE, ORDER_TWO, ORDER_THREE) ;
  if(modeP3D) createGridCamera() ;
  stopCamera() ;
  
  //annexe
  info() ;
  if(fullRendering && !testRomanesco) curtain() ;
  
  // misc
  updateVarTemp() ;
  cursorDraw() ;

  // change to false if the information has be sent to Scene...but how ????
  keyboardFalse() ;
  
  opening() ;
}
//END DRAW









// MOUSE EVENT 
////////////////////

// MOUSEPRESSED
void mousePressed() {
  if(mouseButton == LEFT ) { 
    clickShortLeft[0] = true ; 
    clickLongLeft[0] = true ;
  }
  if (mouseButton == RIGHT ) {
    clickShortRight[0] = true ; 
    clickLongRight[0] = true ;
  }
}

//MOUSE RELEASED
void mouseReleased() {
  clickLongLeft[0] = false ; 
  clickLongRight[0] = false ;
}

// Mouse in or out of the sketch
public void mouseEntered(MouseEvent e) {
  MOUSE_IN_OUT = true ;
}

public void mouseExited(MouseEvent e) {
  MOUSE_IN_OUT = false ;
}



//MOUSE WHEEL
void mouseWheel(MouseEvent event) {
  wheel[0] = event.getCount() *speedWheel ; 
}
//END MOUSEWHEEL


/////KEY/////
//KEYPRESSED
void keyPressed () {
  shortCutsPrescene() ;
  nextPreviousKeypressed() ;
  keyboardTrue() ;

}
//END KEYPRESSED


//KEYRELEASED
void keyReleased() {
  //special touch need to be long
  keyboardLongFalse() ;
  keyboard[keyCode] = false ;
}
//END KEYRELEASED
