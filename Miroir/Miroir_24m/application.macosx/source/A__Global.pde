///////////////////////
// GLOBAL SETTING ////
/////////////////////

//internet connection
boolean internet = true ;
//video connection
boolean videoSignal = false ;
// controleur connexion
Boolean controleur = false ;

String bigBrother = (" BIG BROTHER DON'T WATCHING YOU !!") ;

//variable for the tracking
Boolean nextPrevious = false ;
int nextPreviousInt = 0 ; // for send to Syphon
int trackerUpdate ; // must be reset after each use

//SYPHON
import codeanticode.syphon.*;
PGraphics miroir ;
SyphonServer server ;

//VIDEO
import codeanticode.gsvideo.*;

//INTERNET
import processing.net.*;
//FLUX RSS or TWITTER ????
import com.sun.syndication.feed.synd.*;
import com.sun.syndication.io.*;


// for processing 2.0.3
import java.net.*;
import java.io.*;
import java.util.*;
//for the fullscreen and screen choice
import java.awt.*;

//to make the window is resizable
java.awt.Insets insets; // use for the border of window (top and right)

//GEOMERATIVE
import geomerative.*;
//TOXIC
import toxi.geom.*;
import toxi.geom.mesh2d.*;
import toxi.util.*;
import toxi.util.datatypes.*;
import toxi.processing.*;

//METEO
import com.onformative.yahooweather.*;


//SOUND
import ddf.minim.*;
import ddf.minim.analysis.*;

///////IMPORTANT///////////////////////////////////////////////////////////////////////
//CALLING class or library in Other Class, you must call the PApplet too in your class
PApplet callingClass = this ;




//fenêtre texte
String texte ;
//Variable CLAVIER
// int space ;
boolean displayInfo ;



//PDF save picture
import processing.pdf.*;
boolean savePDF ;
String savePathPDF, savePathPNG ;


//LOAD IMAGE
// to drop load image
import sojamo.drop.*;
SDrop drop;
boolean resizableByImgDrop ;

//IMAGE
PImage img ;
String pathImg ; 



//ANNEXE FUNCTION
/////////////////


//MIROIR alias SYPHON
void beginMiroir() {
    miroir.beginDraw() ;
}

void endMiroir(boolean display) {
  miroir.endDraw() ;
  if(display) image(miroir,0,0) ;
  server.sendImage(miroir);
}
// END MIROIR




//INIT in real time and re-init the default setting of the display window
/////////////////////////////////////////////////////////////////////////

void initDraw() {
  // in case different rectMode is calling in the program
  miroir.rectMode (CORNER) ; 
  
  // catch to show the local adress to write in .txt in the source directory
  if (!controleur) {
    stroke(blanc) ;
    noFill() ;
    textFont(SansSerif10, 10) ;
    try {
    text("My local address for the Controleur", 50,50 ) ;
    text (java.net.InetAddress.getLocalHost().getHostAddress(), 50,70) ;
    }
    catch(Exception e) {}
  }
  
  //load text raw for the different object
  importText(sketchPath("")+"karaoke.txt") ;
  splitText() ;
  
}
//END INIT
/////////
