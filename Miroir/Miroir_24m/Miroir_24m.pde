  ////////////////////////////////////////////////////////////////////////////
 // Romanesco Miroir Alpha 0.24 public release work with Processing 203  ////
////////////////////////////////////////////////////////////////////////////
boolean testRomanesco = true ;
// when you work only with "prescene", presceneOnly is true on Prescene sketch
//but in the Miroir and Scene sketch the boolean presceneOnly must be true for the final work.
boolean presceneOnly = true ;
//spectrum for the color mode and more if you need
PVector HSBmode = new PVector (360,100,100) ; // give the color mode in HSB
//path to open the controleur
String findPath ; 

void setup() {
  displaySetup() ;
  // Create syhpon server to send frames out.
  server = new SyphonServer(this, "Processing Syphon");
  //dropping image from folder on the Scène
  drop = new SDrop(this);

  fontSetup() ;
  //GEOMERATIVE
  RG.init(this);

  minimSetup() ;
  OSCSetup() ;
  meteoSetup() ;
  P3DSetup() ;

  //OBJECT SETTING
  romanescoSetup() ;
}

//DRAW
void draw() {
  initDraw() ;
  minimDraw() ;
  OSCDraw() ;
  meteoDraw() ;
  
  //START syphon
  beginMiroir() ;
  
  // romanesco
  backgroundRomanesco() ;
  cameraDraw() ; 
  romanescoDraw() ;
  stopCamera() ;
  
  nextPreviousKeypressed() ;
  curtain() ; 
  
  //true : display and send the canva to Syphon
  //false : just send the canvas to syphon
  endMiroir(true) ;
}
//END DRAW



/////KEY/////
//KEYPRESSED
void keyPressed () {
  if(key == 'i') controleur = !controleur ;
}
