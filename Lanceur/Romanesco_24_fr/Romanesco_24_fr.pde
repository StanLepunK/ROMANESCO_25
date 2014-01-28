boolean test = false ;

PFont FuturaStencil ;



import java.awt.* ;
GraphicsEnvironment g = GraphicsEnvironment.getLocalGraphicsEnvironment();
GraphicsDevice[] devices = g.getScreenDevices();

color gris, grisClair, grisFonce, orange, rouge, vertClair, vertFonce ;
color c1, c2, c3, c4 ;
String pathControleur;
String pathScene;
boolean open ;

//
String screen = ("") ;
Button buttonWindow, buttonFullscreen  ;
//which screen var
Button [] whichScreenButton ;
//slider var
Slider sliderWidth, sliderHeight ;
int heightSlider, widthSlider ;
//which mode rendering
Button [] whichModeButton ;
//Button start
Button buttonStart ;

Table table;

void setup()
{
  size(550, 230);
  colorMode(HSB,360,100,100) ;
  background(0);
  grisClair = color (27,10, 70) ; //gris clair
  gris = color (27,20, 50) ; //gris
  grisFonce = color (27,10, 20) ; //gris clair
  orange = color (27,100,100) ; //orange
  rouge = color (9,100,70) ; //rouge
  vertClair = color (88,85,71) ; // vert clair
  vertFonce = color (90,93,46) ; // vert foncé
  c1 = color(orange) ;
  c2 = color(rouge ) ;
  c3 = color(vertClair) ;
  c4 = color(vertFonce) ;
  
  //load
  if (test) table = loadTable("sceneProperty.csv", "header"); else table = loadTable(sketchPath("")+"RomanescoAlpha/Scene_23.app/Contents/Resources/Java/data/setting/sceneProperty.csv", "header");
  //load typo
  FuturaStencil =loadFont ("FuturaStencilICG-20.vlw") ;
  
  //common data
  color colorIN = color (vertClair ) ;
  color colorOUT = color (vertFonce ) ;
  
  //which size WINDOW or FULL SCREEN
  PVector posButtonWindow = new PVector ( 10, 70 ) ;
  PVector sizeButtonWindow = new PVector ( 200, 20 ) ;
  PVector posButtonFullscreen = new PVector ( 220, 70 ) ;
  PVector sizeButtonFullscreen = new PVector ( 200, 20 ) ;
  String textFullscreen = ("PLEIN ÉCRAN") ;
  String textWindow = ("dans une FENÊTRE") ;
  buttonWindow = new Button(posButtonWindow, sizeButtonWindow, c1, c2, c3, c4, textWindow) ;
  buttonFullscreen = new Button(posButtonFullscreen, sizeButtonFullscreen, c1, c2, c3, c4, textFullscreen) ;
  
  
  //if it's full sreen on which screen display the SCENE
  //button choice
  // "X" and  "Y" componant give the button position    "Z" componant = space between the button
  PVector posWhichScreenButton = new PVector (270, 100, 23 ) ; 
  //quantityScreen count the number of screen available
  int quantityScreen = devices.length ;
  whichScreenSetup(quantityScreen, posWhichScreenButton) ;
  
  
  //which size for window
  PVector posSliderWidth = new PVector( 200, 134 ) ;
  PVector posMoletteWidth = posSliderWidth ;
  PVector posSliderHeight = new PVector( 10, 134 ) ;
  PVector posMoletteHeight = posSliderHeight ;
  PVector sizeSlider = new PVector ( 180, 16 ) ;
  color colorBG = color(grisFonce) ;
  color colorBoxIn = color(vertFonce) ;
  color colorBoxOut = color(rouge) ;
  
  sliderWidth = new Slider(posSliderWidth, posMoletteWidth, sizeSlider, colorBG, colorBoxIn, colorBoxOut ) ;
  sliderWidth.sliderSetting() ;
  sliderHeight = new Slider(posSliderHeight, posMoletteHeight, sizeSlider, colorBG, colorBoxIn, colorBoxOut ) ;
  sliderHeight.sliderSetting() ;
  
  
  //which MODE RENDERER
  PVector posWhichModeButton = new PVector (10, 160, 140 ) ;
 // "X" and  "Y" componant give the button position    "Z" componant = space between the button 
  PVector areaRollover = new PVector (80, 20)  ;
  //if you want more renderer mode add quantity you want here.
  int quantityMode = 3 ;
  whichModeSetup(quantityMode, posWhichModeButton, areaRollover) ;
     
  //button start
  PVector posButtonStart = new PVector (10, 190) ;
  PVector sizeButtonStart = new PVector (210, 20 ) ;
  String textButtonStart = ("Lancer Romanesco") ;
  buttonStart = new Button(posButtonStart, sizeButtonStart, colorIN, colorOUT, colorIN, colorOUT, textButtonStart ) ;
  
  //OPENING APP
  pathScene = (sketchPath("") + "RomanescoAlpha/Scene_23.app");
  pathControleur = (sketchPath("") + "RomanescoAlpha/Controleur_23.app");
  
  //Change the language of controleur
  // 0 is French
  // 1 is English
  String[] l = split( ("0"), " ") ;
  saveStrings(sketchPath("")+"RomanescoAlpha/preference/language.txt", l) ;

}


void draw()
{
  background(0) ;
  //
  fill(orange) ;
  textFont(FuturaStencil,20);
  text("ROMANESCO alpha 23", 10.0F, 30.0F);
  text("La SCÈNE s'affiche", 10.0F, 60.0F);
  
  //which window display
  buttonWindow.displayButton() ;
  buttonFullscreen.displayButton() ;
  
  if (buttonWindow.OnOff) {
    screen = ("false") ;
    //buttonFullscreen.OnOff = false ;
  } else if (buttonFullscreen.OnOff) {
    screen = ("true") ;
    //buttonWindow.OnOff = false ;
  } 
  //what display  
  if (buttonFullscreen.OnOff) {
    //buttonWindow.OnOff = false ;
    fill(orange) ;
    text("affichée sur l'écran", 10.0F, 120.0F);
    
    //on which screen display the window
    whichScreenDraw() ;
  } else if (buttonWindow.OnOff) {
    //buttonFullscreen.OnOff = false ;
    screen = ("false") ;
    //setting the Scene size
    sliderHeight.sliderUpdate() ;
    sliderWidth.sliderUpdate() ;
    fill(rouge) ;
    heightSlider = int(50 + 2500 *sliderHeight.getValue())  ;
    widthSlider = int(50 + 5000 *sliderWidth.getValue())  ;
    String h = Integer.toString(heightSlider) ;
    String w = Integer.toString(widthSlider) ;
    //check the height
    if ( heightSlider <= 50 ) {
      fill(rouge) ;
      text("Hauteur " + h, 10.0F, 120.0F);
    } else {
      fill(vertFonce) ;
      text("Hauteur " + h, 10.0F, 120.0F);
    }
    //check the width
    if ( widthSlider <= 50 ) {
      fill(rouge) ;
      text("Largeur " + w, 200.0F, 120.0F);
    } else {
      fill(vertFonce) ;
      text("Largeur " + w, 200.0F, 120.0F);
    }
  }
  
  //which MODE RENDERER
  if(buttonFullscreen.OnOff || buttonWindow.OnOff ) whichModeDraw() ;
  
  //Button Start
  // conditional do display the button START
  // full screen mode the user must choice a screen and mode renderer
  if ( IDmodeSelected() != ("") && buttonWhichScreenOnOff > 0 && buttonFullscreen.OnOff ) {
    buttonStart.displayButton() ;
  //window mode the user must choice a window size  
  } else if ( IDmodeSelected() != ("") &&  buttonWindow.OnOff && heightSlider>50 & widthSlider>50 ) {
    buttonStart.displayButton() ;
  } else {
    fill(orange) ;
    text("finissez la configuration de Romanesco",10,210) ;
  }
  
  /*
  if (timeToLaunch != 0 && ((hour() *60 *60 )+(minute() *60) +second()) == timeToLaunch && openScene ) {
    if(!test ) open(pathControleur); else println("ON LANCE LE BOUZIN en " + IDmodeSelected()) ;
    openScene = false ;
     // open(pathControleur);
  }
  */
}

//MOUSEPRESSED
void mousePressed()
{
  //which type of SCENE display full screen or window
  //to re-init the button
  if (buttonFullscreen.inside || buttonWindow.inside) {
    buttonFullscreen.OnOff = false ;
    buttonWindow.OnOff = false ;
  }
  // after the re-init we can check what's happen on the button
  buttonFullscreen.mouseClic() ;
  buttonWindow.mouseClic() ;
  
  //which screen for the fullscreen mode
  if(buttonFullscreen.OnOff) whichScreenPressed() ;
  
  //which mode
  whichModePressed() ;
  
  //button start
  if (IDmodeSelected() != ("") ) {
    buttonStart.mouseClic() ;
    if(buttonStart.OnOff ) openApp() ;
    buttonStart.OnOff = false ;
  }
}


//MOUSELEASED
void mouseReleased()
{
  //which Screen display
  if(buttonFullscreen.OnOff) whichScreenReleased() ;
  //which mode renderer
  whichModeReleased() ;
  
  setTable() ;
  //
  if(test) saveTable(table, "data/new.csv"); else saveTable(table, sketchPath("")+"RomanescoAlpha/Scene_23.app/Contents/Resources/Java/data/setting/sceneProperty.csv"); 
}



//ANNEXE
int timeToLaunch, timeRepere ;
boolean openScene ; 

void openApp()
{
  open(pathScene);
  timeRepere = (hour() *60 *60 )+(minute() *60) +second() ;
  timeToLaunch = timeRepere +5 ;
  openScene = true ;
}


//SAVE the Table
void setTable()
{
  //write the change in the file.csv
  //if it's full size or not
  table.setString(0,1, screen) ;
  //where display the fullscreen
  table.setInt(0,2, IDscreenSelected()) ;
  //size of the scene
  table.setInt(0,6,heightSlider ) ;
  table.setInt(0,5,widthSlider ) ;
  //Mode renderer
  table.setString(0,7, IDmodeSelected()) ;
}


//////////////
//WHICH SCREEN
int screenNum  ;
//SETUP 
void whichScreenSetup(int n , PVector infoPos)
{
  //quantity of button choice
  screenNum = n ;
  whichScreenButton = new Button [screenNum] ;
  //position of the button  
  int x = (int)infoPos.x ;
  int y = (int)infoPos.y ;
  int space = (int)infoPos.z ;
  
  for ( int i = 0 ; i <  screenNum ; i++) {
    PVector pos = new PVector( x +( i *space), y ) ;
    PVector size = new PVector (20,20) ;
    String title = Integer.toString(i+1) ;
    whichScreenButton[i] = new Button(pos, size, c1, c2, c3, c4, title) ;
  }
}

//DRAW
void whichScreenDraw()
{
  for(int i =0 ; i <screenNum ; i++) {
    whichScreenButton[i].displayButton() ;
  }
}

//MOUSEPRESSED
void whichScreenPressed()
{
  for(int i =0 ; i< screenNum ; i++ ) {
    if (whichScreenButton[i].inside ) {
      for( int j =0 ; j < screenNum ; j++ ) whichScreenButton[j].OnOff = false ;
    }
  }
}

//MOUSERELEASED
int buttonWhichScreenOnOff ;

void whichScreenReleased()
{
  buttonWhichScreenOnOff = 0 ;
  for(int i = 0 ; i<screenNum ; i++ ) {
    whichScreenButton[i].mouseClic() ;
    if(whichScreenButton[i].OnOff) buttonWhichScreenOnOff += 1 ;
  }
}

//ID screen
int IDscreen = 0 ;
int IDscreenSelected() {
  
  for (int i = 0 ; i < screenNum ; i++ ) { 
    if (whichScreenButton[i].OnOff == true ) IDscreen = i+1 ;
  }
  return IDscreen ;
}



////////////////
//WHICH RENDERER
int modeNum ;
String modeRenderer ;
PVector posMode ;
PVector sizeMode ;
//SETUP 
void whichModeSetup(int n , PVector infoPos, PVector areaSize)
{
  //quantity of button choice
  modeNum = n ;
  whichModeButton = new Button [modeNum] ;
  //position of the button  
  int x = (int)infoPos.x ;
  int y = (int)infoPos.y ;
  int space = (int)infoPos.z ;
  
  for ( int i = 0 ; i <  modeNum ; i++) {
    if(i == 0 ) { modeRenderer  = ("Classique 2D") ; posMode = new PVector( 10, y ) ; sizeMode = new PVector (160, areaSize.y) ;  }
    if(i == 1 ) { modeRenderer  = ("Processing 2D") ; posMode = new PVector( 180, y ) ; sizeMode = new PVector (165, areaSize.y) ; }
    if(i == 2 ) { modeRenderer  = ("Processing 3D") ; posMode = new PVector( 360, y ) ; sizeMode = new PVector (165, areaSize.y) ; }
    if(i == 3 ) { modeRenderer  = ("OPENGL") ; posMode = new PVector( 245, y ) ; sizeMode = new PVector (95, areaSize.y) ; }
    
    color c1 = color(orange) ;
    color c2 = color(rouge ) ;
    color c3 = color(vertClair) ;
    color c4 = color(vertFonce) ;
    whichModeButton[i] = new Button(posMode, sizeMode, c1, c2, c3, c4, modeRenderer ) ;
  }
}
//DRAW
void whichModeDraw()
{
  for(int i =0 ; i <modeNum ; i++) {
    whichModeButton[i].displayButton() ;
  }
}



//MOUSEPRESSED
void whichModePressed()
{
  for(int i =0 ; i< modeNum ; i++ ) {
    if (whichModeButton[i].inside ) {
      for( int j =0 ; j < modeNum ; j++ ) whichModeButton[j].OnOff = false ;
    }
  }
}

//MOUSERELEASED
void whichModeReleased()
{
  for(int i = 0 ; i<modeNum ; i++ ) {
    whichModeButton[i].mouseClic() ;
  }
}

//ID screen
String IDmode = ("") ;
String IDmodeSelected() {
  
  for (int i = 0 ; i < modeNum ; i++ ) { 
    if (whichModeButton[0].OnOff == true ) { 
      IDmode = ("classic") ;
    } else if (whichModeButton[1].OnOff == true ) {
      IDmode = ("P2D") ;
    } else if (whichModeButton[2].OnOff == true ) { 
      IDmode = ("P3D") ;
   // } else  if (whichModeButton[3].OnOff == true ) {
   //   IDmode = ("OPENGL") ;
    } else {
      IDmode = ("") ;
    }
  }
  return IDmode ;
}











