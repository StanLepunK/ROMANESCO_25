



//END GLOBAL

//SETUP
void loadSetup() {
  //buildLibrary() ;
  loadSave(sketchPath("")+"preferences/setting/defaultSetting.csv") ;
  
  //load data object
  
  //load text interface 
  // 0 is French
  // 1 is english
  textGUI() ;
}
//END SETUP






// LOAD INFO OBJECT from the PRESCENE
/////////////////////////////////////
Table objectList, shaderBackgroundList;
int numGroup [] ; 
int [] objectLibraryOrder, objectID, objectGroup ;
String  [] objectName , objectAuthor, objectVersion, objectPack, objectRender, objectLoadName, objectSlider ; 
boolean [] objectClassic, objectP2D, objectP3D ;
//int [][] objectLibraryOrder, objectID, objectGroup ;
//String  [][] objectName , objectAuthor, objectVersion, objectPack, objectRender, objectLoadName, objectSlider ; 
//boolean [][] objectClassic, objectP2D, objectP3D ;
String [] shaderBackgroundName, shaderBackgroundAuthor ;



//BOUTON
int numButton [] ;
int numButtonTotalObjects ;
int lastDropdown, numDropdown ;
//BUTTON
int valueButtonGlobal[], valueButtonObj[], valueButtonTex[], valueButtonTypo[]  ;
Simple  BOmidi, BOcurtain,
        buttonBackground, 
        buttonLightOne, buttonLightOneAction,
        buttonLightTwo, buttonLightTwoAction,
        Bbeat, Bkick, Bsnare, Bhat;
        
//bouton objet
Simple[] BOf  ;
int transparenceBordBOf[], epaisseurBordBOf[], transparenceBoutonBOf[], posWidthBOf[], posHeightBOf[], longueurBOf[], hauteurBOf[]  ;
//bouton texture
Simple[] BTf  ;
int transparenceBordBTf[], epaisseurBordBTf[], transparenceBoutonBTf[], posWidthBTf[],posHeightBTf[], longueurBTf[], hauteurBTf[]  ;
//bouton typo
Simple[] BTYf  ;
int transparenceBordBTYf[], epaisseurBordBTYf[], transparenceBoutonBTYf[], posWidthBTYf[], posHeightBTYf[], longueurBTYf[], hauteurBTYf[]  ;


//Variable must be send to Scene
//paramètre bouton
int EtatBOf[], EtatBTf[], EtatBTYf[] ; 
// int EtatBIf[] ;


//////////
//DROPDOWN
int startLoopObject, endLoopObject, startLoopTexture, endLoopTexture, startLoopTypo, endLoopTypo ;
//GLOBAL
Dropdown dropdown[], dropdownFont, dropdownBackground, dropdownImage, dropdownFileText  ;

PVector posDropdownFont, posDropdownBackground, posDropdownImage, posDropdownFileText, posDropdown[] ;
PVector sizeDropdownFont, sizeDropdownBackground, sizeDropdownImage, sizeDropdownFileText, sizeDropdownMode ;
PVector posTextDropdown = new PVector(2,8)  ;

PVector totalSizeDropdown = new PVector () ;
PVector newPosDropdown = new PVector () ;

String [] modeListRomanesco, policeDropdownList, imageDropdownList, fileTextDropdownList, listDropdown, listDropdownBackground;

float margeAroundDropdown ;


//SETTING
 /////////
void buildLibrary() {
  objectList = loadTable(sketchPath("")+"preferences/objects/index_romanesco_objects.csv", "header") ;
  shaderBackgroundList = loadTable(sketchPath("")+"preferences/shaderBackgroundList.csv", "header") ;
  numByGroup() ;
  initVarObject() ;
  initVarButton() ;
  infoByObject() ;
  infoShaderBackground() ;
}

void initVarObject() {

  objectLibraryOrder = new int [numObj +1] ;
  objectID = new int [numObj +1] ;
  objectGroup = new int [numObj +1] ;
  objectName = new String [numObj +1] ;
  objectAuthor = new String [numObj +1] ;
  objectVersion = new String [numObj +1] ;
  objectPack = new String [numObj +1] ;
  objectRender = new String [numObj +1] ;
  objectLoadName = new String [numObj +1] ;
  objectClassic = new boolean [numObj +1] ;
  objectP2D = new boolean [numObj +1] ;
  objectP3D = new boolean [numObj +1] ;
  objectSlider = new String [numObj +1] ;
}



void initVarButton() {
  numButton = new int[NUM_GROUP_SLIDER] ;
  
  numButton[0] = 15 ;
  for (int i = 1 ; i < NUM_GROUP_SLIDER ; i++ ) {
    numButton[i] = numGroup[i]*10 ;
    numButtonTotalObjects += numGroup[i] ;
  }

  numDropdown = numObj +1 ; // add one for the dropdownmenu
  lastDropdown = numDropdown -1 ;
  
  valueButtonGlobal = new int[numButton[0]] ;
  valueButtonObj = new int[numButton[1]] ;
  valueButtonTex = new int[numButton[2]] ;
  valueButtonTypo = new int[numButton[3]] ;
  //bouton objet
  BOf = new Simple[numButton[1] +10] ;
  transparenceBordBOf =      new int[numButton[1] +10] ;
  epaisseurBordBOf =         new int[numButton[1] +10] ;
  transparenceBoutonBOf =    new int[numButton[1] +10] ;
  posWidthBOf =              new int[numButton[1] +10] ;
  posHeightBOf =             new int[numButton[1] +10] ;
  longueurBOf =              new int[numButton[1] +10] ;
  hauteurBOf =               new int[numButton[1] +10] ;
  
  //bouton texture
  BTf = new Simple[numButton[2] +10] ;
  transparenceBordBTf =      new int[numButton[2] +10] ;
  epaisseurBordBTf =         new int[numButton[2] +10] ;
  transparenceBoutonBTf =    new int[numButton[2] +10] ;
  posWidthBTf =              new int[numButton[2] +10] ;
  posHeightBTf =             new int[numButton[2] +10] ;
  longueurBTf =              new int[numButton[2] +10] ;
  hauteurBTf =               new int[numButton[2] +10] ;
  
  //bouton typo
  BTYf = new Simple[numButton[3] +10] ;
  transparenceBordBTYf =      new int[numButton[3] +10] ;
  epaisseurBordBTYf =         new int[numButton[3] +10] ;
  transparenceBoutonBTYf =    new int[numButton[3] +10] ;
  posWidthBTYf =              new int[numButton[3] +10] ;
  posHeightBTYf =             new int[numButton[3] +10] ;
  longueurBTYf =              new int[numButton[3] +10] ;
  hauteurBTYf =               new int[numButton[3] +10] ;
  
  //paramètre bouton
  EtatBOf = new int[numButton[1]] ;
  EtatBTf = new int[numButton[2]] ;
  EtatBTYf = new int[numButton[3]] ;
  // EtatBIf = new int[numButton] ;
  
  //dropdown
  modeListRomanesco = new String[numDropdown] ;
  dropdown = new Dropdown[numDropdown] ;
  posDropdown = new PVector[numDropdown] ;
  startLoopObject = 1 ;
  endLoopObject = 1 +numGroup[1] ;
  startLoopTexture = endLoopObject ; 
  endLoopTexture = startLoopTexture +numGroup[2] ;
  startLoopTypo = endLoopTexture ; 
  endLoopTypo = startLoopTypo +numGroup[3] ;

}


void infoShaderBackground() {
  int n = shaderBackgroundList.getRowCount() ;
  shaderBackgroundName = new String[n] ;
  shaderBackgroundAuthor = new String[n] ;
  for (int i = 0 ; i < n ; i++ ) {
     TableRow row = shaderBackgroundList.getRow(i) ;
     shaderBackgroundName[i] = row.getString("Name") ;
     shaderBackgroundAuthor[i] = row.getString("Author") ;
  }
}

void infoByObject() {
  for(int i = 0 ; i < numObj ; i++) {
    TableRow lookFor = objectList.getRow(i) ;
    int ID = lookFor.getInt("ID") ;
    for(int j = 0 ; j <= numObj ; j++) {
      if(ID == j ) { 
        objectLibraryOrder[j] =lookFor.getInt("Library Order") ;
        objectID [j] = lookFor.getInt("ID") ;
        objectGroup[j] = lookFor.getInt("Group");
        objectPack[j] = lookFor.getString("Pack");
        objectRender[j] = lookFor.getString("Render");
        objectAuthor[j] = lookFor.getString("Author");
        objectVersion[j] = lookFor.getString("Version");
        objectLoadName[j] = lookFor.getString("Class name");
        objectName[j] = lookFor.getString("Name");
        objectSlider[j] = lookFor.getString("Slider") ;
      }
    }
  }
}



void numByGroup() {
  numGroup  = new int[NUM_GROUP_SLIDER] ;
  for (TableRow row : objectList.rows()) {
    int objectGroup = row.getInt("Group");
    for (int i = 0 ; i < NUM_SLIDER ;i++) {
      if (objectGroup == i) numGroup[i] += 1 ;
    }
  }
  //give the num total of objects
  numObj = numGroup[1] +numGroup[2] +numGroup[3] ;
}
// END BUILD LIBRARY
////////////////////








//DRAW


// SAVE LOAD

// SAVE
///////
void saveSetting(File selection) {
  // opens file chooser
  String savePathSetting = selection.getAbsolutePath() ;
  
  if (selection != null) {
    saveSlider() ;
    midiButtonManager(true) ;
    saveTable(saveSetting, savePathSetting+".csv");
    saveSetting.clearRows() ;
  } 
  /*else {
    println("Aucune sauvegarde") ;
  }
  */
}




//LOAD
//////
Table loadSettingButton ;
//////
void loadSetting(File selection) {
  // opens file chooser
  String loadPathSetting = selection.getAbsolutePath();
  
  if (selection != null) {
    loadSaveSetting = true ;
    loadSave(loadPathSetting) ;
  } 
}


void loadSave(String path) {
  loadSettingButton = loadTable(path, "header");
  // create the good num of Var info about slider and button
  int countButton = 0 ;
  int countSlider = 0 ;
  
  for (TableRow row : loadSettingButton.rows()) {
    String s = row.getString("Type") ;
    /*
    if( s.equals("Button")  ){ 
     countButton++ ; 
    }
    */
    if( s.equals("Slider")  ){ 
      countSlider++ ; 
    }
  }
  infoSlider = new PVector [countSlider] ;
  // infoButton = new PVector [countButton] ;
  // we don't count from the save in case we add object and this one has never use before and he don't exist in the data base
  infoButton = new PVector [numObj*4 +10] ; 
  for(int i = 0 ; i < infoButton.length ; i++) infoButton[i] = new PVector() ;
  
  
  // re-init the counter for the new loop
  countButton = 0 ;
  countSlider = 0 ;
  for (TableRow row : loadSettingButton.rows()) {
    String s = row.getString("Type") ;
    //
    if( s.equals("Button")  ){ 
     int IDbutton = row.getInt("ID button") ;
     int IDmidi = row.getInt("ID midi") ;
     int onOff = row.getInt("On Off") ;
     infoButton[countButton] = new PVector(IDbutton,IDmidi,onOff) ;
     countButton++ ; 
    }
    //
    if( s.equals("Slider")  ){
     int IDslider = row.getInt("ID slider") ;
     int IDmidi = row.getInt("ID midi") ;
     int valueSlider = row.getInt("Value slider") ; 
     infoSlider[countSlider] = new PVector(IDslider,IDmidi,valueSlider) ; 
     countSlider++ ; //<>//
    }
  }
}


PVector infoSave(PVector [] list, int pos) {
  PVector info = new PVector() ;
  float v = 0 ;
  float IDmidi = 0 ;
  for(int i = 0 ; i < list.length ;i++) {
    
  if(list[i] != null ) if((int)list[i].x == pos) {
      v = list[i].z ;
      IDmidi = list[i].y ;
      info = new PVector(pos, IDmidi,v) ;
      break;
    } else {
      info = new PVector(-1,-1,-1) ;
    }
  }
  return info ;
}


void buttonSetSaveSetting() {
  // close loop to save the button statement, 
  // see void midiButtonManager(boolean saveButton)
  int rank = 0 ;
  // Background and Curtain
  if(infoButton[rank].z  == 1.0) buttonBackground.onOff = true ; else buttonBackground.onOff = false ;
  buttonBackground.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  if(infoButton[rank].z == 1.0) BOcurtain.onOff = true ; else BOcurtain.onOff = false ;
  BOcurtain.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  //LIGHT ONE
  if(infoButton[rank].z == 1.0) buttonLightOne.onOff = true ; else buttonLightOne.onOff = false ;
  buttonLightOne.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  if(infoButton[rank].z == 1.0) buttonLightOneAction.onOff = true ; else buttonLightOneAction.onOff = false ;
  buttonLightOneAction.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  // LIGHT TWO
  if(infoButton[rank].z == 1.0) buttonLightTwo.onOff = true ; else buttonLightTwo.onOff = false ;
  buttonLightTwo.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  if(infoButton[rank].z == 1.0) buttonLightTwoAction.onOff = true ; else buttonLightTwoAction.onOff = false ;
  buttonLightTwoAction.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  //SOUND
  if(infoButton[rank].z == 1.0) Bbeat.onOff = true ; else Bbeat.onOff = false ;
  Bbeat.IDmidi = (int)infoButton[rank].y ;
 rank++ ; 
  if(infoButton[rank].z == 1.0) Bkick.onOff = true ; else Bkick.onOff = false ;
  Bkick.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  if(infoButton[rank].z == 1.0) Bsnare.onOff = true ; else Bsnare.onOff = false ;
  Bsnare.IDmidi = (int)infoButton[rank].y ;
  rank++ ;
  if(infoButton[rank].z == 1.0) Bhat.onOff = true ; else Bhat.onOff = false ;
  Bhat.IDmidi = (int)infoButton[rank].y ; 
  rank++ ;
  
  //
  rank--  ;
  //
  
  int whichGroup = 1 ;
  int buttonRank ;
  for( int i = 1 ; i <= numGroup[whichGroup] ; i++ ) {
    for (int j = 1 ; j <= BUTTON_BY_OBJECT ; j++) {
      rank++ ;
      buttonRank = (int)infoButton[rank].x ;
      if(infoButton[rank].z == 1.0 && buttonRank == (i*10)+j) BOf[buttonRank].onOff = true ; else BOf[buttonRank].onOff = false ; 
      BOf[buttonRank].IDmidi = (int)infoButton[rank].y ; 
    }
  }
  whichGroup = 2 ; 
  for( int i = 1 ; i <= numGroup[whichGroup] ; i++ ) {
    for (int j = 1 ; j <= BUTTON_BY_OBJECT ; j++) {
      rank++ ;
      buttonRank = (int)infoButton[rank].x ;
      if(infoButton[rank].z == 1.0 && buttonRank == (i*10)+j) BTf[buttonRank].onOff = true ; else BTf[buttonRank].onOff = false ; 
      BTf[buttonRank].IDmidi = (int)infoButton[rank].y ; 
    } 
  }
  whichGroup = 3 ;
  for( int i = 1 ; i <= numGroup[whichGroup] ; i++ ) {
    for (int j = 1 ; j <= BUTTON_BY_OBJECT ; j++) {
      rank++ ;
      buttonRank = (int)infoButton[rank].x ;
      if(infoButton[rank].z == 1.0 && buttonRank == (i*10)+j) BTYf[buttonRank].onOff = true ; else BTYf[buttonRank].onOff = false ; 
      BTYf[buttonRank].IDmidi = (int)infoButton[rank].y ; 
    }
  }
}


// SAVE LOAD






//LOAD text Interface
Table textGUI;
int numCol = 15 ;
String[] genTxtGUI = new String[numCol] ;
String[] sliderNameOne = new String[numCol] ;
String[] sliderNameTwo = new String[numCol] ;
String[] sliderNameThree = new String[numCol] ;

TableRow [] row = new TableRow[numCol+1] ;

String lang[] ;

void textGUI() {
  if (!test)lang = loadStrings(sketchPath("") +"preferences/language.txt") ; else lang = loadStrings("preferences/language.txt") ;
  String l = join(lang,"") ;
  int language = Integer.parseInt(l);

  
  if( language == 0 ) { 
    textGUI = loadTable(sketchPath("")+"preferences/sliderListFR.csv", "header") ;
  } else if (language == 1 ) {
    textGUI = loadTable(sketchPath("")+"preferences/sliderListEN.csv", "header") ;
  } else {
    textGUI = loadTable(sketchPath("")+"preferences/sliderListEN.csv", "header") ;
  }
    
  for ( int i = 0 ; i < numCol ; i++) {

    row[i] = textGUI.getRow(i) ;
    for ( int j = 1 ; j < numCol ; j++) {
      String numCol = Integer.toString(j) ;
      if ( i == 0 ) genTxtGUI[j] = row[i].getString("Column "+numCol) ;
      if ( i == 1 ) sliderNameOne[j] = row[i].getString("Column "+numCol) ;
      if ( i == 2 ) sliderNameTwo[j] = row[i].getString("Column "+numCol) ;
      if ( i == 3 ) sliderNameThree[j] = row[i].getString("Column "+numCol) ;
    }
  }
}





//IMPORT VIGNETTE
void importPicButtonSetup() {

  
  //picto setting
  for(int i = 0 ; i<4 ; i++) {
    picCurtain[i]   = loadImage("picto/picto_curtain_"+i+".png") ;
    picMidi[i]   = loadImage("picto/picto_midi_"+i+".png") ;
    picSetting[i] = loadImage("picto/picto_setting_"+i+".png") ;
    picSound[i]   = loadImage("picto/picto_sound_"+i+".png") ;
    picAction[i]   = loadImage("picto/picto_action_"+i+".png") ;
  }
  // load thumbnail
  int num = numGroup[1] + numGroup[2] + numGroup[3] +1 ;
  OFF_in_thumbnail = new PImage[num] ;
  OFF_out_thumbnail = new PImage[num] ;
  ON_in_thumbnail = new PImage[num] ;
  ON_out_thumbnail = new PImage[num] ;
  for(int i=0 ;  i<num ; i++ ) {
    OFF_in_thumbnail[i] = loadImage("thumbnail/OFF_in/OFF_in_"+i+".png") ;
    OFF_out_thumbnail[i] = loadImage("thumbnail/OFF_out/OFF_out_"+i+".png") ;
    ON_in_thumbnail[i] = loadImage("thumbnail/ON_in/ON_in_"+i+".png") ;
    ON_out_thumbnail[i] = loadImage("thumbnail/ON_out/ON_out_"+i+".png") ;
  }
  
}
