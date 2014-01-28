//GLOBAL
int numObj = 99 ; // minimum 2 object because sur first Object is Zero and it use like ref. So the "1" is the real first object.

//var to init the data of the object when is switch ON for the first time
boolean initValueSlider [] = new boolean [numObj +1]  ;
boolean initValueMouse [] = new boolean [numObj +1]  ;
//parameter for the super class
float gauche[]  = new float [numObj +1] ;
float droite[] = new float [numObj +1] ;
float mix[]  = new float [numObj +1] ;
//beat
float beat[]  = new float [numObj +1] ;
float kick[]  = new float [numObj +1] ;
float snare[]  = new float [numObj +1] ;
float hat[]  = new float [numObj +1] ;
//tempo
float tempo[] = new float [numObj +1] ;
float tempoBeat[] = new float [numObj +1] ;
float tempoKick[] = new float [numObj +1] ;
float tempoSnare[] = new float [numObj +1] ;
float tempoHat[] = new float [numObj +1] ;
//meteo
PVector motionMeteo[] = new PVector[numObj +1]  ; // direction, speed
int tempMeteo [] = new int [numObj +1] ;
int humidityMeteo [] = new int [numObj +1] ;
int pressureMeteo [] = new int [numObj +1] ;
float visibilityMeteo [] = new float [numObj +1] ;

//P3D OBJECT
//position
boolean startingPosition [] = new boolean[numObj +1] ;
PVector startingPos [] = new PVector[numObj +1] ;
PVector P3Dposition [] = new PVector[numObj + 1] ;
PVector P3DpositionObjRef [] = new PVector[numObj + 1] ;
boolean P3DrefPos [] = new boolean[numObj +1] ;
//orientation
PVector P3Ddirection [] = new PVector[numObj + 1] ;
PVector P3DdirectionObjRef [] = new PVector[numObj + 1] ;
boolean P3DrefDir [] = new boolean[numObj +1] ;

//position of object and wheel
PVector mouse[]    = new PVector[numObj +1] ;
PVector pmouse[]    = new PVector[numObj +1] ;
boolean clickShortLeft[] = new boolean [numObj +1] ;
boolean clickShortRight[] = new boolean [numObj +1] ;
boolean clickLongLeft[] = new boolean [numObj +1] ;
boolean clickLongRight[] = new boolean [numObj +1] ;
boolean mousepressed[] = new boolean [numObj +1] ;
int wheel[] = new int [numObj + 1] ;
//pen info
PVector pen[]    = new PVector[numObj +1] ;
//boolean clear
boolean clearList[] = new boolean[numObj+1] ;
//motion object
boolean motion [] = new boolean [numObj +1]  ;
//to add new object
// boolean newObj[] = new boolean[numObj+1] ;
//main font for each object
PFont font[] = new PFont[numObj+1] ;
String pathFontObjTTF[] = new String[numObj+1] ;




////////////
//SUPER CLASS
class SuperRomanesco
{
  int IDobj ;
  float valueObj[][]  = new float[numObj] [numSliderFamilly] ;
  
  SuperRomanesco (int IDobj) {
    this.IDobj = IDobj ;
  }
  
  
  //DRAW
  void data(String [] d, String [] m) {
    
    float newWindDirection ;
    
    if ( mainButton[IDobj] == 1  ) {
      ///////////////////
      ///GLOBAL
      if ( parameterButton[IDobj] == 1 || !initValueSlider[IDobj] ) {
        valueObj[IDobj][1]  = float(d[1])   ; valueObj[IDobj][2]  = float(d[2])  ;  valueObj[IDobj][3]  = float(d[3])  ; valueObj[IDobj][4]  = float(d[4]) ;  valueObj[IDobj][5]  = float(d[5])  ;  valueObj[IDobj][6]  = float(d[6])  ; valueObj[IDobj][7]  = float(d[7])  ; valueObj[IDobj][8]  = float(d[8]) ;
        valueObj[IDobj][11] = float(d[11])  ; valueObj[IDobj][12] = float(d[12]) ;  valueObj[IDobj][13] = float(d[13]) ; valueObj[IDobj][14] = float(d[14]) ; valueObj[IDobj][15] = float(d[15]) ;  valueObj[IDobj][16] = float(d[16]) ; valueObj[IDobj][17] = float(d[17]) ; valueObj[IDobj][18] = float(d[18]) ;
        valueObj[IDobj][21] = float(d[21])  ; valueObj[IDobj][22] = float(d[22]) ;  valueObj[IDobj][23] = float(d[23]) ; valueObj[IDobj][24] = float(d[24]) ; valueObj[IDobj][25] = float(d[25]) ;  valueObj[IDobj][26] = float(d[26]) ; valueObj[IDobj][27] = float(d[27]) ; valueObj[IDobj][28] = float(d[28]) ;
        //after the first init, we don't need to init again the color when the setting button is off, so we say the init is true
        initValueSlider[IDobj] = true ;
      }
      
      //SOUND
      if (soundButton[IDobj] == 1 ) {
        
        beat[IDobj] = float(m[3]) ; 
        kick[IDobj] =  float(m[4]) ; 
        snare[IDobj] = float(m[5]) ; 
        hat[IDobj] = float(m[6]) ;
         //tempo
        tempo[IDobj] = getTempoRef() ;
        tempoKick[IDobj] = getTempoKickRef() ;
        tempoSnare[IDobj] = getTempoSnareRef() ;
        tempoHat[IDobj] = getTempoHatRef() ;
        //volume security value
        if (gauche[IDobj] == 0 ) gauche[IDobj] = 0.01 ;
        if (droite[IDobj] == 0 ) droite[IDobj] = 0.01 ;
        if (mix[IDobj] == 0 ) mix[IDobj] = 0.01 ;
        gauche[IDobj] = float(m[0]) ; droite[IDobj] = float(m[1]) ; mix[IDobj] = float(m[2]) ;
        
      } else {
        gauche[IDobj] = .05 ; droite[IDobj] = .05 ;  mix[IDobj] = .05 ;
        beat[IDobj] = 1.0 ; kick[IDobj] = 1.0 ; snare[IDobj] = 1.0 ; hat[IDobj] = 1.0 ;
        tempo[IDobj] = 1.0 ; tempoKick[IDobj] = 1.0 ; tempoSnare[IDobj] = 1.0 ; tempoHat[IDobj] = 1.0 ;
      }
      
      //ACTION
      if (actionButton[IDobj] == 1) {
        // motion
        if( mTouch ) motion[IDobj] = !motion[IDobj] ;
        // mouse
        clickShortLeft[IDobj]  = clickShortLeft[0] ;
        clickShortRight[IDobj] = clickShortRight[0] ;
        clickLongLeft[IDobj]  = clickLongLeft[0] ;
        clickLongRight[IDobj] = clickLongRight[0] ;
        mousepressed[IDobj] = mousepressed[0] ;
        
        if (spaceTouch || !initValueMouse[IDobj]) {
          pen[IDobj] = pen[0] ;
          mouse[IDobj] = PVector.sub(mouse[0],startingPos[IDobj]) ;
          pmouse[IDobj] = PVector.sub(pmouse[0],startingPos[IDobj]) ;
          wheel[IDobj] = wheel[0] ;
        } else {
          mouse[IDobj] = mouse[IDobj] ;
          pmouse[IDobj] = pmouse[IDobj] ;
          if (pen[IDobj].z == 0.0 ) pen[IDobj].z = 1.0 ;
          /*
          //this var is use for the miror and the scene because there is very strange problem
          mouse[IDobj] = mouseSuperRomanesco ;
          pmouse[IDobj] = pmouseSuperRomanesco ;
          */
         // the pressure of pen is between 0 and 1, so we must give a value in case if there is no pressure,
         // when the user go away from the space touch, for the tilt no probleme is stay in memory 
        }    
      }
      //METEO
      if(meteoButton[IDobj] == 1 ) {
        //meteo
        newWindDirection = weather.getWindDirection() +180  ;
        if (newWindDirection > 360 ) newWindDirection -= 360 ;
        motionMeteo[IDobj] = new PVector(newWindDirection, beaufort())  ; // direction, speed
        tempMeteo [IDobj] = weather.getTemperature() ;
        humidityMeteo [IDobj] =weather.getHumidity()  ;
        pressureMeteo [IDobj] = hectoPascal(weather.getPressure())  ;
        visibilityMeteo [IDobj] = weather.getVisibleDistance() ;
      } else {
        motionMeteo[IDobj] = new PVector(-1,-1)  ; // direction, speed
        tempMeteo [IDobj] = -274 ;
        humidityMeteo [IDobj] = -1 ; ;
        pressureMeteo [IDobj] = -1 ;
        visibilityMeteo [IDobj] = -1 ;
      }
      initValueMouse[IDobj] = true ;
      //END
      
    }
  }
}
////////////////////////
//END OF SUPER ROMANESCO

       
