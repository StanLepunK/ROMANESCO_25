ObjectRomanescoManager romanescoManager ;
// CLASS ROMANESCO MANAGER
void romanescoSetup() {
  romanescoManager = new ObjectRomanescoManager(this);
  romanescoManager.addObjectRomanesco() ;
  romanescoManager.finishIndex() ;
  romanescoManager.writeInfoUser() ;
}


//Update the var of the object
void updateObject(int ID, int group) {
  //initialization
  if(!initValueMouse[ID]) { 
    mouse[ID] = mouse[0].copy() ;
    pen[ID] = pen[0].copy() ;
    initValueMouse[ID] = true ;
  }
  if(!initValueControleur[ID]) {
    font[ID] = font[0] ;
    updateSliderValue(ID,group ) ;
    initValueControleur[ID] = true ;
    whichImage[ID] = whichImage[0] ;
    whichText[ID] = whichText[0] ;
  }
  
  // info
  objectInfoDisplay[ID] = displayInfo?true:false ;
  
  
  if(parameter[ID]) {
    whichImage[ID] = whichImage[0] ;
    whichText[ID] = whichText[0] ;
    font[ID] = font[0] ;
    updateSliderValue(ID,group ) ;
  }
  updateSound(ID) ;
  
  if(action[ID] ){
    if(spaceTouch) {
      pen[ID] = pen[0].copy() ;
      mouse[ID] = mouse[0].copy() ;
    }
    if (mTouch) motion[ID] = !motion[ID] ;
    if (hTouch) horizon[ID] = !horizon[ID] ;
    if (rTouch) reverse[ID] = !reverse[ID] ;
    /*
    clickLongLeft[ID] = clickLongLeft[0] ;
    clickLongRight[ID] = clickLongRight[0] ;
    */
    clickLongLeft[ID] = ORDER_ONE ;
    clickLongRight[ID] = ORDER_TWO ;
    clickShortLeft[ID] = clickShortLeft[0] ;
    clickShortRight[ID] = clickShortRight[0] ;
  }
}




//
void updateSliderValue(int ID, int group) {
  for ( int i = 0 ; i <= NUM_GROUP ; i++) if( group == i ) {
    int which_group = i-1 ;
    if(fullRendering) {
      /**
      Changer : le fill et le stroke doivent se calculer sur des valeurs séparée, hue, sat, bright and alpha, sinon quand on les change cela change tout d'une seul coup.
      */
      // fill obj
      if      ( !firstOpeningObj[ID] ) fillObj[ID]                                          = color ( fill_hue_raw[which_group], fill_sat_raw[which_group],  fill_bright_raw[which_group], fill_alpha_raw[which_group]) ; 
      else if ( fill_hue_temp[which_group] != fill_hue_raw[which_group] ) fillObj[ID]       = color ( fill_hue_raw[which_group], saturation(fillObj[ID]),    brightness(fillObj[ID]),      alpha(fillObj[ID])) ;
      else if ( fill_sat_temp[which_group] != fill_sat_raw[which_group] ) fillObj[ID]       = color ( hue(fillObj[ID]),          fill_sat_raw[which_group],  brightness(fillObj[ID]),      alpha(fillObj[ID])) ; 
      else if ( fill_bright_temp[which_group] != fill_bright_raw[which_group] ) fillObj[ID] = color ( hue(fillObj[ID]),          saturation(fillObj[ID]),    fill_bright_raw[which_group], alpha(fillObj[ID])) ;   
      else if( fill_alpha_temp[which_group] != fill_alpha_raw[which_group] ) fillObj[ID]    = color ( hue(fillObj[ID]),          saturation(fillObj[ID]),    brightness(fillObj[ID]),      fill_alpha_raw[which_group]) ;  
      // stroke obj
      if      ( !firstOpeningObj[ID] ) strokeObj[ID]                                          = color ( stroke_hue_raw[which_group], stroke_sat_raw[which_group],  stroke_bright_raw[which_group], stroke_alpha_raw[which_group]) ; 
      else if ( stroke_hue_temp[which_group] != stroke_hue_raw[which_group] ) strokeObj[ID]       = color ( stroke_hue_raw[which_group], saturation(strokeObj[ID]),    brightness(strokeObj[ID]),      alpha(strokeObj[ID])) ;
      else if ( stroke_sat_temp[which_group] != stroke_sat_raw[which_group] ) strokeObj[ID]       = color ( hue(strokeObj[ID]),          stroke_sat_raw[which_group],  brightness(strokeObj[ID]),      alpha(strokeObj[ID])) ; 
      else if ( stroke_bright_temp[which_group] != stroke_bright_raw[which_group] ) strokeObj[ID] = color ( hue(strokeObj[ID]),          saturation(strokeObj[ID]),    stroke_bright_raw[which_group], alpha(strokeObj[ID])) ;   
      else if( stroke_alpha_temp[which_group] != stroke_alpha_raw[which_group] ) strokeObj[ID]    = color ( hue(strokeObj[ID]),          saturation(strokeObj[ID]),    brightness(strokeObj[ID]),      stroke_alpha_raw[which_group]) ;  
      // thickness
      if (thicknessRaw[which_group] != thicknessTemp[which_group] || !firstOpeningObj[ID]) thicknessObj[ID] = thicknessRaw[which_group] ;
    } else {
      // preview display
      fillObj[ID] = COLOR_FILL_OBJ_PREVIEW ;
      strokeObj[ID] =  COLOR_STROKE_OBJ_PREVIEW ;
      thicknessObj[ID] = THICKNESS_OBJ_PREVIEW ;
    }
    // column 2
    if (sizeXRaw[which_group] != sizeXTemp[which_group] || !firstOpeningObj[ID]) sizeXObj[ID] = sizeXRaw[which_group] ; 
    if (sizeYRaw[which_group] != sizeYTemp[which_group] || !firstOpeningObj[ID]) sizeYObj[ID] = sizeYRaw[which_group] ; 
    if (sizeZRaw[which_group] != sizeZTemp[which_group] || !firstOpeningObj[ID]) sizeZObj[ID] = sizeZRaw[which_group] ;
    if (canvasXRaw[which_group] != canvasXTemp[which_group] || !firstOpeningObj[ID]) canvasXObj[ID] = canvasXRaw[which_group] ; 
    if (canvasYRaw[which_group] != canvasYTemp[which_group] || !firstOpeningObj[ID]) canvasYObj[ID] = canvasYRaw[which_group] ; 
    if (canvasZRaw[which_group] != canvasZTemp[which_group] || !firstOpeningObj[ID]) canvasZObj[ID] = canvasZRaw[which_group] ;
    if (familyRaw[which_group] != familyTemp[which_group] || !firstOpeningObj[ID]) familyObj[ID] = familyRaw[which_group] ;
    if (quantityRaw[which_group] != quantityTemp[which_group] || !firstOpeningObj[ID]) quantityObj[ID] = quantityRaw[which_group] ;
    if (lifeRaw[which_group] != lifeTemp[which_group] || !firstOpeningObj[ID]) lifeObj[ID] = lifeRaw[which_group] ;
    //column 3
    if (speedRaw[which_group] != speedTemp[which_group] || !firstOpeningObj[ID]) speedObj[ID] = speedRaw[which_group] ;
    if (directionRaw[which_group] != directionTemp[which_group] || !firstOpeningObj[ID]) directionObj[ID] = directionRaw[which_group] ;
    if (angleRaw[which_group] != angleTemp[which_group] || !firstOpeningObj[ID]) angleObj[ID] = angleRaw[which_group] ;
    if (amplitudeRaw[which_group] != amplitudeTemp[which_group] || !firstOpeningObj[ID]) amplitudeObj[ID] = amplitudeRaw[which_group] ;
    if (attractionRaw[which_group] != attractionTemp[which_group] || !firstOpeningObj[ID]) attractionObj[ID] = attractionRaw[which_group] ;
    if (repulsionRaw[which_group] != repulsionTemp[which_group] || !firstOpeningObj[ID]) repulsionObj[ID] = repulsionRaw[which_group] ;
    if (alignmentRaw[which_group] != alignmentTemp[which_group] || !firstOpeningObj[ID]) alignmentObj[ID] = alignmentRaw[which_group] ;
    if (influenceRaw[which_group] != influenceTemp[which_group] || !firstOpeningObj[ID]) influenceObj[ID] = influenceRaw[which_group] ;
    if (analyzeRaw[which_group] != analyzeTemp[which_group] || !firstOpeningObj[ID]) analyzeObj[ID] = analyzeRaw[which_group] ; 

    //future slider ???
    if (fontSizeRaw[which_group] != fontSizeTemp[which_group] || !firstOpeningObj[ID]) fontSizeObj[ID] = fontSizeRaw[which_group] ;
  }
  /** 
  make the obj has be never update in the future except by the moving slider 
  */
  firstOpeningObj[ID] = true ; 

}





//
void updateSound(int ID) {
  if(sound[ID]) {
    left[ID]  = left[0] ;// value(0,1)
    right[ID] = right[0] ;//float value(0,1)
    mix[ID]  = mix[0] ;//   is average volume between the left and the right / float value(0,1)
    
    beat[ID] = beat[0] ;//    is beat : value 1,10 
    kick[ID] = kick[0] ;//   is beat kick : value 1,10 
    snare[ID] = snare [0] ;//   is beat snare : value 1,10 
    hat[ID]  = hat[0] ;//   is beat hat : value 1,10 

    tempo[ID]   = tempo[0] ;     // global speed of track  / float value(0,1)
    tempoBeat[ID] = tempoBeat[0] ;  // speed of track calculate on the beat
    tempoKick[ID] = tempoKick[0] ; // speed of track calculate on the kick
    tempoSnare[ID] = tempoSnare[0] ;// speed of track calculate on the snare
    tempoHat[ID] = tempoHat[0] ;// speed of track calculte on the hat
    
    for (int i = 0 ; i <NUM_BANDS ; i++) {
      band[ID][i] = band[0][i] ;
    }
  } else {
    left[ID]  = 1 ;// value(0,1)
    right[ID] = 1 ;//float value(0,1)
    mix[ID]  = 1 ;//   is average volume between the left and the right / float value(0,1)
    
    beat[ID] = 1 ;//    is beat : value 1,10 
    kick[ID] = 1 ;//   is beat kick : value 1,10 
    snare[ID] = 1 ;//   is beat snare : value 1,10 
    hat[ID]  = 1 ;//   is beat hat : value 1,10 
    
    tempo[ID]   = 1 ;     // global speed of track  / float value(0,1)
    tempoBeat[ID] = 1 ;  // speed of track calculate on the beat
    tempoKick[ID] = 1 ; // speed of track calculate on the kick
    tempoSnare[ID] = 1 ;// speed of track calculate on the snare
    tempoHat[ID] = 1 ;// speed of track calculte on the hat
    
    for (int i = 0 ; i <NUM_BANDS ; i++) {
      band[ID][i] = 1 ;
    }
  }
}


// RESET list and Object
// by action
boolean resetAction(int ID) {
  boolean e = false ;
  //global delete
  if (backspaceTouch) e = true ;
  //SPECIFIC DELETE when the paramer button of contrôleur is ON
  else if (deleteTouch) if ( action[ID]) e = true ;
  return e ;
}
// by parameter
boolean resetParameter(int ID) {
  boolean e = false ;
  //global delete
  if (backspaceTouch) e = true ;
  //SPECIFIC DELETE when the paramer button of contrôleur is ON
  else if (deleteTouch) if (parameter[ID]) e = true ;
  return e ;
}
///////////////////////////////////////




//CLASS
// inspired from Andreas Gysin work from The Abyss Project
class ObjectRomanescoManager {
  private ArrayList<Romanesco>RomanescoList ;
  private ArrayList<Class>objectRomanescoList;
  
  PApplet parent;
  String objectNameRomanesco [] ;
  String classRomanescoName [] ;
  int numClasses ;
  
  ObjectRomanescoManager(PApplet parent) {
    this.parent = parent;
    RomanescoList = new ArrayList<Romanesco>() ;
    //scan the existant classes
    objectRomanescoList = scanClasses(parent, "Romanesco");
  }
  
  //STEP ONE
  //ADD CLASSES
  private ArrayList<Class> scanClasses(PApplet parent, String superClassName) {
    ArrayList<Class> classes = new ArrayList<Class>();

    Class[] c = parent.getClass().getDeclaredClasses();
    
    //create the index table
    for (int i=0; i<c.length; i++) {
      if (c[i].getSuperclass() != null && c[i].getSuperclass().getSimpleName().equals(superClassName) ) {
        classes.add(c[i]);
        numClasses = classes.size() ;
      }
    }
    createIndex(numClasses) ;
    
    //init the String info
    objectNameRomanesco = new String[numClasses] ;
    for ( int i =0 ; i <objectNameRomanesco.length ; i++) objectNameRomanesco[i] =("") ;
    
    //add class in Romanesco, plus add info in the String for the index
    int numObjectRomanesco = 0 ;
    for (int i=0; i<c.length; i++) {
      if (c[i].getSuperclass() != null && c[i].getSuperclass().getSimpleName().equals(superClassName) ) {
        objectNameRomanesco[numObjectRomanesco] = c[i].getSimpleName() ;
        numObjectRomanesco += 1 ;
      }
    }
    beginIndex() ;
    
    
    return classes;  
  }
  //END ADD CLASSES
  /////////////////
  
  
  
  //////////////////////////////////////
  // INDEX and INFO OBJECT FROM CLASSES
  String pathObjects = preferencesPath+"objects/" ;
  
  ////////////////
  // INTERN VOID
  //create the canvas index
  void createIndex(int num) {
    indexObjects = new Table() ;
    indexObjects.addColumn("Library Order") ;
    indexObjects.addColumn("Name") ;
    indexObjects.addColumn("ID") ;
    indexObjects.addColumn("Group") ;
    indexObjects.addColumn("Version") ;
    indexObjects.addColumn("Author") ;
    indexObjects.addColumn("Class name") ;
    indexObjects.addColumn("Pack") ;
    indexObjects.addColumn("Render") ;
    indexObjects.addColumn("Mode") ;
    
    
    // add row
    rowIndexObject = new TableRow [num] ;
    for(int i = 0 ; i < rowIndexObject.length ; i++) {
      rowIndexObject[i] = indexObjects.addRow() ;
    }
    
    // create var for info object, need to be create here
    int numPlusOne = num + 1 ;
    objectID = new int[numPlusOne] ;
    objectName = new String[numPlusOne] ;
    objectAuthor = new String[numPlusOne] ;
    objectVersion = new String[numPlusOne] ;
    objectPack = new String[numPlusOne] ;
    objectInfo = new String[numPlusOne] ;
    // init var
    for ( int i = 0 ; i<numPlusOne ; i++ ) {
      objectName [i] = "My name is Nobody" ;
      objectInfo [i] = "Sorry nobody write about me !" ;
      objectID [i] = 0 ;
    }
    
    
    
  }
  
  // put information in the index
  void beginIndex() {
    for(int i = 0 ; i < rowIndexObject.length ; i++) {
      rowIndexObject[i].setString("Class name", objectNameRomanesco[i]) ;
      rowIndexObject[i].setInt("Library Order", i+1) ;
    }
  }
  

  
  
  
  ////////////////
  /**
  EXTERNAL  VOID
  * romanescoManager.finishIndex() ;
  * use with in romanescoSetup() {}
  */
  //finish index
  void finishIndex() {
      // catch the different parameter from object class Romanesco
    for (int i=0 ; i < RomanescoList.size() ; i++ ) {
      Romanesco objR = (Romanesco) RomanescoList.get(i) ;
      rowIndexObject[i].setString("Name", objR.romanescoName) ;
      rowIndexObject[i].setInt("ID", objR.IDobj) ;
      rowIndexObject[i].setInt("Group", objR.IDgroup) ;
      rowIndexObject[i].setString("Author", objR.romanescoAuthor) ;
      rowIndexObject[i].setString("Version", objR.romanescoVersion) ;
      rowIndexObject[i].setString("Render", objR.romanescoRender) ;
      rowIndexObject[i].setString("Pack", objR.romanescoPack) ;
      rowIndexObject[i].setString("Mode", objR.romanescoMode) ;
      rowIndexObject[i].setString("Slider", objR.romanescoSlider) ;
    }
    saveTable(indexObjects, pathObjects+"index_romanesco_objects.csv") ; 
    NUM_OBJ = RomanescoList.size() ;
  }
  
  /*
  * romanescoManager.writeInfoUser() ;
  * use with in romanescoSetup() {}
  */
  //ADD info for the user
  void writeInfoUser() {
      // catch the different parameter from object class Romanesco
    for (int i=0 ; i < RomanescoList.size() ; i++ ) {
      Romanesco objR = (Romanesco) RomanescoList.get(i) ;
      objectID[objR.IDobj] = objR.IDobj ;
      objectName[objR.IDobj] = objR.romanescoName ;
      objectAuthor[objR.IDobj] = objR.romanescoAuthor ;
      objectVersion[objR.IDobj] = objR.romanescoVersion ;
      objectPack[objR.IDobj] = objR.romanescoPack ;
    }
  }
    
  
  //END of the INDEX
  //////////////////
  
  
  
  
  
  
  
  /////////////////////////////////
  //ADD OBJECT from the sub-classes
  void addObjectRomanesco() {
    int n = floor(objectRomanescoList.size()-1) ;
    for( int i = 0 ; i <= n ; i++) {
    addObject(i) ;
    }
  }
  //
  public Romanesco addObject(int i) {
    if (i < 0 || i >= objectRomanescoList.size()) return null;
    
    Romanesco f = null;
    try {
      Class c = objectRomanescoList.get(i);
      Constructor[] constructors = c.getConstructors();
      f = (Romanesco) constructors[0].newInstance(parent);
    }
    catch (InvocationTargetException e) {
      System.out.println(e);
    } 
    catch (InstantiationException e) {
      System.out.println(e);
    } 
    catch (IllegalAccessException e) {
      System.out.println(e);
    } 
    //add object 
    if (f != null) {
      addObject(f);
    }
    return f;
  }
  
  // finalization of adding object
  private void addObject(Romanesco objR) {
    objR.setManagerReference(this);
    RomanescoList.add(objR);
  }
  //END ADD OBJECT
  ////////////////
  
  
  
  ////////
  //SETUP
  // INIT ROMANESCO OBJECT
  void initObj() {
    for (Romanesco objR : RomanescoList) {
      motion[objR.IDobj] = true ;
      initValueMouse[objR.IDobj] = true ;
      objR.setting() ;
      posObjRef[objR.IDobj] = startingPosition[objR.IDobj].copy() ;
    }
  }
  

  // END SETUP
  ////////////
  
  
  
  ////////
  // DRAW
  void displayObject(boolean movePos, boolean moveDir, boolean movePosAndDir) {
    // when you use the third order Romanesco understand the the first and the second are true
    if(movePosAndDir) {
      moveDir = true ;
      movePos = true ;
    }
    
    //the method
    if (show_object != null) {
      for (Romanesco objR : RomanescoList) {
        if (show_object[objR.IDobj]) {
          updateObject(objR.IDobj, objR.IDgroup) ;
          pushMatrix() ;
          addRefObj(objR.IDobj) ;
          if(vLongTouch && action[objR.IDobj] ) objectMove(movePos, moveDir, objR.IDobj) ;
          P3DmoveObj(objR.IDobj) ;
          objR.display() ;
          popMatrix() ;
        }
      }
    }
  }
  // END DRAW
  //////////
}
//END OBJECT ROMANESCO MANAGER












////////////////////////
//SUPER CLASS ROMANESCO
abstract class Romanesco {
  String romanescoName, romanescoAuthor, romanescoVersion, romanescoPack, romanescoRender, romanescoMode, romanescoSlider ;
  int IDobj, IDgroup ;
  //object manager return
  ObjectRomanescoManager orm ;
  
  public Romanesco() {
    romanescoName = "Unknown" ;
    romanescoAuthor = "Anonymous";
    romanescoVersion = "Alpha";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
    romanescoSlider = "all" ;
    IDgroup = 0 ;
    IDobj = 0 ;
  }
  
  //manager return
  void setManagerReference(ObjectRomanescoManager orm) {
    this.orm = orm;
  }
  
  //IMPORTANT
  //declared the void use in the sub-classes here
  abstract void setting();
  abstract void display();
}
// END SUPER ROMANESCO
///////////////////////
