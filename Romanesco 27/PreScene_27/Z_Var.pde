// Z VAR ///////////////////////
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
// SYPHON
import codeanticode.syphon.*;

//CALLING class or library in Other Class, you must call the PApplet too in your class
PApplet callingClass = this ;
// use for the border of window (top and right)
java.awt.Insets insets; 

// framerate of the scene
int frameRateRomanesco ;



// Max value whi is return from the slider controller
int MAX_VALUE_SLIDER = 360 ;
// num obj count in Romanesco Manager
int NUM_OBJ ;



boolean videoSignal = false ;
//variable for the tracking
boolean nextPrevious = false ;
int nextPreviousInt = 0 ; // for send to Syphon
int trackerUpdate ; // must be reset after each use
//spectrum for the color mode and more if you need
Vec4 HSBmode = new Vec4 (360,100,100,100) ; // give the color mode in HSB
//path to open the controleur
String findPath ; 



// MOUSE DETECTION
// return if the cursor (mouse) is in the sketch or not
boolean MOUSE_IN_OUT = true ;





// COMMAND BOOLEAN
//BOOLEAN COMMAND
/* command from leap motion, mouse or other devices if we code for that :) */
boolean ORDER, ORDER_ONE, ORDER_TWO, ORDER_THREE ;
boolean LEAPMOTION_DETECTED ;



// SAVE
boolean load_SCENE_Setting_GLOBAL, save_Current_SCENE_Setting_GLOBAL, save_New_SCENE_Setting_GLOBAL ;




// HIGH VAR
boolean modeP3D, modeP2D, modeOPENGL, modeClassic ;
//spectrum band
int NUM_BANDS = 16 ;
//font
int numFont = 50 ;
//quantity of group object slider
int NUM_GROUP = 2 ;

int NUM_SLIDER_MISC = 30 ;
int NUM_SLIDER_OBJ = 30 ;

int numButtonGlobal = 21 ; // group zero
int numButtonObj  ; // group one, two and three

// VAR obj
color COLOR_FILL_OBJ_PREVIEW  ; 
color COLOR_STROKE_OBJ_PREVIEW ;
int THICKNESS_OBJ_PREVIEW = 2 ;
int numObj ;
Table indexObjects ;
TableRow [] rowIndexObject ;
//MISC var
//info object
String [] objectInfo, objectName, objectAuthor, objectVersion, objectPack ;
int [] objectID ;
boolean [] objectInfoDisplay ;
//for the leap motion ?
int objectLeapID[] ;
//BUTTON CONTROLER
boolean objectParameter[] ;

//VAR object
//raw
int [] fill_hue_raw, fill_sat_raw, fill_bright_raw, fill_alpha_raw ;
int [] stroke_hue_raw, stroke_sat_raw, stroke_bright_raw, stroke_alpha_raw ;
float [] thicknessRaw ; 
float [] sizeXRaw, sizeYRaw, sizeZRaw, canvasXRaw, canvasYRaw, canvasZRaw ;
float [] familyRaw, quantityRaw, lifeRaw ;
float [] speedRaw ;
float [] directionRaw, angleRaw ;
float [] amplitudeRaw, attractionRaw, repulsionRaw ;
float [] alignmentRaw, influenceRaw, analyzeRaw ;
/* used in this time with sizeXObj */
float []fontSizeRaw ;
/*
//add in the next version when there is 30 slider by group
//future slider available now ;
//for the next relase
float [] curveRaw ;
*/

// temp
/* value used to know if the value slider have change or nor */
int [] fill_hue_temp, fill_sat_temp, fill_bright_temp, fill_alpha_temp ;
int [] stroke_hue_temp, stroke_sat_temp, stroke_bright_temp, stroke_alpha_temp ;
float [] thicknessTemp ; 
float [] sizeXTemp, sizeYTemp, sizeZTemp, canvasXTemp, canvasYTemp, canvasZTemp ;
float [] familyTemp, quantityTemp, lifeTemp ;
float [] speedTemp ;
float [] directionTemp, angleTemp ;
float [] amplitudeTemp, attractionTemp, repulsionTemp ;
float [] alignmentTemp, influenceTemp, analyzeTemp ;
/* used in this time with sizeXObj */
float []fontSizeTemp ;
/*
//add in the next version when there is 30 slider by group
//future slider available now ;
//for the next relase
float [] curveTemp ;
*/



//object
boolean [] firstOpeningObj ; // used to check if this object is already opening before
color [] fillObj, strokeObj ;
float [] thicknessObj ; 
float [] sizeXObj, sizeYObj, sizeZObj, canvasXObj, canvasYObj, canvasZObj ;
float [] familyObj, quantityObj, lifeObj ;
float [] speedObj ;
float [] directionObj, angleObj ;
float [] amplitudeObj, attractionObj, repulsionObj ;
float [] alignmentObj, influenceObj, analyzeObj ;
/* used in this time with sizeXObj */
float []fontSizeObj ;
/*
//add in the next version when there is 30 slider by group
//future slider available now ;
//for the next relase
float []curveObj ;
*/

//font
PFont police ;



//OSC VAR
// button
int whichFont ;
// int eBeat, eKick, eSnare, eHat, eCurtain, eBackground ;
boolean onOffBeat, onOffKick, onOffSnare, onOffHat, onOffCurtain, onOffBackground ;
boolean onOffDirLightOne,       onOffDirLightTwo,       onOffLightAmbient,
        onOffDirLightOneAction, onOffDirLightTwoAction, onOffLightAmbientAction ;

// int eLightOne, eLightTwo, eLightAmbient,
 //   eLightOneAction, eLightTwoAction, eLightAmbientAction ;
int whichShader ; 
int [] whichImage, whichText ;
String [] image_path_ref  ;
int [] objectButton,soundButton, actionButton, parameterButton ;
boolean [] show_object, sound, action, parameter ;

int mode[]  ;

//BUTTON
int [] valueButtonGlobal, valueButtonObj  ;

//SLIDER
String valueSliderTemp[][]  = new String [NUM_GROUP+1][NUM_SLIDER_OBJ] ;

// becareful if the number of MISC SLIDERS is upper than OBJ SLIDER, that can be a problem in the future.
float valueSlider[][]  = new float [NUM_GROUP+1][NUM_SLIDER_OBJ] ;


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
int numSettingCamera = 1 ;
int numSettingOrientationObject = 1 ;
PVector [][] posObjSetting, dirObjSetting ;
PVector [] eyeCameraSetting, sceneCameraSetting ;
//position
PVector startingPosition [] ;
float [] posObjX, posObjY, posObjZ ;

// PVector posObjRef ;
boolean newObjRefPos ;
PVector [] posObj, dirObj, posObjRef ;
//orientation
float [] dirObjX, dirObjY ;
PVector dirObjRef ;
boolean newObjRefDir ;

//position of object and wheel
PVector [] mouse, pen ;
boolean [] clickShortLeft, clickShortRight, clickLongLeft, clickLongRight;
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
  createVarP3D(numObj, numSettingCamera, numSettingOrientationObject) ;
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
   // boolean clear
   clearList = new boolean[numObj] ;
   motion = new boolean [numObj]  ;
   horizon = new boolean [numObj]  ;
   reverse = new boolean [numObj] ;
   // IMAGE
   img = new PImage[numObj] ;
   whichImage = new int[numObj] ;
   image_path_ref = new String[numObj] ;
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
   clickShortLeft = new boolean [numObj] ;
   clickShortRight = new boolean [numObj] ;
   clickLongLeft = new boolean [numObj] ;
   clickLongRight = new boolean [numObj] ;
   wheel = new int [numObj] ;
  //pen info
   pen = new PVector[numObj] ;
}
// P3D
void createVarP3D(int numObj, int numSettingCamera, int numSettingOrientationObject) {
   // setting and save
   eyeCameraSetting = new PVector [numSettingCamera] ;
   sceneCameraSetting = new PVector [numSettingCamera] ;

   posObjSetting = new PVector [numSettingOrientationObject] [numObj] ;
   dirObjSetting = new PVector [numSettingOrientationObject] [numObj] ;
   //
   startingPosition = new PVector[numObj] ;
   posObjX = new float[numObj] ;
   posObjY = new float[numObj] ;
   posObjZ = new float[numObj] ;
   
   // orientation
   dirObjX = new float[numObj] ;
   dirObjY = new float[numObj] ;
   posObjRef = new PVector[numObj] ;
   posObj = new PVector[numObj] ;
   dirObj = new PVector[numObj] ;
}

void createVarSound() {
  // volume 
   left = new float [numObj] ;
   right = new float [numObj] ;
   mix  = new float [numObj] ;
   // beat
   beat  = new float [numObj] ;
   kick  = new float [numObj] ;
   snare  = new float [numObj] ;
   hat  = new float [numObj] ;
   // spectrum
   band = new float [numObj][NUM_BANDS] ;
   // tempo
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
  show_object = new boolean [numObj] ;
  sound = new boolean [numObj] ;
  action = new boolean [numObj] ;
  parameter = new boolean [numObj] ;
  mode = new int [numObj] ;
  
  // you must init this var, because we launch this part of code before the controller. And if we don't init the value is NaN and return an error.
  valueButtonGlobal = new int[numButtonGlobal] ;
  valueButtonObj = new int[numObj*10] ;

}

void createVarObject() {
  // RAW
  fill_hue_raw = new int[NUM_GROUP] ;   fill_sat_raw = new int[NUM_GROUP] ;   fill_bright_raw = new int[NUM_GROUP] ;    fill_alpha_raw = new int[NUM_GROUP] ;
  stroke_hue_raw = new int[NUM_GROUP] ; stroke_sat_raw = new int[NUM_GROUP] ; stroke_bright_raw = new int[NUM_GROUP] ;  stroke_alpha_raw = new int[NUM_GROUP] ;
  thicknessRaw = new float[NUM_GROUP] ;
  sizeXRaw = new float[NUM_GROUP] ;   sizeYRaw = new float[NUM_GROUP] ;    sizeZRaw = new float[NUM_GROUP] ;
  canvasXRaw = new float[NUM_GROUP] ; canvasYRaw = new float[NUM_GROUP] ;  canvasZRaw = new float[NUM_GROUP] ;
  familyRaw = new float[NUM_GROUP] ;  quantityRaw = new float[NUM_GROUP] ; lifeRaw = new float[NUM_GROUP] ;
  speedRaw = new float[NUM_GROUP] ;
  directionRaw = new float[NUM_GROUP] ;
  angleRaw = new float[NUM_GROUP] ;
  amplitudeRaw = new float[NUM_GROUP] ;
  attractionRaw = new float[NUM_GROUP] ;
  repulsionRaw = new float[NUM_GROUP] ;
  alignmentRaw = new float[NUM_GROUP] ;
  influenceRaw = new float[NUM_GROUP] ;
  analyzeRaw = new float[NUM_GROUP] ;
  //future slider
  /* used in this time with the sizeXobj */
  fontSizeRaw = new float[NUM_GROUP] ;
  
  // Temp
  /* used to compare the value slider, to know if the value of the obhject must be updated orn ot */
  fill_hue_temp = new int[NUM_GROUP] ;    fill_sat_temp = new int[NUM_GROUP] ;    fill_bright_temp = new int[NUM_GROUP] ;   fill_alpha_temp = new int[NUM_GROUP] ;
  stroke_hue_temp = new int[NUM_GROUP] ;  stroke_sat_temp = new int[NUM_GROUP] ;  stroke_bright_temp = new int[NUM_GROUP] ; stroke_alpha_temp = new int[NUM_GROUP] ;
  thicknessTemp = new float[NUM_GROUP] ;
  sizeXTemp = new float[NUM_GROUP] ;   sizeYTemp = new float[NUM_GROUP] ;    sizeZTemp = new float[NUM_GROUP] ;
  canvasXTemp = new float[NUM_GROUP] ; canvasYTemp = new float[NUM_GROUP] ;  canvasZTemp = new float[NUM_GROUP] ;
  familyTemp = new float[NUM_GROUP] ;  quantityTemp = new float[NUM_GROUP] ; lifeTemp = new float[NUM_GROUP] ;
  speedTemp = new float[NUM_GROUP] ;
  directionTemp = new float[NUM_GROUP] ;
  angleTemp = new float[NUM_GROUP] ;
  amplitudeTemp = new float[NUM_GROUP] ;
  attractionTemp = new float[NUM_GROUP] ;
  repulsionTemp = new float[NUM_GROUP] ;
  alignmentTemp = new float[NUM_GROUP] ;
  influenceTemp = new float[NUM_GROUP] ;
  analyzeTemp = new float[NUM_GROUP] ;
  //future slider
  /* used in this time with the sizeXobj */
  fontSizeTemp = new float[NUM_GROUP] ;
  
  // VAR object
  firstOpeningObj = new boolean[numObj] ; // used to check if this object is already opening before
  fillObj = new color[numObj] ;
  strokeObj = new color[numObj] ;
  // column 2
  thicknessObj = new float[numObj] ; ;
  sizeXObj = new float[numObj] ; sizeYObj = new float[numObj] ; sizeZObj = new float[numObj] ;
  canvasXObj = new float[numObj] ; canvasYObj = new float[numObj] ; canvasZObj = new float[numObj] ;
  familyObj = new float[numObj] ; quantityObj = new float[numObj] ; lifeObj = new float[numObj] ;
   //column 3
  speedObj = new float[numObj] ;
  directionObj = new float[numObj] ;
  angleObj = new float[numObj] ;
  amplitudeObj = new float[numObj] ;
  attractionObj = new float[numObj] ;
  repulsionObj = new float[numObj] ;
  alignmentObj = new float[numObj] ;
  influenceObj = new float[numObj] ;
  analyzeObj = new float[numObj] ;
  

    //future slider
  /* used in this time with the sizeXobj */
  fontSizeObj = new float[numObj] ;
}
// END CREATE VAR
//////////////////



// SETTING VAR
//SETUP
void varObjSetup() {
  dirObjRef = new PVector() ;
  for (int i = 0 ; i < numObj ; i++ ) {
    pen[i] = new PVector() ;
    // use the 250 value for "z" to keep the position light on the front
    mouse[i] = new PVector() ;
    wheel[i] = 0 ;

  }
    // init global var for the color obj preview mode display
  COLOR_FILL_OBJ_PREVIEW = color (0,0,100,30) ; 
  COLOR_STROKE_OBJ_PREVIEW = color (0,0,100,30) ;
}
// END SETTING AR


/* 
UPDATE DATA from CONTROLER and PRESCENE
Those value are used to updated the object data value, and updated at the end of the loop the temp value
*/
void updateVarRaw() {
  for(int i = 0 ; i < NUM_GROUP ; i++) {
    int minSource = 0 ;
    // int maxSource = 1 ;
    float minSize = .1 ;
    // fill
    fill_hue_raw[i] = (int)valueSlider[i+1][0] ;
    fill_sat_raw[i] = (int)map(valueSlider[i+1][1],0,MAX_VALUE_SLIDER,0,HSBmode.g);    
    fill_bright_raw[i] = (int)map(valueSlider[i+1][2],0,MAX_VALUE_SLIDER,0,HSBmode.b) ;   
    fill_alpha_raw[i] = (int)map(valueSlider[i+1][3],0,MAX_VALUE_SLIDER,0,HSBmode.a);
    // stroke
    stroke_hue_raw[i] = (int)valueSlider[i+1][4] ; 
    stroke_sat_raw[i] = (int)map(valueSlider[i+1][5],0,MAX_VALUE_SLIDER,0,HSBmode.g);  
    stroke_bright_raw[i] = (int)map(valueSlider[i+1][6],0,MAX_VALUE_SLIDER,0,HSBmode.b) ; 
    stroke_alpha_raw[i] = (int)map(valueSlider[i+1][7],0,MAX_VALUE_SLIDER,0,HSBmode.a);
    // 
    thicknessRaw[i] = mapStartSmooth(valueSlider[i+1][8], minSource, MAX_VALUE_SLIDER, minSize, (height*.33), 2) ;

    // size
    sizeXRaw[i] = map(valueSlider[i+1][10], minSource, MAX_VALUE_SLIDER, minSize, width) ;
    sizeYRaw[i] = map(valueSlider[i+1][11], minSource, MAX_VALUE_SLIDER, minSize, width) ;
    sizeZRaw[i] = map(valueSlider[i+1][12], minSource, MAX_VALUE_SLIDER, minSize, width) ;
    // canvas
    canvasXRaw[i] = map(valueSlider[i+1][13], minSource, MAX_VALUE_SLIDER, width *minSize, width) ;
    canvasYRaw[i] = map(valueSlider[i+1][14], minSource, MAX_VALUE_SLIDER, width *minSize, width) ;
    canvasZRaw[i] = map(valueSlider[i+1][15], minSource, MAX_VALUE_SLIDER, width *minSize, width) ;
    // misc
    familyRaw[i] = map(valueSlider[i+1][16],minSource, MAX_VALUE_SLIDER, 0, 1) ;
    quantityRaw[i] = map(valueSlider[i+1][17], minSource, MAX_VALUE_SLIDER, 0, 1) ;
    lifeRaw[i] = map(valueSlider[i+1][18],minSource, MAX_VALUE_SLIDER,0,1) ;
    //column 3
    speedRaw[i] = map(valueSlider[i+1][20],minSource, MAX_VALUE_SLIDER,0,1) ;
    directionRaw[i] = map(valueSlider[i+1][21],minSource, MAX_VALUE_SLIDER,0,360) ;
    angleRaw[i] = map(valueSlider[i+1][22],minSource, MAX_VALUE_SLIDER,0,360) ;
    amplitudeRaw[i] = map(valueSlider[i+1][23],minSource, MAX_VALUE_SLIDER,0,1) ;
    // force
    attractionRaw[i] = map(valueSlider[i+1][24],minSource, MAX_VALUE_SLIDER,0,1) ;
    repulsionRaw[i] = map(valueSlider[i+1][25],minSource, MAX_VALUE_SLIDER,0,1) ;
    alignmentRaw[i] = map(valueSlider[i+1][26],minSource, MAX_VALUE_SLIDER,0,1) ;
    influenceRaw[i] = map(valueSlider[i+1][27],minSource, MAX_VALUE_SLIDER,0,1) ;
    analyzeRaw[i] = map(valueSlider[i+1][28],minSource, MAX_VALUE_SLIDER,0 , 1) ;

    /* used in this time with sizeXObj */
    fontSizeRaw[i] = map(sizeXRaw[i], minSize, width, 1, (float)height *.025) ;
    fontSizeRaw[i] = 3 +(fontSizeRaw[i] *fontSizeRaw[i]) ;
  }
}


/* Those temp value are used to know is the object value must be updated */
void updateVarTemp() {
    for(int i = 0 ; i < NUM_GROUP ; i++) {
    // fill
    fill_hue_temp[i] = fill_hue_raw[i] ;
    fill_sat_temp[i] = fill_sat_raw[i] ;    
    fill_bright_temp[i] = fill_bright_raw[i] ;   
    fill_alpha_temp[i] = fill_alpha_raw[i] ;
    // stroke
    stroke_hue_temp[i] = stroke_hue_raw[i] ; 
    stroke_sat_temp[i] = stroke_sat_raw[i] ;  
    stroke_bright_temp[i] = stroke_bright_raw[i] ; 
    stroke_alpha_temp[i] = stroke_alpha_raw[i] ;
    //
    thicknessTemp[i] = thicknessRaw[i] ;
    //size
    sizeXTemp[i] = sizeXRaw[i] ;
    sizeYTemp[i] = sizeYRaw[i] ;
    sizeZTemp[i] = sizeZRaw[i] ;
    // canvas
    canvasXTemp[i] = canvasXRaw[i] ;
    canvasYTemp[i] = canvasYRaw[i] ;
    canvasZTemp[i] = canvasZRaw[i] ;
    // misc
    familyTemp[i] = familyRaw[i] ;
    quantityTemp[i] = quantityRaw[i] ;
    lifeTemp[i] = lifeRaw[i] ;
    //column 3
    speedTemp[i] = speedRaw[i] ;
    directionTemp[i] = directionRaw[i] ;
    angleTemp[i] = angleRaw[i] ;
    amplitudeTemp[i] = amplitudeRaw[i] ;
    // force
    attractionTemp[i] = attractionRaw[i] ;
    repulsionTemp[i] = repulsionRaw[i] ;
    influenceTemp[i] = influenceRaw[i] ;
    alignmentTemp[i] = alignmentRaw[i] ;
    analyzeTemp[i] = analyzeRaw[i] ;

    /* used in this time with sizeXObj */
    fontSizeTemp[i] = fontSizeRaw[i] ;
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












////////////////////////
// FONT and TEXT MANAGER

//FONT
PFont SansSerif10,

      AmericanTypewriter, AmericanTypewriterBold,
      Banco, 
      ContainerRegular, Cinquenta,
      Diesel,
      Digital, 
      DinRegular10 ,DinRegular, DinBold,
      EastBloc,
      FetteFraktur, FuturaStencil,
      GangBangCrime,
      Juanita, JuanitaOutline,
      Komikahuna,
      Mesquite,
      Minion, MinionBold,
      NanumBrush, 
      Rosewood,
      TheHardwayRMX,
      TokyoOne, TokyoOneSolid ;
      


      
//SETUP
void fontSetup() {
  String fontPathVLW = preferencesPath +"Font/typoVLW/" ;

  //write font path
  pathFontVLW[1] = fontPathVLW+"AmericanTypewriter-96.vlw";
  pathFontVLW[2] = fontPathVLW+"AmericanTypewriter-Bold-96.vlw";
  pathFontVLW[3] = fontPathVLW+"BancoITCStd-Heavy-96.vlw";
  pathFontVLW[4] = fontPathVLW+"CinquentaMilMeticais-96.vlw";
  pathFontVLW[5] = fontPathVLW+"Container-Regular-96.vlw";
  pathFontVLW[6] = fontPathVLW+"Diesel-96.vlw";
  pathFontVLW[7] = fontPathVLW+"Digital2-96.vlw";
  pathFontVLW[8] = fontPathVLW+"DIN-Regular-96.vlw";
  pathFontVLW[9] = fontPathVLW+"DIN-Bold-96.vlw";
  pathFontVLW[10] = fontPathVLW+"EastBlocICGClosed-96.vlw";
  pathFontVLW[11] = fontPathVLW+"FuturaStencilICG-96.vlw";
  pathFontVLW[12] = fontPathVLW+"FetteFraktur-96.vlw";
  pathFontVLW[13] = fontPathVLW+"GANGBANGCRIME-96.vlw";
  pathFontVLW[14] = fontPathVLW+"JuanitaDecoITCStd-96.vlw";
  pathFontVLW[15] = fontPathVLW+"Komikahuna-96.vlw";
  pathFontVLW[16] = fontPathVLW+"MesquiteStd-96.vlw";
  pathFontVLW[17] = fontPathVLW+"NanumBrush-96.vlw";
  pathFontVLW[18] = fontPathVLW+"RosewoodStd-Regular-96.vlw";
  pathFontVLW[19] = fontPathVLW+"3theHardwayRMX-96.vlw";
  pathFontVLW[20] = fontPathVLW+"Tokyo-One-96.vlw";
  pathFontVLW[21] = fontPathVLW+"MinionPro-Regular-96.vlw";
  pathFontVLW[22] = fontPathVLW+"MinionPro-Bold-96.vlw";
  // special font
  pathFontVLW[49] = fontPathVLW+"DIN-Regular-10.vlw";
  SansSerif10 = loadFont(fontPathVLW+"SansSerif-10.vlw" );
  
  // write font path for TTF
  String prefixTTF = preferencesPath +"Font/typoTTF/" ;
  //by default
  pathFontTTF[0] = prefixTTF+"FuturaStencil.ttf";
  // type
  pathFontTTF[1] = prefixTTF+"AmericanTypewriter.ttf";
  pathFontTTF[2] = prefixTTF+"AmericanTypewriter.ttf";
  pathFontTTF[3] = prefixTTF+"Banco.ttf";
  pathFontTTF[4] = prefixTTF+"Cinquenta.ttf";
  pathFontTTF[5] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[6] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[7] = prefixTTF+"Digital2.ttf";
  pathFontTTF[8] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[9] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[10] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[11] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[12] = prefixTTF+"FetteFraktur.ttf";
  pathFontTTF[13] = prefixTTF+"GangBangCrime.ttf";
  pathFontTTF[14] = prefixTTF+"JuanitaITC.ttf";
  pathFontTTF[15] = prefixTTF+"Komikahuna.ttf";
  pathFontTTF[16] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[17] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[18] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[19] = prefixTTF+"3Hardway.ttf";
  pathFontTTF[20] = prefixTTF+"FuturaStencil.ttf";
  pathFontTTF[21] = prefixTTF+"MinionWebPro.ttf";
  pathFontTTF[22] = prefixTTF+"MinionWebPro.ttf";
  // special font
  pathFontTTF[49] = prefixTTF+"FuturaStencil.ttf";

  // load
  AmericanTypewriter=loadFont      (pathFontVLW[1]);
  AmericanTypewriterBold=loadFont  (pathFontVLW[2]);
  Banco=loadFont                   (pathFontVLW[3]);
  Cinquenta=loadFont               (pathFontVLW[4]);
  ContainerRegular=loadFont        (pathFontVLW[5]);
  Diesel=loadFont                  (pathFontVLW[6]);
  Digital=loadFont                 (pathFontVLW[7]);
  DinRegular=loadFont              (pathFontVLW[8]);
  DinBold=loadFont                 (pathFontVLW[9]);
  EastBloc=loadFont                (pathFontVLW[10]);
  FuturaStencil=loadFont           (pathFontVLW[11]);
  FetteFraktur=loadFont            (pathFontVLW[12]);
  GangBangCrime=loadFont           (pathFontVLW[13]);
  JuanitaOutline=loadFont          (pathFontVLW[14]);
  Komikahuna=loadFont              (pathFontVLW[15]);
  Mesquite=loadFont                (pathFontVLW[16]);
  NanumBrush=loadFont              (pathFontVLW[17]);
  Rosewood=loadFont                (pathFontVLW[18]);
  TheHardwayRMX=loadFont           (pathFontVLW[19]);
  TokyoOne=loadFont                (pathFontVLW[20]);
  Minion=loadFont                  (pathFontVLW[21]);
  MinionBold=loadFont              (pathFontVLW[22]);

  // default and special font
  DinRegular10=loadFont            (pathFontVLW[49]);

  font[0] = FuturaStencil ;
  pathFontObjTTF[0] = pathFontTTF[0] ;
}




void choiceFont( int whichOne)  { 
  if (whichOne == 1 )     { pathFontObjTTF[0] = pathFontTTF[1] ; font[0] = AmericanTypewriter ;  }
  else if (whichOne ==2 ) { pathFontObjTTF[0] = pathFontTTF[2] ; font[0] = AmericanTypewriterBold ; }
  else if (whichOne == 3) { pathFontObjTTF[0] = pathFontTTF[3] ; font[0] = Banco ; }
  else if (whichOne ==4)  { pathFontObjTTF[0] = pathFontTTF[4] ; font[0] = Cinquenta ; }
  else if (whichOne ==5)  { pathFontObjTTF[0] = pathFontTTF[5] ; font[0] = ContainerRegular ; }
  else if (whichOne ==6)  { pathFontObjTTF[0] = pathFontTTF[6] ; font[0] = Diesel ; }
  else if (whichOne ==7)  { pathFontObjTTF[0] = pathFontTTF[7] ; font[0] = Digital ; }
  else if (whichOne ==8)  { pathFontObjTTF[0] = pathFontTTF[8] ; font[0] = DinRegular ; }
  else if (whichOne ==9)  { pathFontObjTTF[0] = pathFontTTF[9] ; font[0] = DinBold ; }
  else if (whichOne ==10) { pathFontObjTTF[0] = pathFontTTF[10] ; font[0] = EastBloc ; }
  else if (whichOne ==11) { pathFontObjTTF[0] = pathFontTTF[11] ; font[0] = FetteFraktur ; }
  else if (whichOne ==12) { pathFontObjTTF[0] = pathFontTTF[12] ; font[0] = FuturaStencil ; }
  else if (whichOne ==13) { pathFontObjTTF[0] = pathFontTTF[13] ; font[0] = GangBangCrime ; }
  else if (whichOne ==14) { pathFontObjTTF[0] = pathFontTTF[14] ; font[0] = JuanitaOutline ; }   
  else if (whichOne ==15) { pathFontObjTTF[0] = pathFontTTF[15] ; font[0] = Komikahuna ; }
  else if (whichOne ==16) { pathFontObjTTF[0] = pathFontTTF[16] ; font[0] = Mesquite ; }
  else if (whichOne ==17) { pathFontObjTTF[0] = pathFontTTF[17] ; font[0] = Minion ; }
  else if (whichOne ==18) { pathFontObjTTF[0] = pathFontTTF[18] ; font[0] = MinionBold ; }
  else if (whichOne ==19) { pathFontObjTTF[0] = pathFontTTF[19] ; font[0] = NanumBrush ; }
  else if (whichOne ==20) { pathFontObjTTF[0] = pathFontTTF[20] ; font[0] = Rosewood ; }
  else if (whichOne ==21) { pathFontObjTTF[0] = pathFontTTF[21] ; font[0] = TheHardwayRMX ; }
  else if (whichOne ==22) { pathFontObjTTF[0] = pathFontTTF[22] ; font[0] = TokyoOne ; } 
  else                     { pathFontObjTTF[0] = pathFontTTF[49]  ; font[0] = AmericanTypewriter ; }
}
//END FONT




// END FONT and TEXT MANAGER
////////////////////////////
