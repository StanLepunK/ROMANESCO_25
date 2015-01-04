// HIGH VAR///////////////////////
// GLOBAL SETTING ////

import java.net.*;
import java.io.*;
import java.util.*;
import java.awt.*;
import java.util.Iterator;
import java.lang.reflect.*; 

import codeanticode.gsvideo.*;
import oscP5.*;
import netP5.*;
import processing.net.*;
import processing.pdf.*;
//FLUX RSS or TWITTER ????
import com.sun.syndication.feed.synd.*;
import com.sun.syndication.io.*;
//SOUND
import ddf.minim.*;
import ddf.minim.analysis.*;
//GEOMERATIVE
import geomerative.*;
//TOXIC
import toxi.geom.*;
import toxi.geom.mesh2d.*;
import toxi.util.*;
import toxi.util.datatypes.*;
import toxi.processing.*;
// METEO
import com.onformative.yahooweather.*;
// DROP IMAGE
import sojamo.drop.*;
//CALLING class or library in Other Class, you must call the PApplet too in your class

PApplet callingClass = this ;
// use for the border of window (top and right)
java.awt.Insets insets; 







Boolean videoSignal = false ;
//variable for the tracking
Boolean nextPrevious = false ;
int nextPreviousInt = 0 ; // for send to Syphon
int trackerUpdate ; // must be reset after each use
//spectrum for the color mode and more if you need
PVector HSBmode = new PVector (360,100,100) ; // give the color mode in HSB
//path to open the controleur
String findPath ; 









// to drop load image
SDrop drop;
boolean resizableByImgDrop ;



// HIGH VAR
boolean modeP3D, modeP2D, modeOPENGL, modeClassic ;
//spectrum band
int numBand = 16 ;
//font
int numFont = 50 ;
//quantity of group object slider
int numGroup = 3 ;

int numSliderGroupZero = 14 ;
int numSlider = 30 ;

int numButtonGlobal = 21 ; // group zero
int numButtonObj  ; // group one, two and three

//VAR
int numObj ;
Table indexObjects ;
TableRow [] rowIndexObject ;
//MISC var
//info object
String [] objectInfo, objectName ;
int [] objectID ;
boolean [] objectInfoDisplay ;
//for the leap motion ?
int objectLeapID[] ;
//BUTTON CONTROLER
boolean objectParameter[] ;

//VAR object
//raw
color [] fillRaw, strokeRaw ;
float [] thicknessRaw ; 
float [] sizeXRaw, sizeYRaw, sizeZRaw, canvasXRaw, canvasYRaw, canvasZRaw ;
float [] speedRaw, forceRaw, directionRaw, angleRaw ;
float [] familyRaw, quantityRaw, lifeRaw, analyzeRaw, amplitudeRaw;
//add in the next version when there is 30 slider by group
//future slider available now ;
float []fontSizeRaw ;
//for the next relase
float [] curveRaw, attractionRaw ;

//object
color [] fillObj, strokeObj ;
float [] thicknessObj ;
float [] sizeXObj, sizeYObj, sizeZObj, canvasXObj, canvasYObj, canvasZObj ;
float [] speedObj, forceObj, directionObj, angleObj ;
float [] familyObj, quantityObj, lifeObj , analyzeObj, amplitudeObj;
//add in the next version when there is 30 slider by group
//future slider available now ;
float []fontSizeObj ;
//for the next relase
float []curveObj, attractionObj ;
//font
PFont police ;



//OSC VAR
// button
int eBeat, eKick, eSnare, eHat, eCurtain, eBackground ;
int eLightOne, eLightTwo, eLightOneAction, eLightTwoAction ;
int whichShader ; 
int [] whichImage, whichText ;
int [] objectButton,soundButton, actionButton, parameterButton ;
boolean [] object, sound, action, parameter ;

int mode[]  ;

//BUTTON
int [] valueButtonGlobal, valueButtonObj  ;
//SLIDER
String valueSliderTemp[][]  = new String [numGroup+1][numSlider] ;
float valueSlider[][]  = new float [numGroup+1][numSlider] ;


//MISC
//var to init the data of the object when is switch ON for the first time
boolean  [] initValueMouse, initValueControleur ;
//parameter for the super class
float [] left, right, mix ;
//beat
float [] beat, kick, snare, hat ;
// spectrum
float band[][] ;
//tempo
float [] tempo, tempoBeat, tempoKick, tempoSnare, tempoHat ;


//P3D OBJECT
//setting and save
int numSettingCamera, numSettingOrientationObject ;
PVector [][] P3DpositionSetting, P3DdirectionSetting ;
PVector [] eyeCameraSetting, sceneCameraSetting ;
//position
PVector startingPosition [] ;
float [] P3DpositionX, P3DpositionY, P3DpositionZ ;

PVector P3DpositionObjRef [] ;
boolean P3DrefPos [] ;
PVector [] posManipulation, dirManipulation ;
//orientation
float [] P3DdirectionX, P3DdirectionY ;
//PVector P3Ddirection [] ;
PVector P3DdirectionObjRef [] ;
boolean P3DrefDir [] ;

//position of object and wheel
PVector [] mouse, pmouse, pen ;
boolean [] clickShortLeft, clickShortRight, clickLongLeft, clickLongRight, mousepressed ;
int wheel[] ;
//pen info

//boolean object
boolean [] motion, horizon, setting, reverse, clearList ;

//main font for each object
String [] pathFontTTF, pathFontVLW, pathFontObjTTF ;
PFont font[]  ;



















//init var
void createVar() {
  numObj = romanescoManager.numClasses + 1 ;
  //BUTTON CONTROLER
  numButtonObj = numObj*10 ;

  createVarButton() ;
  createVarSound() ;
  createVarP3D() ;
  createVarCursor() ;
  createVarObject() ;
  createMiscVar() ;
  
  romanescoManager.initObj() ;
}
// misc var
void createMiscVar() {

    
   objectLeapID = new int[numObj] ;
   
   objectInfoDisplay = new boolean[numObj] ;
    
   setting = new boolean [numObj]  ;
  //boolean clear
   clearList = new boolean[numObj] ;
   motion = new boolean [numObj]  ;
   horizon = new boolean [numObj]  ;
   reverse = new boolean [numObj] ;
   // IMAGE
   img = new PImage[numObj] ;
   whichImage = new int[numObj] ;
   // TEXT
   textImport = new String [numObj] ;
   whichText = new int[numObj] ;
  //main font for each object
   font = new PFont[numObj] ;
   pathFontObjTTF = new String[numObj] ;
   pathFontTTF = new String [numFont] ;  
   pathFontVLW = new String [numFont] ;
   font = new PFont[numFont] ;
     //MISC
  //var to init the data of the object when is switch ON for the first time
   initValueMouse = new boolean [numObj]  ;
   initValueControleur = new boolean [numObj]  ;
}
// var cursor
void createVarCursor() {
  //position of object and wheel
   mouse  = new PVector[numObj] ;
   pmouse = new PVector[numObj] ;
   clickShortLeft = new boolean [numObj] ;
   clickShortRight = new boolean [numObj] ;
   clickLongLeft = new boolean [numObj] ;
   clickLongRight = new boolean [numObj] ;
   mousepressed = new boolean [numObj] ;
   wheel = new int [numObj] ;
  //pen info
   pen = new PVector[numObj] ;
}
// P3D
void createVarP3D() {
  //setting and save
   numSettingCamera = 1 ;
   eyeCameraSetting = new PVector [numSettingCamera] ;
   sceneCameraSetting = new PVector [numSettingCamera] ;
   numSettingOrientationObject = 1 ;
   P3DpositionSetting = new PVector [numSettingOrientationObject] [numObj] ;
   P3DdirectionSetting = new PVector [numSettingOrientationObject] [numObj] ;
   //
   startingPosition = new PVector[numObj] ;
   P3DpositionX = new float[numObj] ;
   P3DpositionY = new float[numObj] ;
   P3DpositionZ = new float[numObj] ;
   P3DpositionObjRef = new PVector[numObj] ;
   P3DrefPos = new boolean[numObj] ;
   
  //orientation
   P3DdirectionX = new float[numObj] ;
   P3DdirectionY = new float[numObj] ;
   P3DdirectionObjRef = new PVector[numObj] ;
   posManipulation = new PVector[numObj] ;
   dirManipulation = new PVector[numObj] ;
   P3DrefDir = new boolean[numObj] ;
}

void createVarSound() {
   left = new float [numObj] ;
   right = new float [numObj] ;
   mix  = new float [numObj] ;
  //beat
   beat  = new float [numObj] ;
   kick  = new float [numObj] ;
   snare  = new float [numObj] ;
   hat  = new float [numObj] ;
  // spectrum
   band = new float [numObj][numBand] ;
  //tempo
   tempo = new float [numObj] ;
   tempoBeat = new float [numObj] ;
   tempoKick = new float [numObj] ;
   tempoSnare = new float [numObj] ;
   tempoHat = new float [numObj] ;
}
//

//
void createVarButton() {
  objectButton = new int [numObj] ;
  soundButton = new int [numObj] ;
  actionButton = new int [numObj] ;
  parameterButton = new int [numObj] ;
  object = new boolean [numObj] ;
  sound = new boolean [numObj] ;
  action = new boolean [numObj] ;
  parameter = new boolean [numObj] ;
  mode = new int [numObj] ;
  
  // you must init this var, because we launch this part of code before the controler. And if we don't init the value is NaN and return an error.
  valueButtonGlobal = new int[numButtonGlobal] ;
  valueButtonObj = new int[numObj*10] ;

}

void createVarObject() {
    // VAR raw
  fillRaw = new color[numGroup] ;
  strokeRaw = new color[numGroup] ;
  // column 1
  thicknessRaw = new float[numGroup] ; ;
  sizeXRaw = new float[numGroup] ; sizeYRaw = new float[numGroup] ; sizeZRaw = new float[numGroup] ;
  canvasXRaw = new float[numGroup] ; canvasYRaw = new float[numGroup] ; canvasZRaw = new float[numGroup] ;
  quantityRaw = new float[numGroup] ;
  //column 3
  speedRaw = new float[numGroup] ;
  directionRaw = new float[numGroup] ;
  angleRaw = new float[numGroup] ;
  amplitudeRaw = new float[numGroup] ;
  analyzeRaw = new float[numGroup] ;
  familyRaw = new float[numGroup] ;
  lifeRaw = new float[numGroup] ;
  forceRaw = new float[numGroup] ;
  //future slider
  fontSizeRaw = new float[numGroup] ;
  
  // VAR object
  fillObj = new color[numObj] ;
  strokeObj = new color[numObj] ;
  // column 2
  thicknessObj = new float[numObj] ; ;
  sizeXObj = new float[numObj] ; sizeYObj = new float[numObj] ; sizeZObj = new float[numObj] ;
  canvasXObj = new float[numObj] ; canvasYObj = new float[numObj] ; canvasZObj = new float[numObj] ;
  quantityObj = new float[numObj] ;
   //column 3
  speedObj = new float[numObj] ;
  directionObj = new float[numObj] ;
  angleObj = new float[numObj] ;
  amplitudeObj = new float[numObj] ;
  analyzeObj = new float[numObj] ;
  familyObj = new float[numObj] ;
  lifeObj = new float[numObj] ;
  forceObj = new float[numObj] ;
  //future slider
  fontSizeObj = new float[numObj] ;
}
// END CREATE VAR
//////////////////



// SETTING VAR
//SETUP
void varObjSetup() {
  for (int i = 0 ; i < numObj ; i++ ) {
    pen[i] = new PVector() ;
    // use the 250 value for "z" to keep the position light on the front
    mouse[i] = new PVector(0,0,0) ;
    pmouse[i] = new PVector() ;
    wheel[i] = 0 ;

  }
}
// END SETTING AR


// UPDATE DATA from CONTROLER and PRESCENE
void updateVar() {
  //from column 1
  for(int i = 0 ; i < numGroup ; i++) {
    //column 1
    fillRaw[i] = color(map(valueSlider[i+1][0],0,100,0,360), valueSlider[i+1][1], valueSlider[i+1][2], valueSlider[i+1][3]) ;
    strokeRaw[i] = color(map(valueSlider[i+1][4],0,100,0,360), valueSlider[i+1][5], valueSlider[i+1][6], valueSlider[i+1][7]) ;

    //column 2
    int minSource = 0 ;
    int maxSource = 100 ;
    float minSize = .1 ;
    thicknessRaw[i] = mapStartSmooth(valueSlider[i+1][10], minSource, maxSource, minSize, (height*.33), 2) ;
    sizeXRaw[i] = map(valueSlider[i+1][11], minSource, maxSource, minSize, width) ;
    sizeYRaw[i] = map(valueSlider[i+1][12], minSource, maxSource, minSize, width) ;
    sizeZRaw[i] = map(valueSlider[i+1][13], minSource, maxSource, minSize, width) ;
    canvasXRaw[i] = map(valueSlider[i+1][14], minSource, maxSource, width *minSize, width) ;
    canvasYRaw[i] = map(valueSlider[i+1][15], minSource, maxSource, width *minSize, width) ;
    canvasZRaw[i] = map(valueSlider[i+1][16], minSource, maxSource, width *minSize, width) ;
    quantityRaw[i] = map(valueSlider[i+1][17], minSource, maxSource, 1, 100) ;
    //column 3
    speedRaw[i] = map(valueSlider[i+1][20],minSource, maxSource,0,1) ;
    directionRaw[i] = map(valueSlider[i+1][21],minSource, maxSource,0,360) ;
    angleRaw[i] = map(valueSlider[i+1][22],minSource, maxSource,0,360) ;
    amplitudeRaw[i] = map(valueSlider[i+1][23],minSource, maxSource,0,1) ;
    analyzeRaw[i] = map(valueSlider[i+1][24],minSource, maxSource,0 , 1) ;
    familyRaw[i] = map(valueSlider[i+1][25],minSource, maxSource,1,100) ;
    lifeRaw[i] = map(valueSlider[i+1][26],minSource, maxSource,0,1) ;
    forceRaw[i] = map(valueSlider[i+1][27], minSource, maxSource, 0, 1) ;
    // future slider
    fontSizeRaw[i] = map(sizeXRaw[i], minSize, width, 1, (float)height *.025) ;
    fontSizeRaw[i] = 3 +(fontSizeRaw[i] *fontSizeRaw[i]) ;

  }
}


//SHORTCUT VAR
//SOUND
float allBeats(int ID) {
  return (beat[ID]*.25) +(kick[ID]*.25) +(hat[ID]*.25) +(snare[ID]*.25) ;
}
// ASPECT

void aspect(int ID) {
  if(alpha(fillObj[ID]) == 0 ) noFill() ; else fill(fillObj[ID]) ;
  if(alpha(strokeObj[ID]) == 0 ) noStroke() ; else stroke(strokeObj[ID]) ;
  strokeWeight(thicknessObj[ID]) ;
}
