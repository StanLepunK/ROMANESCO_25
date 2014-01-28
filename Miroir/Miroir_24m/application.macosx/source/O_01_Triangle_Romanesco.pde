RomanescoOne romanescoOne ;

//SETUP
void romanescoOneSetup() {
  //MUST CHANGE THE ID
  //Example : If it's RomanestoThirtySetup int ID = 30 ;
  int ID = 1 ; // 0 is Ref you must use a number is the order of apparition in the controleur, start from top left and follow the horizontal line
  int IDfamilly = 1 ; // 0 is global // 1 is single object // 2 is trame // 3 is typo
  romanescoOne = new RomanescoOne (ID, IDfamilly) ;
  romanescoOne.setting() ;
}

//DRAW
void romanescoOneDraw(String [] dataControleur, String [] dataMinim) {
  romanescoOne.getID() ;
  romanescoOne.data(dataControleur, dataMinim) ;
  romanescoOne.display() ;
}



//Return the ID familly to choice the data must be send to the class // 0 is global // 1 is Object // 2 is trame // 3 is typo
int getFamillyRomanescoOne() { return romanescoOne.getIDfamilly() ; }

////////////
//CLASS////
//GLOBAL
// here you can put your array list for example

//////////////////////////////////////////
class RomanescoOne extends SuperRomanesco 
{
  //FORBIDEN TO TOUCH
  int IDfamilly ;
  //END OF FORBIDEN ZONE
  
  /////////////////////////
  // YOUR VARIABLE OBJECT :
  Tri triangle1, triangle2 ;
  // END YOUR VARIABLE OBJECT
  ///////////////////////////
  
  
  //CONSTRUCTOR
  RomanescoOne(int ID, int IDfamilly) {
    super(ID) ;
    this.IDfamilly = IDfamilly ;
  }
  //END CONSTRUCTOR
  
  ////SETUP
  /////////
  void setting() {
    triangle1 = new Tri ();
    triangle2 = new Tri ();
  }
  ///////////
  //END SETUP
  
  
  
  //////DRAW
  float e ; 
  float vitesse ;
  //display
  void display()
  {
    //DON'T TOUCH
    pushMatrix() ;
    //P3D Give the position and the orientation of your object in the 3 dimensionals space
    P3Dmanipulation(IDobj) ;
    //END OF DON'T TOUCH
    
    //////////////////////
    //HERE IT'S FOR YOU
    
    //thickness / épaisseur
    if (soundButton[IDobj] != 0 ) e = map(valueObj[IDobj][13],0,100,0,height *.1) * abs(sq(mix[1]) *20) ; else e = map(valueObj[IDobj][13],0,100,0,height *.1) ;
    // speed
    if (soundButton[IDobj] != 0 ) {
      if (getTimeTrack() > 1 ) vitesse = valueObj[IDobj][16] * tempo[IDobj] *.3 ; else vitesse =  valueObj[IDobj][16] * .01 ;
    } else {
      vitesse = valueObj[IDobj][16] * .2 ;
    }
    float vX = vitesse ;
    float vY = vitesse ;
    
    color colorIn = color  (map(valueObj[IDobj][1],0,100,0,360), valueObj[IDobj][2], valueObj[IDobj][3],valueObj[IDobj][4] ) ;
    color colorOut = color (map(valueObj[IDobj][5],0,100,0,360), valueObj[IDobj][6], valueObj[IDobj][7],valueObj[IDobj][8] ) ;
    
    //DISPLAY
    triangle1.triangles(width, 0,  mouse[IDobj], 0, colorIn, colorOut, e, vX, vY ) ;
    triangle2.triangles(0, height, mouse[IDobj], 0, colorIn, colorOut, -e, vX, vY ) ;
    
    //IT'S THE END FOR YOU
    //////////////////////
    
    //DON'T TOUCH
    popMatrix() ;
    //END OF DON'T TOUCH
    
    ////////////////////////////////////////////////
    //ADD OBJECT from keyboard, press "N" for new one
    //to spawn one thing
    if(actionButton[IDobj] == 1 && nTouch) { /* yourList.add( new YourClass ()); */ }
    //to spaw few things, you can add a modulo if you want
    int spawnFrequency = 3 ; 
    if(actionButton[IDobj] == 1 && nLongTouch && frameCount % spawnFrequency == 0 ) { /* yourList.add( new YourClass ()); */ }
    //END ADD OBJECT
  }
  //END DRAW



  
  
  //ANNEXE VOID
  void annexe() {}
  
  
  
  
  
  /////////////////////////////
  //FORDIDEN TO TOUCH THIS VOID
  /////////////////////////////
  //DATA VOID
  void data( String [] dataControler, String [] dataMinin) {
    super.data(dataControler, dataMinin) ;
  }
  ////////////
  //Return ID
  int getID() {
    return IDobj ;
  }
  int getIDfamilly() {
    return IDfamilly ;
  }
  ///////////////////////////
}





//////////////
//CLASS TRIANGLE
class Tri
{
  float pX, pY ;
  float dirX = 1.0 ;
  float dirY = 1.0 ;
  float newVX, newVY ;
  
  Tri () {}


//Paramètre superClasse
  
   //.....Vitesse de déplacement des triangles
  void actualisation(float vitesseX, float vitesseY)
  {
    if (pX > width || pX < 0 ) { 
      dirX*=-1.0 ;
    }
    if (pY > height || pY < 0) { 
      dirY*=-1.0 ;
    }
    newVX = vitesseX *dirX  ;
    newVY = vitesseY *dirY  ;
    
    pX += newVX  ;
    pY += newVY  ;
  }
  
  
  //DISPLAY
  void triangles (int coteA, int coteB, PVector pos, int coteC, color cIn, color cOut, float e, float vitesseX, float vitesseY) {
    
    float marge = e ;  
    //check the opacity of color
    int alphaIn = (cIn >> 24) & 0xFF; 
    int alphaOut = (cOut >> 24) & 0xFF; 
    // to display or not
    if ( alphaIn == 0 ) miroir.noFill() ; else miroir.fill (cIn) ;
    if ( alphaOut == 0) {
      miroir.noStroke() ;
    } else {
      miroir.stroke ( cOut ) ;
     
      if (e < 0 ) e = abs(e) ;
      if( e < 0.1 ) e = 0.1 ; //security for the negative value
      
      miroir.strokeWeight (e) ;
    }
    
    //update
    actualisation(vitesseX, vitesseY) ;
    
    //display
    miroir.beginShape () ;
    miroir.strokeCap(ROUND);
    miroir.vertex (pos.x, pos.y);
    miroir.vertex (pX, coteB -marge) ;
    miroir.vertex (coteA +marge, coteB -marge ) ;
    miroir.vertex (coteA +marge, pY ) ;
    miroir.endShape(CLOSE) ;
  }
  
  
  
}
