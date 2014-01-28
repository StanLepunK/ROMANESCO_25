//GLOBAL
RomanescoSeven romanescoSeven ;
//Just in case you use a class must use an ArrayList in your object, if it's not call the class in the class RomanescoSeven just bellow



//SETUP
void romanescoSevenSetup() {
    //MUST CHANGE THE ID
  //Example : If it's RomanestoThirtySetup int ID = 30 ;
  int ID = 7 ; // 0 is Ref you must use a number is the order of apparition in the controleur, start from top left and follow the horizontal line
  
  int IDfamilly = 1 ; // 1 is single object // 2 is trame // 3 is typo    ....... // 0 is global don't use this one it's for specific stuff
  romanescoSeven = new RomanescoSeven (ID, IDfamilly) ;

  romanescoSeven.setting() ;
}

//DRAW
void romanescoSevenDraw(String [] dataControleur, String [] dataMinim) {
  romanescoSeven.getID() ;
  romanescoSeven.data(dataControleur, dataMinim) ;
  romanescoSeven.display() ;
}

//MOUSEPRESSED
void romanescoSevenMousepressed() { romanescoSeven.mousepressed() ; }
//MOUSERELEASED
void romanescoSevenMousereleased() { romanescoSeven.mousereleased() ; }
//MOUSE DRAGGED
void romanescoSevenMousedragged() { romanescoSeven.mousedragged() ; }
//KEYPRESSED
void romanescoSevenKeypressed() { romanescoSeven.keypressed() ; }
//KEY RELEASED
void romanescoSevenKeyreleased() { romanescoSeven.keyreleased() ; }

//Return the ID familly to choice the data must be send to the class // 0 is global // 1 is Object // 2 is trame // 3 is typo
int getFamillyRomanescoSeven() { return romanescoSeven.getIDfamilly() ; }

////////////
//CLASS////
//GLOBAL
// here you can put your array list for example

//////////////////////////////////////////
class RomanescoSeven extends SuperRomanesco 
{
  //FORBIDEN TO TOUCH
  int IDfamilly ;
  // CLASS_WITHOUT_ARRAYLIST class_without_arraylist 
  Spirale bezier ;
  //speed
  float speed ;
  //CONSTRUCTOR
  RomanescoSeven(int ID, int IDfamilly) {
    super(ID) ;
    this.IDfamilly = IDfamilly ;
  }
  //END CONSTRUCTOR
  
  ////SETUP
  /////////
  void setting() {
    //class
    bezier = new Spirale() ;
  }
  ///////////
  //END SETUP
  
  
  
  //////DRAW
  //display
  void display() {
    // starting position
    if (startingPosition[IDobj]) startPosition(IDobj, width/2, height/2, 0) ;
    
    pushMatrix() ;
    //P3D Give the position and the orientation of your object in the 3 dimensionals space
    P3Dmanipulation(IDobj) ;
    
    //curve / courbe
    float bezierPoint = valueObj[IDobj][24] *beat[IDobj] ;
    
    float b1 = (bezierPoint + (gauche[IDobj] *100)) *2.0 ;
    float b2 = (bezierPoint + (droite[IDobj] *100)) *2.0 ;
    float b3 = (bezierPoint + (gauche[IDobj] *100)) *2.0 ;
    float b4 = (bezierPoint + (droite[IDobj] *100)) *2.0 ;
    float b5 = (bezierPoint - (gauche[IDobj] *100)) *2.0 ;
    float b6 = (bezierPoint - (droite[IDobj] *100)) *2.0 ;
    float b7 = (bezierPoint - (gauche[IDobj] *100)) *2.0 ;
    float b8 = (bezierPoint - (droite[IDobj] *100)) *2.0 ;
    
    //vitesse / speed
    if (motion[IDobj]) speed  = valueObj[IDobj][16] *0.2 *tempo[IDobj] ; else speed = 0.0 ;
    //thickness
    int e = 1 + int(valueObj[IDobj][13]) ;
    
    //amplitude
    float ampB = map(valueObj[IDobj][16],0,100, -50, width *.5) ;
    int amp = int(ampB) ;
    //color
    color colorIn = color ( map(valueObj[IDobj][1],0,100,0,360), valueObj[IDobj][2], valueObj[IDobj][3],valueObj[IDobj][4] ) ;
    color colorOut = color ( map(valueObj[IDobj][5],0,100,0,360), valueObj[IDobj][6], valueObj[IDobj][7],valueObj[IDobj][8] ) ;
    //pos point of the shape
    PVector posBezier = new PVector (0,0) ;
    posBezier.x = (mouse[IDobj].x - (width /2))  *2 ;
    posBezier.y = (mouse[IDobj].y - (height /2)) *2  ;
    
    bezier.actualisation (mouse[IDobj].x , mouse[IDobj].y , speed) ;
    bezier.affichageBezier (colorIn, colorOut, posBezier, e, amp, b1, b2, b3, b4, b5, b6, b7, b8) ;
    
    //DON'T TOUCH
    popMatrix() ;
    //END OF DON'T TOUCH
  }
  //END DRAW
  
  //KEYPRESSED
  void keypressed() {}
  //KEY RELEASED
  void keyreleased() {}
  //MOUSEPRESSED
  void mousepressed() {}
  //MOUSE RELEASED
  void mousereleased() {}
  //MOUSE DRAGGED
  void mousedragged() {}
  
  
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
  //////////////////////////
}
