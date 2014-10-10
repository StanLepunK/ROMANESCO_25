class Escargot extends SuperRomanesco {
  public Escargot() {
    //from the index_objects.csv
    romanescoName = "Image" ;
    IDobj = 16 ;
    IDgroup = 2 ;
    romanescoAuthor  = "Stan le Punk";
    romanescoVersion = "version 1.4";
    romanescoPack = "Base" ;
    romanescoRender = "P3D" ;
    romanescoMode = "Original/Raw/Point/Ellipse/Rectangle/Box/Cross/SVG/Vitraux" ;
    romanescoSlider = "Hue fill,Saturation fill,Brightness fill,Alpha fill,Hue stroke,Saturation stroke,Brightness stroke,Alpha stroke,Thickness,Width,Height,Depth,Speed,Direction,Amplitude,Analyze,Quantity,Force" ;
  }
  //GLOBAL
  String pathSVG ;
    //VORONOI TOXIC
  // ranges for x/y positions of points
  FloatRange xpos, ypos;
  // helper class for rendering
  ToxiclibsSupport gfx;
  // empty voronoi mesh container
  Voronoi voronoi = new Voronoi();
  //VORONOI for void
  int thicknessVoronoi = 1 ;
  color colorStrokeVoronoi = color (0,0,0)  ;
  boolean whichColorVoronoi ;
  //ratio size image and window
  PVector ratioImgWindow = new PVector(1,1) ;
  //color strokeColor  ; // color for the stroke
  int thickness = 1 ; // if "zero" noStroke() is activate
  boolean useNewPalettePixColorToDisplay = true ; // if want use the original picture from the raw list to find color write "FALSE", but if you do that you can use the possibility to change the palette in Live, else use "TRUE"
  
  boolean colorPixDisplay = true ;
  boolean fillDisplay = true ;
  
  //ANALYZE PICTURE
  //size analyze pixel
  int pixelAnalyzeSize = 2; // pour la grille de mon cahier tester vec 40
  int pixelAnalyzeSizeRef = 2  ;
  //size display pixel
  int pixelDisplaySize = 1;
  int pixelStrokeWeight = 1;
  //escargot analyze
  int radiusAnalyze = 25 ; // radius analyze around the pixel
  int radiusAnalyzeRef = 25 ; // radius analyze around the pixel
  int speedAnalyze = 10 ; // quantity of point be analyzing in the image. It's random choice on the surface of the image.
  int maxEntryPoints = 500 ; // quantity of point be analyzing in the image. It's random choice on the surface of the image.
  int maxEntryPointsRef = 500 ; // quantity of point be analyzing in the image. It's random choice on the surface of the image.
  int maxVoronoiPoints = 125000 ; // max point for voronoi calcula bahond is very very slow
  
  String modeTri = ("b") ; // you can choice in few mode "hsb"(exact same hue, saturation and brithness the other mode is part of this three composantes, "b", "s", "hs", "hb", "sb"
  boolean useNewPalettePixColorToAnalyze = true ; // choice the color you analyze, the raw color you must write "FALSE" if you look in the "newColor" because you have change the color pixel for anything you must write "TRUE", best analyze with the new palette
  
  
  //PALETTE COLOR
  //random palette
  PVector HSBpalette = new PVector (6, 6, 12) ;  // quantity for each components of palette in HSB order // need "1" minimum in each componante
  //palette from you
  int hueColor[] =    new int [(int)HSBpalette.x] ;
  int satColor[] =    new int [(int)HSBpalette.y] ;
  int brightColor[] = new int [(int)HSBpalette.z] ;
  //spectrum for the color mode and more if you need
  PVector HSBmode = new PVector (360,100,100) ; // give the color mode in HSB
  
  //MOTION POSITION
  //Wind force, direction
  int windDirection = 25; //direction between 1 and 360
  int windForce = 3 ; //use the natural code of the wind 0 to 9 is good
  int objMotion = 1 ; //motion of the pixel is under influence of the wind, if the wind is strong the pixel motion become low
  PVector motionInfo = new PVector(windDirection, windForce, objMotion)  ;
  //ratio for the image, say if the picture must be adapted to the size window or not
  boolean ratioImg = true ;
  
  //COLOR MOTION
    /*
    each data (hueVariation, satVariation, brightVariation) is PVector with 3 values :
    value 1 : Pivot (laticce) between 0 to max, the max value is the componant of HSB for example 360 for the hue if it's a value choice is the colorMode
    value 2 : Speed evolution of this value : no max or min value but is better to use very small value like 0.1 or less
    value 3 : factor multiplication variation of the value 1 (pivot) must be include between "ZERO" and "ONE", if the value is "ZERO" it's the max of variation, if it's "ONE there's no variation 
    */
  //hue motion
  int huePivot = 180 ; // choice the color pivot on the wheel color, between "zero" and "HSBmode.x" ( HSBmode.x is the value of the hue wheel : generally 360 )
  float hueSpeed = 0.001 ; // Speed evolution of this value : no max or min value but is better to use very small value like 0.1 or less
  float hueRange = 0.0 ; // between "zero" and "one" : "zero" if the max amplitude between the pivot and the color start
  PVector hueVariation = new PVector (huePivot, hueSpeed, hueRange ) ;
  //saturation motion
  int satPivot = 10 ; // choice the color pivot on the wheel color, between "zero" and "HSBmode.y" ( HSBmode.y is the value of the saturation range : generally 100 )
  float satSpeed = 0.01 ; // no max or min value but is better to use very small value like 0.1 or less
  float satRange = 0.00 ; // between "zero" and "one" : "zero" if the max amplitude between the pivot and the color start
  PVector satVariation = new PVector (satPivot, satSpeed, satRange ) ;
  //saturation motion
  int brightPivot = 10 ; // choice the color pivot on the wheel color, between "zero" and "HSBmode.y" ( HSBmode.y is the value of the saturation range : generally 100 )
  float brightSpeed = 0.01 ; // no max or min value but is better to use very small value like 0.1 or less
  float brightRange = 0.00 ; // between "zero" and "one" : "zero" if the max amplitude between the pivot and the color start
  PVector brightVariation = new PVector (brightPivot, brightSpeed, brightRange ) ;
  
  //SOUND
  int forceBeat = 1 ;
  
  
  //SETUP
  void setting() {
    startPosition(IDobj, 0, 0, 0) ;
    if(!scene) maxVoronoiPoints = 250 ;
    //load pattern SVG to display a Pixel pattern you create in Illustrator or other software
    pathSVG = sketchPath("")+"preferences/pixel/model.svg" ;
    shapeSVGsetting(pathSVG) ;
    
    //random palette
    paletteRandom(HSBpalette, HSBmode ) ; // you must give the number of color and the size spectre color, here it's 360 for the hue and 100 for the rest
    
    //palette from you
    /*
    for ( int i = 0 ; i < (int)HSBpalette.x ; i++ ) hueColor[i] =    i * int(HSBmode.x /HSBpalette.x) ; // not minus by one because it's a whell system
    for ( int i = 0 ; i < (int)HSBpalette.y ; i++ ) satColor[i] =    i * int(HSBmode.y /(HSBpalette.y -1)) ;
    for ( int i = 0 ; i < (int)HSBpalette.z ; i++ ) brightColor[i] = i * int(HSBmode.z /(HSBpalette.z -1)) ;
    paletteClassic(hueColor, satColor, brightColor, HSBmode) ;
    */
  
    //step 2 if you use Voronoi
    //setting voronoi
    voronoiToxicSetup() ;
    
  }
  
  
  
  String imgPathRef = ("") ;
  //DRAW
  void display() {
    
    loadImg(IDobj) ;
    
    if(img[IDobj] == null)  {
      img[IDobj] = loadImage(imagePath[whichImage[IDobj]]) ;
    } else {
      //MOTION
      windForce = (int)map(speedObj[IDobj],0,1,0,13) ;
      windDirection = (int)directionObj[IDobj] ;
      objMotion = int(map(forceObj[IDobj],0,1, 0,20) *(1.0 + pen[IDobj].z)) ;
      motionInfo.y = windForce ;
      //PEN
       if (pen[IDobj].z == 1 ) pen[IDobj].z = 0 ; else pen[IDobj].z = pen[IDobj].z ;
       if( (pen[IDobj].x == 1.0 && pen[IDobj].y == 1.0) || (pen[IDobj].x == 0.0 && pen[IDobj].y == 0.0) ) {
         motionInfo.x = windDirection  ; 
       } else {
         PVector convertTilt = new PVector (-pen[IDobj].x, -pen[IDobj].y) ;
         motionInfo.x = deg360(convertTilt) ;
       }
       
       // if (!spaceTouch) for( Pixel p : listEscargot) {
       //alternat beween the pen and the controleur
       // if( pen[IDobj].x == 0 && pen[IDobj].y == 0 ) newDirection = normalDir(int(map(valueObj[IDobj][18],0,100,0,360))) ; else newDirection = new PVector (-pen[IDobj].x  , -pen[IDobj].y ) ;
       
       if (!motion[IDobj]) for( Pixel p : listEscargot) {
         p.updatePosPixel(motionInfo, img[IDobj]) ;
       }
      ////////////////
      
      //ANALYZE
      //change the size of pixel ref for analyzing
      if (pixelAnalyzeSize != pixelAnalyzeSizeRef || radiusAnalyze != radiusAnalyzeRef || maxEntryPoints != maxEntryPointsRef) reInitilisationAnalyze() ;
  
      pixelAnalyzeSizeRef = pixelAnalyzeSize;
      radiusAnalyzeRef = radiusAnalyze ;
      maxEntryPointsRef = maxEntryPoints ;
      
      int n = int(map(quantityObj[IDobj],0,100,10,150)) ;
      maxEntryPoints = n *n ;
      
      // security for the voronoï displaying, because if you change the analyze in the voronoi process, Romanesco make the Arraylist error
      if(mode[IDobj] != 8 || (maxEntryPoints != maxEntryPointsRef && scene) ) {
        //if (maxEntryPoints > listPixelRaw.size() / 4 ) maxEntryPoints = listPixelRaw.size() ;
        radiusAnalyze = int(map(amplitudeObj[IDobj],0,1,2,100));
        pixelAnalyzeSize = int(map(analyzeObj[IDobj],0,1,100,2));
      } else {
        if(maxEntryPoints > maxVoronoiPoints) maxEntryPoints = maxVoronoiPoints  ;
      }
  
      
       //security for the droping img from external folder
       if(parameter[IDobj] && rTouch ) ratioImg = !ratioImg ;
       if(img[IDobj] != null && img[IDobj].width > 3 && ratioImg ) {
         analyzeImg(pixelAnalyzeSize) ;
         // ratioImgWindow = new PVector ((float)width / (float)img.width , (float)height / (float)img.height ) ;
         ratioImgWindow = new PVector ((float)width / (float)img[IDobj].width , (float)width / (float)img[IDobj].width ) ;
       } else if (img[IDobj] != null && img[IDobj].width > 3 && !ratioImg) {
         analyzeImg(pixelAnalyzeSize) ;
         ratioImgWindow = new PVector(1,1) ;
       } else {
         ratioImgWindow = new PVector(1,1) ;
       }
       
       //size and thickness
       PVector sizePix = new PVector (map(sizeXObj[IDobj],.1,width, 1, height/30 ), map(sizeYObj[IDobj],.1,width, 1, height/30 ), map(sizeZObj[IDobj],.1,width, 1, height/30 )) ;
       float sizePoint = map(sizeXObj[IDobj],.1,width, 1, height/6 ) ;
       float thickPix = map(thicknessObj[IDobj],0.1,height *.33, 0.1, height/10 ) ;
       
       // range 100
       float soundHundredMin = random(80) ;
       float soundHundredMax = random(soundHundredMin, soundHundredMin +20) ;
       PVector rangeReactivitySoundHundred = new PVector (soundHundredMin, soundHundredMax) ;
       //range 360
       float soundThreeHundredSixtyMin = random(330) ;
       float soundThreeHundredSixtyMax = random(soundThreeHundredSixtyMin, soundThreeHundredSixtyMin +30) ;
       PVector rangeReactivitySoundThreeHundredSixty = new PVector (soundThreeHundredSixtyMin, soundThreeHundredSixtyMax) ;
       //Music factor
       PVector musicFactor = new PVector ( allBeats(IDobj) *left[IDobj], allBeats(IDobj) *right[IDobj]) ;
       forceBeat = (int)map(forceObj[IDobj],0,1,1,40) ;

       
       // update image
       if(parameter[IDobj] && imgPathRef != imagePath[whichImage[IDobj]] ) {
         analyzeDone = false ;
         escargotGOanalyze = false ;
         escargotClear() ;
         imgPathRef = imagePath[whichImage[IDobj]] ;
       }
      
      
      
      //choice new pattern SVG
      if ( action[IDobj] && pTouch ) {
        //step 1 clear the list for new analyze
        drawVertexSVG = false ;
        selectInput("select SVG pattern 50x50", "choiceSVG");
      }
      
      //change the color palette
      if (action[IDobj] && xTouch ) paletteRandom(HSBpalette, HSBmode ) ;
      
      //clear the pixels for the new analyze
      if (action[IDobj] && ( deleteTouch || backspaceTouch)) {
        escargotClear() ;
        analyzeDone = false ;
        totalPixCheckedInTheEscargot = 0 ;
      }
  
  
  
      
  
       //CHANGE MODE DISPLAY
      /////////////////////
      // translate((width*.5)-(img.width *.5) ,(height *.5)-(img.height *.5),0) ;
      if (mode[IDobj] == 0 || mode[IDobj] == 255 ) {
        displayRawPixel(sizePoint, fillObj[IDobj], rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow) ;
      } else if (mode[IDobj] == 1 ) {
        escargotRaw(sizePoint, fillObj[IDobj], rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow) ;
      } else if (mode[IDobj] == 2 ) {
        escargotPoint(sizePix, fillObj[IDobj], rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow) ;
      } else if (mode[IDobj] == 3 ) {
        escargotEllipse(sizePix, thickPix, fillObj[IDobj], strokeObj[IDobj], rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow) ;
      } else if (mode[IDobj] == 4 ) {
        escargotRect(sizePix, thickPix, fillObj[IDobj], strokeObj[IDobj], rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow) ;
      }else if (mode[IDobj] == 5 ) {
        escargotBox(sizePix, thickPix, fillObj[IDobj], strokeObj[IDobj], rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow, horizon[IDobj]) ;
      } else if (mode[IDobj] == 6 ) {
        escargotCross(sizePix, thickPix, fillObj[IDobj], rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow) ;
      } else if (mode[IDobj] == 7 ) {
        escargotSVG(sizePix, thickPix, fillObj[IDobj], strokeObj[IDobj], rangeReactivitySoundHundred, rangeReactivitySoundThreeHundredSixty, musicFactor, ratioImgWindow) ;
      } else if (mode[IDobj] == 8 ) {
        //if( listEscargot.size() < 600) {
        if( listEscargot.size() < maxVoronoiPoints + maxVoronoiPoints/10) {
          voronoiStatic(fillObj[IDobj], strokeObj[IDobj], thickPix, useNewPalettePixColorToDisplay, ratioImgWindow) ; 
        } else {
          text("Too much points to net voronoï connection", 20, height -20) ;
        }
      }
      
      // info display
      objectInfo[IDobj] = ("Image " +img[IDobj].width + "x"+img[IDobj].height + " Analyze "+listEscargot.size()+ " of " + maxEntryPoints+ " / Cell " + pixelAnalyzeSize+ "px / Radius analyze " + radiusAnalyze + " Scale " + ratioImgWindow.x + " / " +ratioImgWindow.y) ;
    } 
  }
  
  
  
  //ANNEXE VOID
  void displayRawPixel(float sizeP, color cIn, PVector rangeHundred, PVector rangeThreeHundredSixty, PVector musicFactor, PVector ratio) {
    // we must create a PVector because i'm lazy to create an other void beatReactivity for one float
    PVector sizePixCtrl = new PVector (0,0,sizeP) ;
    float factorSat = map(saturation(cIn),0,100,0,1) ;
    float factorBright = map(brightness(cIn),0,100,0,1) ;
    
    for ( Pixel p : listPixelRaw ) {
      //display
      stroke(hue(p.colour),saturation(p.colour)*factorSat,brightness(p.colour)*factorBright, alpha(cIn)) ;
      float newSize = 0 ;
      if(sound[IDobj])  newSize = beatReactivityHSB(sizePixCtrl, p.size, p.colour, rangeThreeHundredSixty, rangeHundred, musicFactor ).z ; else newSize = sizeP ;
      strokeWeight(newSize) ;
      point(p.pos.x *ratio.x, p.pos.y *ratio.y) ;
    }
  }
  
  
  
  //Display which point is use to caluculate the barycenter
  void escargotRaw(float sizeP, color cIn, PVector rangeHundred, PVector rangeThreeHundredSixty, PVector musicFactor, PVector ratio) {
    color c ;
    float factorSat = map(saturation(cIn),0,100,0,1) ;
    float factorBright = map(brightness(cIn),0,100,0,1) ;
    // we must create a PVector because i'm lazy to creat an other void beatReactivity for one float
    PVector sizePixCtrl = new PVector (0,0,sizeP) ;
    
    for ( Pixel p : listPixelRaw ) {
      if (p.ID == 1 ) {
        //color
        if ( colorPixDisplay ) c = p.newColour ; else c = p.colour ;
        
        //display
        stroke(hue(c),saturation(c)*factorSat,brightness(c)*factorBright, alpha(cIn)) ;
        float newSize = 0 ;
        if(sound[IDobj])  newSize = beatReactivityHSB(sizePixCtrl, p.size, p.colour, rangeThreeHundredSixty, rangeHundred, musicFactor ).z ; else newSize = sizeP ;
        strokeWeight(newSize) ;
        point(p.pos.x *ratio.x, p.pos.y *ratio.y) ;
      }
    }
  }


  //Display Barycenter
  void escargotPoint(PVector size, color cIn, PVector rangeHundred, PVector rangeThreeHundredSixty, PVector musicFactor, PVector ratio) {
    color c ;
    float factorSat = map(saturation(cIn),0,100,0,1) ;
    float factorBright = map(brightness(cIn),0,100,0,1) ;
    // we must create a PVector because i'm lazy to creat an other void beatReactivity for one float
    //PVector sizePixCtrl = new PVector (0,0,size.x) ;

    for ( Pixel p : listEscargot ) {
      //check if we must display original color or the new palette
      int x = (int)p.pos.x ; int y = (int)p.pos.y ;
      if ( colorPixDisplay ) c = p.newColour ; else c = get(x , y) ;
  
      p.changeHue   (HSBmode, huePalette, hueStart, hueEnd) ;
      p.changeSat   (HSBmode, satPalette, satStart, satEnd) ; 
      p.changeBright(HSBmode, brightPalette,  brightStart, brightEnd) ;
      // update the color after change each componante
      p.updatePalette() ;
      
      stroke(hue(c),saturation(c)*factorSat,brightness(c)*factorBright, alpha(cIn)) ;
      PVector newSize = new PVector() ;
      newSize = newSize2D(size, p.size, rangeThreeHundredSixty, rangeHundred, musicFactor, c, forceBeat) ; //<>// //<>//
      
      if (soundButton[IDobj] == 1) strokeWeight(newSize.x) ; else strokeWeight(p.size.x *size.x) ;
      
       point(p.pos.x *ratio.x, p.pos.y *ratio.y) ; 
    }
  }
  
  
  
  
  
  //ELLIPSE
  void escargotEllipse(PVector size, float thickness, color cIn, color cOut, PVector rangeHundred, PVector rangeThreeHundredSixty, PVector musicFactor, PVector ratio) {
    color c ;
    float factorSatIn = map(saturation(cIn),0,100,0,1) ;
    float factorBrightIn = map(brightness(cIn),0,100,0,1) ;
    float factorSatOut = map(saturation(cIn),0,100,0,1) ;
    float factorBrightOut = map(brightness(cIn),0,100,0,1) ;
   
    for (Pixel p : listEscargot) {
      
      if ( colorPixDisplay ) c = p.newColour ; else c = p.colour ;
      p.changeHue   (HSBmode, huePalette, hueStart, hueEnd) ;
      p.changeSat   (HSBmode, satPalette, satStart, satEnd) ; 
      p.changeBright(HSBmode, brightPalette, brightStart, brightEnd) ;
      // update the color after change each componante
      p.updatePalette() ; 

      //music influence on the opacity
      // A RETRAVAILLER
      
      //display
      if (alpha(cIn) != 0) fill(hue(c),saturation(c)*factorSatIn,brightness(c)*factorBrightIn, alpha(cIn)) ; else noFill() ;
      if (alpha(cOut) != 0) {
        stroke(hue(c),saturation(c)*factorSatOut,brightness(c)*factorBrightOut, alpha(cOut)) ; 
        strokeWeight(thickness ) ;
      } else { 
        noStroke() ;
      } 
      
      PVector newSize = new PVector() ;
      newSize = newSize2D(size, p.size, rangeThreeHundredSixty, rangeHundred, musicFactor, c, forceBeat) ;
      // display
      ellipse(p.pos.x *ratio.x,  p.pos.y *ratio.y, newSize.x, newSize.y) ; 
    }
  }
  
  //RECT
  void escargotRect(PVector size, float thickness, color cIn, color cOut, PVector rangeHundred, PVector rangeThreeHundredSixty, PVector musicFactor, PVector ratio) {
    color c ;
    float factorSatIn = map(saturation(cIn),0,100,0,1) ;
    float factorBrightIn = map(brightness(cIn),0,100,0,1) ;
    float factorSatOut = map(saturation(cIn),0,100,0,1) ;
    float factorBrightOut = map(brightness(cIn),0,100,0,1) ;
    
    for (Pixel p : listEscargot) {
      if ( colorPixDisplay ) c = p.newColour ; else c = p.colour ;
      p.changeHue   (HSBmode, huePalette, hueStart, hueEnd) ;
      p.changeSat   (HSBmode, satPalette, satStart, satEnd) ; 
      p.changeBright(HSBmode, brightPalette, brightStart, brightEnd) ;
      // update the color after change each componante
      p.updatePalette() ; 
      
      //display
      if (alpha(cIn) != 0) fill(hue(c),saturation(c)*factorSatIn,brightness(c)*factorBrightIn, alpha(cIn)) ; else noFill() ;
      if (alpha(cOut) != 0) {
        stroke(hue(c),saturation(c)*factorSatOut,brightness(c)*factorBrightOut, alpha(cOut)) ; 
        strokeWeight(thickness ) ;
      } else { 
        noStroke() ;
      } 

      PVector newSize = new PVector() ;
      newSize = newSize2D(size, p.size, rangeThreeHundredSixty, rangeHundred, musicFactor, c, forceBeat) ;
      // display
      rect((p.pos.x - (newSize.x *.5)) *ratio.x, (p.pos.y - (newSize.y *.5)) *ratio.y, newSize.x , newSize.y) ; 
    }
  }
  
  
  //RECT
  void escargotBox(PVector size, float thickness, color cIn, color cOut, PVector rangeHundred, PVector rangeThreeHundredSixty, PVector musicFactor, PVector ratio, boolean alignement) {
    color c ;
    float factorSatIn = map(saturation(cIn),0,100,0,1) ;
    float factorBrightIn = map(brightness(cIn),0,100,0,1) ;
    float factorSatOut = map(saturation(cIn),0,100,0,1) ;
    float factorBrightOut = map(brightness(cIn),0,100,0,1) ;
    
    for (Pixel p : listEscargot) {
      if ( colorPixDisplay ) c = p.newColour ; else c = p.colour ;
      p.changeHue   (HSBmode, huePalette, hueStart, hueEnd) ;
      p.changeSat   (HSBmode, satPalette, satStart, satEnd) ; 
      p.changeBright(HSBmode,brightPalette, brightStart, brightEnd) ;
      // update the color after change each componante
      p.updatePalette() ; 
      
      //display
      if (alpha(cIn) != 0) fill(hue(c),saturation(c)*factorSatIn,brightness(c)*factorBrightIn, alpha(cIn)) ; else noFill() ;
      if (alpha(cOut) != 0) {
        stroke(hue(c),saturation(c)*factorSatOut,brightness(c)*factorBrightOut, alpha(cOut)) ; 
        strokeWeight(thickness ) ;
      } else { 
        noStroke() ;
      } 
      //recalculate the pose  to scale with coordonate in the middle of the shape ( like(RectMode(CENTER) )

      // float witness = beatReactivityHSB(size, p.size, c, rangeThreeHundredSixty, rangeHundred, musicFactor ).z  ;
      PVector newSize = new PVector() ;
      newSize = newSize3D(size, p.size, rangeThreeHundredSixty, rangeHundred, musicFactor, c, forceBeat) ;
      // display
      pushMatrix() ;
      if (!alignement) {
        translate(p.pos.x *ratio.x, p.pos.y *ratio.y, 0) ;
      } else {
        float horizon = newSize.z *.5 ;
        translate(p.pos.x *ratio.x, p.pos.y *ratio.y, horizon) ;
      }
      //show
      box(newSize.x, newSize.y, newSize.z) ;
      /*
      if (soundButton[IDobj] == 1) { 
        if( witness > size.z) box(newSize.x, newSize.y, newSize.z) ; 
      } else if (soundButton[IDobj] == 0){ 
        box(newSize.x, newSize.y, newSize.z) ; 
      }
      */
      popMatrix() ;
    }
  }
  
  
  //CROSS
  void escargotCross(PVector size, float thickness, color cIn, PVector rangeHundred, PVector rangeThreeHundredSixty, PVector musicFactor, PVector ratio) {
    color c ; 
    float factorSat = map(saturation(cIn),0,100,0,1) ;
    float factorBright = map(brightness(cIn),0,100,0,1) ;
    
    for (Pixel p : listEscargot) {
      
      if ( colorPixDisplay ) c = p.newColour ; else c = p.colour ;
      p.changeHue   (HSBmode, huePalette, hueStart, hueEnd) ;
      p.changeSat   (HSBmode, satPalette, satStart, satEnd) ; 
      p.changeBright(HSBmode, brightPalette, brightStart, brightEnd) ;
      // update the color after change each componante
      p.updatePalette() ;
      

      color newC = color(hue(c),saturation(c)*factorSat,brightness(c)*factorBright, alpha(cIn)) ;

      PVector pos = new PVector(p.pos.x *ratio.x, p.pos.y *ratio.y) ;
      PVector newSize = new PVector() ;
      newSize = newSize3D(size, p.size, rangeThreeHundredSixty, rangeHundred, musicFactor, c, forceBeat) ;
      // display
      if (alpha(cIn) > 0 ) crossPoint3D(pos, newSize, newC, thickness) ;
    }
  }
  
  
  
  /////////////
  //display SVG shave like pixel
  void escargotSVG(PVector size, float thickness, color cIn, color cOut, PVector rangeHundred, PVector rangeThreeHundredSixty, PVector musicFactor, PVector ratio) {
    color c ;
    float factorSatIn = map(saturation(cIn),0,100,0,1) ;
    float factorBrightIn = map(brightness(cIn),0,100,0,1) ;
    float factorSatOut = map(saturation(cIn),0,100,0,1) ;
    float factorBrightOut = map(brightness(cIn),0,100,0,1) ;
    
    for (Pixel p : listEscargot) { 
      //check if we must display original color or the new palette
      int x = (int)p.pos.x ; int y = (int)p.pos.y ;
      if (colorPixDisplay) c = p.newColour ; else c = get(x , y) ;
      
      p.changeHue   (HSBmode, huePalette, hueStart, hueEnd) ;
      p.changeSat   (HSBmode, satPalette, satStart, satEnd) ; 
      p.changeBright(HSBmode,brightPalette, brightStart, brightEnd) ;
      // update the color after change each componante
      p.updatePalette() ; 
      
      //display
      if (alpha(cIn) != 0) fill(hue(c),saturation(c)*factorSatIn,brightness(c)*factorBrightIn, alpha(cIn)) ; else noFill() ;
      if (alpha(cOut) != 0) {
        stroke(hue(c),saturation(c)*factorSatOut,brightness(c)*factorBrightOut, alpha(cOut)) ; 
        strokeWeight(thickness ) ;
      } else { 
        noStroke() ;
      } 
      //recalculate the pose  to scale with coordonate in the middle of the shape ( like(RectMode(CENTER) ) 
      
      PVector newSize = new PVector() ;
      newSize = newSize2D(size, p.size, rangeThreeHundredSixty, rangeHundred, musicFactor, c, forceBeat) ;
      // display
      float sizeSVG = newSize.x *.1 ;
      PVector newPos = new PVector ( p.pos.x - (50 *sizeSVG *.5) *ratio.x ,p.pos.y - (50 *sizeSVG *.5) *ratio.y) ;
  
      if (drawVertexSVG) drawBezierVertex(newPos, sizeSVG , listPointsFromSVG, shapeInfo ) ;
    }
  }
  
  
  
  
  
  /////////
  //VORONOI
  void voronoiToxicSetup(){
    // focus x positions around horizontal center (w/ 33% standard deviation)
    xpos=new BiasedFloatRange(0, width, width/2, 0.333f);
    // focus y positions around bottom (w/ 50% standard deviation)
    ypos=new BiasedFloatRange(0, height, height, 0.5f);
    
    gfx = new ToxiclibsSupport(callingClass);
  }
  
  // DRAW
  void voronoiStatic(color fill, color stroke, float thickness, boolean whichColor, PVector ratio) {
    whichColorVoronoi = whichColor ;
    // thicknessVoronoi = e ;
    //colorStrokeVoronoi = stroke ;
  
  
    for (Pixel b : listEscargot) {
      //security against the NaN result
      if (Float.isNaN(b.pos.x)) ; else voronoi.addPoint(new Vec2D(b.pos.x *ratio.x, b.pos.y *ratio.y));
    }
  
    for (Polygon2D poly : voronoi.getRegions() ) {
      //to recalculate the position in the arraylist
      PVector findPosFromVoronoi = new PVector (0,0) ;
      for (Vec2D v : voronoi.getSites() ) {
        if (poly.containsPoint(v) ) {
          //position in grid
          findPosFromVoronoi.x = int(v.x/pixelAnalyzeSize) ;
          findPosFromVoronoi.y = int(v.y/pixelAnalyzeSize) ;
          if(findPosFromVoronoi.x > cols -1 ) findPosFromVoronoi.x = cols -1 ;
          if(findPosFromVoronoi.y > rows -1 ) findPosFromVoronoi.y = rows -1 ;
          int posInList = (int(findPosFromVoronoi.x / ratio.x )  * rows ) + int(findPosFromVoronoi.y /ratio.y) ; 
          
          //look the color in the list
          if(posInList < listPixelRaw.size() ) {
            Pixel p = (Pixel) listPixelRaw.get(posInList) ;
            
            if (whichColorVoronoi) {
              //change the color with the new palette
              p.changeHue   (HSBmode, huePalette, hueStart, hueEnd) ;
              p.changeSat   (HSBmode, satPalette, satStart, satEnd) ; 
              p.changeBright(HSBmode,brightPalette, brightStart, brightEnd) ;
              // update the color after change each componante
              p.updatePalette() ; 
              float newSat = map(saturation(p.newColour),0,100, 0,saturation(fill)) ;
              float newBright = map(brightness(p.newColour),0,100, 0,brightness(fill)) ;
              fill(hue(p.newColour), newSat, newBright, alpha(fill)) ;
            } else {
              //original color of the pix
              fill(hue(p.colour), saturation(p.colour), brightness(p.colour), alpha(fill)) ;
            }
            if(thicknessVoronoi == 0 ) { 
              noStroke() ; 
            } else { 
              stroke(stroke) ;
              strokeWeight(thickness) ;
            }
          }
          gfx.polygon2D(poly);
        }
      }
    }
    //clear voronoi list
    voronoi = new Voronoi();
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  //COLOR
  //beat rectivity
  PVector beatReactivityHSB(PVector sizeFromControleur, PVector sizeFromList, color beatColor, PVector range360, PVector range100, PVector beatFactor) {
    PVector newSize = sizeFromControleur.copy() ;
    //HUE
    if ( hue(beatColor) > range360.x && hue(beatColor) < range360.y ) {
      newSize.x = newSize.x             *beatFactor.x ; 
      newSize.y = newSize.y             *beatFactor.x ;
      newSize.z = newSize.z *beatFactor.x ;
    } else {
      newSize.x = newSize.x ;
      newSize.y = newSize.y ;
      newSize.z = newSize.z ;
    }
    
    //BRIGHTNESS
    if ( brightness(beatColor) > range100.x && brightness(beatColor) < range100.y ) { 
      newSize.x = sizeFromList.x        *sizeFromControleur.x *beatFactor.y ;  
      newSize.y = sizeFromList.y        *sizeFromControleur.y *beatFactor.y ;
      newSize.z = sizeFromList.z                  *beatFactor.y  ; 
    } else {
      newSize.x = sizeFromList.x *sizeFromControleur.x ;
      newSize.y = sizeFromList.y *sizeFromControleur.y ;
      newSize.z = newSize.z ;
    }
    
    //SATURATION
    if ( saturation(beatColor) > range100.x && saturation(beatColor) < range100.y ) { 
      newSize.x = sizeFromList.x *sizeFromControleur.x *beatFactor.z ; 
      newSize.y = sizeFromList.y *sizeFromControleur.y *beatFactor.z ;
      newSize.z =                 sizeFromControleur.z *beatFactor.z  ; 
    } else {
      newSize.x = sizeFromList.x *sizeFromControleur.x ;
      newSize.y = sizeFromList.y *sizeFromControleur.y ;
      newSize.z = newSize.z ;
      
    }
    return newSize ;
  }
  
  // SIZE PIXEL CALCUL
  // 2D PIXEL
  PVector newSize2D(PVector size, PVector classSize, PVector range360, PVector range100, PVector factor, int c, int beatAmplitude) {
    PVector result = new PVector() ;
    if (result.z > size.z || soundButton[IDobj] == 1) {
    result.x = beatReactivityHSB(size, classSize, c, range360, range100, factor).x *map(allBeats(IDobj),1,40,1,beatAmplitude);
    result.y = beatReactivityHSB(size, classSize, c, range360, range100, factor).y *map(allBeats(IDobj),1,40,1,beatAmplitude) ;
    result.z = beatReactivityHSB(size, classSize, c, range360, range100, factor).z ;
      
    } else {
      result.x = classSize.x *size.x ;
      result.y = classSize.y *size.y ;
    }
    return result ;
  }
  // 3D PIXEL
  PVector newSize3D(PVector size, PVector classSize, PVector range360, PVector range100, PVector factor, color c, int beatAmplitude) {
    PVector result = new PVector() ;
    float ratioDepth = map(brightness(c),0,100,0,1) ;
    result.x = beatReactivityHSB(size, classSize, c, range360, range100, factor).x *map(allBeats(IDobj),1,40,1,beatAmplitude) ;
    result.y = beatReactivityHSB(size, classSize, c, range360, range100, factor).y *map(allBeats(IDobj),1,40,1,beatAmplitude) ;
    result.z = beatReactivityHSB(size, classSize, c, range360, range100, factor).z ;
      
    if (soundButton[IDobj] == 1) {
      result.x = result.x *size.x ;
      result.y = result.y *size.y ;
      result.z = result.z *size.z *ratioDepth ;
    } else {
      result.x = classSize.x *size.x ;
      result.y = classSize.y *size.y ;
      result.z = (result.x + result.y)*.25 *size.z *ratioDepth ;
    }
    return result ;
  }
  
  
  
  
  
  
  
  
  
  //////////////////////////////
  //VOID ANALYZE
  //ReInit the Analyze image
  void reInitilisationAnalyze() { 
      escargotGOanalyze = false ;
      escargotClear() ;
      analyzeDone = false ;
      totalPixCheckedInTheEscargot = 0 ;
  }
    
  //main analyze void    
  void analyzeImg(int sizePixForAnalyze) {
    //Analyze image
    // put in this void the size of pixel you want, to create grid analyzing and image than you want analyze
    colorAnalyzeSetting(sizePixForAnalyze, img[IDobj]) ;
    
    //step 2
    //three componants : FIRST : size of the pixel grid // SECOND which PImage // THIRD mirror "FALSE" or "TRUE"
    recordPixelRaw(sizePixForAnalyze, img[IDobj], false) ; 
    
    //step 3
    // give the list point of Pixel must be change with the new palette
    changeColorOfPixel(listPixelRaw) ; 
    
    //step 4
    //escargot analyze of the arraylist create by the void recordPixelRaw
    
   if ( escargotGOanalyze && listEscargot.size() < maxEntryPoints) {
      //security to make sure the speed is not higher to the max entry points
      if ( speedAnalyze > maxEntryPoints / 10 ) speedAnalyze = maxEntryPoints / 10 ;
      for (int i = 0 ; i < speedAnalyze ; i++ ) {
        int whichPointInTheList  = (int)random(listPixelRaw.size()) ;
        //void without control for escargot analyze
        //escargotAnalyze(whichPointInTheList, radiusAnalyze, modeTri, useNewPalettePixColorToAnalyze ) ;
        
        //void with control for escargot analyze, the last component is a boolean control
        escargotAnalyze(whichPointInTheList, radiusAnalyze, modeTri, useNewPalettePixColorToAnalyze, escargotGOanalyze, sizePixForAnalyze ) ; // escargotStopAnalyze
      }
    }
  }
}





//////////////////
//ESCARGOT ANALYZE
/////////////////
//GLOBAL
boolean escargotGOanalyze = false ; // to stop the escargot analyze
// analyse en escargot étoilé / analyze staring snail
int [] matricePosPixel = new int [10] ;

int getPixelEscargotAnalyze ;
//Barycentre
PVector barycenterEscargot = new PVector(0,0 ) ;
ArrayList<Pixel> listEscargot =  new ArrayList<Pixel>()   ;
//Temp Array List
ArrayList<Pixel> listPixelTemp =  new ArrayList<Pixel>()   ;
ArrayList<Pixel> listPixelByCol =  new ArrayList<Pixel>()  ;
ArrayList<Pixel> listPixelByRow =  new ArrayList<Pixel>() ;

//lattice pixel
int startingPixelToAnalyze ;
//level ananlyze around the pixel lattice
int  maxSnailLevel ; // degre of perimeter of analyze around the main pixel, and max perimeter
int  [] lockEscargot = new int[9] ; // for the 8 direction around the lattice, pivot, main pixel plus 1 for the origin
//info
int  numberPixelAnalyze ;
int  totalPixCheckedInTheEscargot ;


//main void analyze
//SETUP
void escargotClear() {
  if(listEscargot.size() > 0 ) { 
    listEscargot.clear() ;
    listPixelRaw.clear() ;
  }
}

//DRAW

//CLASSIC ANALYZE
//analyze a specific point
void escargotAnalyze(int pivot, int max, String mode, boolean whichColor, int sizePix ) {
  maxSnailLevel = max ;
  //setting the lockEscargot
  for (int i = 0 ; i< lockEscargot.length ; i++) lockEscargot[i] = 0 ;
  
  if(listPixelRaw.size() > 0 && pivot < listPixelRaw.size() ) {
    Pixel pixelRef = (Pixel) listPixelRaw.get(pivot) ;


    if (pixelRef.ID == 0 ) {
      startingPixelToAnalyze += 1 ; // information of how many pixel is starting point analyzing
      //choice wich color of pixel must be use for the analyzis, the original one or the new one
      color colorRef ;
      if ( !whichColor ) colorRef = pixelRef.colour ; else colorRef = pixelRef.newColour ;
      
      for ( int snailLevel = 1 ; snailLevel <= maxSnailLevel ; snailLevel++) {
        for ( int escargotPos = 1 ; escargotPos < 10 ; escargotPos++) { // "posPixelAroundTheMainPixel" give the direction around the pixel pivot
          if (lockEscargot[escargotPos -1] == 0 ) {
            //cols and rows is var from TAB "B_Pixel_Analyze_raw_Record"
            //strange the way is vetical and we must use the rows, not a same way than pixel who use the cols
                                    //escargot analyze algorythme return the position of pixel neightbor in the ordre of ArrayList
            getPixelEscargotAnalyze = escargot(escargotPos, pivot, snailLevel, rows, listPixelRaw.size() ) ; // find the position of the pixel target in the list
            
            if (getPixelEscargotAnalyze > 0 && getPixelEscargotAnalyze < listPixelRaw.size()  ) {  // check if the pixel is valid for the list
              Pixel pixelEscargotAnalyze = (Pixel) listPixelRaw.get(getPixelEscargotAnalyze) ; //look the pixel in the list
              
              //check the color by field hue, saturation, brightness
              if (mode.equals("hsb"))    hueSaturationBrightnessCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ; 
              //check the color by field hue
              else if (mode.equals("h"))  hueCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ; 
              //check the color by field saturation
              else if (mode.equals("s"))  saturationCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ; 
              //check the color by field brightness
              else if (mode.equals("b"))  brightnessCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ;
              //check the color by field hue and saturation
              else if (mode.equals("hs"))  hueSaturationCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ;
              //check the color by field hue and brigthness
              else if (mode.equals("hb"))  hueBrightnessCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ;
              //check the color by field saturation and brigthness
              else if (mode.equals("sb"))  saturationBrightnessCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ;   
              else hueCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ; 
            }
          }
        }
      }
      //COMPLETE THE LIST of pixel escargot in the area around the barrycenter, to change the ID "zero" to "one"
      //check in cols to complete the pixel area after Escargot Analyze
      checkPixelInCol() ;
      //check in row to complete the pixel area after Escargot Analyze
      checkPixelInRow() ;
      
      //calculate the barycenter of the family point, this void must be in the main lood for include the good color
      findEscargot(colorRef, sizePix) ;
      //clear the temp for the next round analyzis
      for (int i = 0 ; i< lockEscargot.length ; i++) lockEscargot[i] = 0 ;
      listPixelTemp.clear() ;
      barycenterEscargot = new PVector(0,0) ;
      numberPixelAnalyze = 0 ;
      
    }
  }
}




//CLASSIC ANALYZE
//analyze a specific point, with possibility to stop the analyzis
void escargotAnalyze(int pivot, int max, String mode, boolean whichColor, boolean analyzeGO, int sizePix ) {
  maxSnailLevel = max ;
  //setting the lockEscargot
  for (int i = 0 ; i< lockEscargot.length ; i++) lockEscargot[i] = 0 ;
  
  if(listPixelRaw.size() > 0 && pivot < listPixelRaw.size() ) {
    Pixel pixelRef = (Pixel) listPixelRaw.get(pivot) ;


    if (pixelRef.ID == 0 && analyzeGO ) {
      pixelRef.changeID(1) ;
      startingPixelToAnalyze += 1 ; // information of how many pixel is starting point analyzing
      //choice wich color of pixel must be use for the analyzis, the original one or the new one
      color colorRef ;
      if ( !whichColor ) colorRef = pixelRef.colour ; else colorRef = pixelRef.newColour ;
      
      for ( int snailLevel = 1 ; snailLevel <= maxSnailLevel ; snailLevel++) {
        for ( int escargotPos = 1 ; escargotPos < 10 ; escargotPos++) { // "posPixelAroundTheMainPixel" give the direction around the pixel pivot
          if (lockEscargot[escargotPos -1] == 0 ) {
            //cols and rows is var from TAB "B_Pixel_Analyze_raw_Record"
            //strange the way is vetical and we must use the rows, not a same way than pixel who use the cols
                                    //escargot analyze algorythme return the position of pixel neightbor in the ordre of ArrayList
            getPixelEscargotAnalyze = escargot(escargotPos, pivot, snailLevel, rows, listPixelRaw.size() ) ; // find the position of the pixel target in the list
            
            if (getPixelEscargotAnalyze > 0 && getPixelEscargotAnalyze < listPixelRaw.size()  ) {  // check if the pixel is valid for the list
              Pixel pixelEscargotAnalyze = (Pixel) listPixelRaw.get(getPixelEscargotAnalyze) ; //look the pixel in the list
              
              //check the color by field hue, saturation, brightness
              if (mode.equals("hsb"))    hueSaturationBrightnessCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ; 
              //check the color by field hue
              else if (mode.equals("h"))  hueCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ; 
              //check the color by field saturation
              else if (mode.equals("s"))  saturationCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ; 
              //check the color by field brightness
              else if (mode.equals("b"))  brightnessCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ;
              //check the color by field hue and saturation
              else if (mode.equals("hs"))  hueSaturationCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ;
              //check the color by field hue and brigthness
              else if (mode.equals("hb"))  hueBrightnessCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ;
              //check the color by field saturation and brigthness
              else if (mode.equals("sb"))  saturationBrightnessCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ;   
              else hueCheck(escargotPos, colorRef, pixelEscargotAnalyze, whichColor) ; 
            }
          }
        }
      } 
        
      //COMPLETE THE LIST of pixel escargot in the area around the barrycenter, to change the ID "zero" to "one"
      //check in cols to complete the pixel area after Escargot Analyze
      checkPixelInCol() ;
      //check in row to complete the pixel area after Escargot Analyze
      checkPixelInRow() ;
      
      
      //calculate the barycenter of the family point, this void must be in the main lood for include the good color
      findEscargot(colorRef, sizePix) ;
      

      
      
      //clear the temp for the next round analyzis
      for (int i = 0 ; i< lockEscargot.length ; i++) lockEscargot[i] = 0 ;
      listPixelTemp.clear() ;
      barycenterEscargot = new PVector(0,0) ;
      totalPixCheckedInTheEscargot += numberPixelAnalyze ;
      
      numberPixelAnalyze = 0 ;
      
    }
  }
}





//ANNEXE PRIVATE VOID


///////////////////////
//COMPLETE THE ESCARGOT
//COL
private void checkPixelInCol() {
  int numPixInCol = 0 ;
  
  for ( int whichCol = 1 ; whichCol <= cols ; whichCol++) {
    for ( int j = 0 ; j< listPixelTemp.size() ; j++) {
      Pixel pixTemp = (Pixel) listPixelTemp.get(j) ;
      if( pixTemp.gridPos.x == whichCol ) {
        numPixInCol += 1 ;
        listPixelByCol.add(new Pixel(pixTemp.rank)) ;
      }
    }
    //Changez the ID "ZERO" to "ONE" of pixel if there is more of one point in col
    if(numPixInCol > 1  ) {
      int [] pixPosInCol = new int [numPixInCol] ;
      for ( int k = 0 ; k < listPixelByCol.size() ; k++) {
        Pixel pixByCol = (Pixel) listPixelByCol.get(k) ;
        pixPosInCol[k] = pixByCol.rank ;
      }
      pixPosInCol = sort(pixPosInCol) ;
      for(int l = pixPosInCol[0] ; l < pixPosInCol[pixPosInCol.length -1] ; l++) {
        Pixel pix = (Pixel) listPixelRaw.get(l) ;
        if(pix.ID == 0) {
          // git a new ID "ONE" to say this Pixel has been checked, and now don'k try to make something with her
          pix.changeID(1) ;
          //complet the temp list completed
          PVector posInTheGrid = gridPosition(l) ;
      //    listPixelTempCompleted.add(new Pixel(l, posInTheGrid)) ;
          listPixelTemp.add(new Pixel(l, posInTheGrid)) ;
        }
      }
    }
    //clear the  list for the next col
    numPixInCol = 0 ; 
    listPixelByCol.clear() ;
  }
}


//ROW
private void checkPixelInRow() {
  int numPixInRow = 0 ;
  for ( int whichRow = 1 ; whichRow <= rows ; whichRow++) {
    for ( int j = 0 ; j< listPixelTemp.size() ; j++) {
      Pixel pixTemp = (Pixel) listPixelTemp.get(j) ;
      if( pixTemp.gridPos.y == whichRow ) { 
        numPixInRow += 1 ;
        listPixelByRow.add(new Pixel(pixTemp.rank, pixTemp.gridPos)) ;
      }
    }
    //Changez the ID "ZERO" to "ONE" of pixel if there is more of one point in col
    if(numPixInRow > 1  ) {
      int [] pixPosInRow = new int [numPixInRow] ;
      int [] whichColForPix = new int [numPixInRow] ;
      for ( int k = 0 ; k < listPixelByRow.size() ; k++) {
        Pixel pixByRow = (Pixel) listPixelByRow.get(k) ;
        pixPosInRow[k] = pixByRow.rank ;
        whichColForPix[k] = (int)pixByRow.gridPos.x ;
      }
      //pixPosInRow = sort(pixPosInRow) ;
      whichColForPix = sort(whichColForPix) ;
      int startPoint = whichColForPix[0] ;
      int lastPoint = whichColForPix[pixPosInRow.length -1] ;

      for(int l = startPoint ; l < lastPoint  ; l++) {
        int whichPixel = (l-1) * rows + pixPosInRow[0] %rows ;
        Pixel pix = (Pixel) listPixelRaw.get(whichPixel) ;
        if(pix.ID == 0) {
          // git a new ID "ONE" to say this Pixel has been checked, and now don'k try to make something with her
          pix.changeID(1) ;
          //complet the temp list completed
          PVector posInTheGrid = gridPosition(whichPixel) ;
          //listPixelTempCompleted.add(new Pixel(whichPixel, posInTheGrid)) ;
          listPixelTemp.add(new Pixel(whichPixel, posInTheGrid)) ;
        } 
      }
    }
    //clear the  list for the next row
    numPixInRow = 0 ;
    listPixelByRow.clear() ; 
  }
}

////////////
//BARYCENTER
void findEscargot(color cRef, int pixSize) {
  for ( Pixel p :  listPixelTemp ) {
    PVector posInTheGrid = p.gridPos ;
    barycenterEscargot.x += posInDisplay(posInTheGrid.x, pixSize) ;
    barycenterEscargot.y += posInDisplay(posInTheGrid.y, pixSize) ;
  }
  //divid the some of the point to find the position of the barycenter
  barycenterEscargot.x /= listPixelTemp.size() ; 
  barycenterEscargot.y /= listPixelTemp.size() ;

  PVector sizeBarycenter = new PVector(numberPixelAnalyze, numberPixelAnalyze) ;
  //add barycenter in the list
  listEscargot.add(new Pixel(barycenterEscargot, sizeBarycenter, cRef)); 
}


//SCALE THE POSITION FROM THE GRID TO DISPLAY
float posInDisplay(float posInGrid, int sizeCell) {
  float p = 0 ;
  p = posInGrid * sizeCell - (sizeCell * .5 ) ;
  return p ;
}
  

/////////////////////////////////////////////////
//POSITION in the grid systeme with cols and rows
PVector gridPosition(int posPixel) {
  PVector gridPos = new PVector (0,0) ;
  for ( int j = 0 ; j < cols ; j++) {

    // return the collums where leave the pixel
    if (posPixel >= rows * j && posPixel < (rows * j) + rows) {
        gridPos.x = j +1 ;
    }
    // return the line(row) where leave the pixel
    for ( int k = 0 ; k < rows ; k++) {
      if (posPixel == (rows * (j)) + k) {
        gridPos.y = k +1 ;
      }
    }
  }
  return gridPos ;
}

///////////////////
color wichColorCheck ;
//HSB CHECK
//by hsb
void hueSaturationBrightnessCheck(int escargotPos_n, color cRef, Pixel pixelEscargotAnalyze, boolean whichPix) {
  //choice the ref color in pix Class a original color or the new one
  if( !whichPix ) wichColorCheck = pixelEscargotAnalyze.colour ; else wichColorCheck = pixelEscargotAnalyze.newColour ;
  if( pixelEscargotAnalyze.ID == 0 // check if the pixel is never analyze before
      && hue(wichColorCheck) == hue(cRef) // and if the hue is good
      && saturation(wichColorCheck) == saturation(cRef) // and if the saturation is good
      && brightness(wichColorCheck) == brightness(cRef) ) { // and if the brightness is good too 
    // change the ID "ZERO" to "ONE" to indicate this that pixel has to be checked and have a good color.
    pixelEscargotAnalyze.changeID(1) ;
    //return the coordinate in the grid system rows and cols
    PVector posInTheGrid = gridPosition(getPixelEscargotAnalyze) ;
    
    listPixelTemp.add( new Pixel(getPixelEscargotAnalyze, posInTheGrid)) ;
    
    numberPixelAnalyze += 1 ; // count of pixel has be analyzing
  } else {
    //close this direction for the next round
    lockEscargot[escargotPos_n -1] = 1 ;
  }
}

//by hue
void hueCheck(int escargotPos_n, color cRef, Pixel pixelEscargotAnalyze, boolean whichPix) {
  //choice the ref color in pix Class a original color or the new one
  if( !whichPix ) wichColorCheck = pixelEscargotAnalyze.colour ; else wichColorCheck = pixelEscargotAnalyze.newColour ;
  if( pixelEscargotAnalyze.ID == 0 && hue(wichColorCheck) == hue(cRef) ) { // check if the pixel is never analyze before and if the hue is good
  // change the ID "ZERO" to "ONE" to indicate this that pixel has to be checked and have a good color.
    pixelEscargotAnalyze.changeID(1) ;
    //return the coordinate in the grid system rows and cols
    PVector posInTheGrid = gridPosition(getPixelEscargotAnalyze) ;
    
    listPixelTemp.add( new Pixel(getPixelEscargotAnalyze, posInTheGrid)) ;
    
    numberPixelAnalyze += 1 ; // count of pixel has be analyzing
  } else {
    //close this direction for the next round
    lockEscargot[escargotPos_n -1] = 1 ;
  }
}

//by saturation
void saturationCheck(int escargotPos_n, color cRef, Pixel pixelEscargotAnalyze, boolean whichPix) {
  //choice the ref color in pix Class a original color or the new one
  if( !whichPix ) wichColorCheck = pixelEscargotAnalyze.colour ; else wichColorCheck = pixelEscargotAnalyze.newColour ;
  if( pixelEscargotAnalyze.ID == 0 && saturation(wichColorCheck) == saturation(cRef) ) // check if the pixel is never analyze before and if the hue is good
    {

    // change the ID "ZERO" to "ONE" to indicate this that pixel has to be checked and have a good color.
    pixelEscargotAnalyze.changeID(1) ;
    //return the coordinate in the grid system rows and cols
    PVector posInTheGrid = gridPosition(getPixelEscargotAnalyze) ;
    
    listPixelTemp.add( new Pixel(getPixelEscargotAnalyze, posInTheGrid)) ;
    
    numberPixelAnalyze += 1 ; // count of pixel has be analyzing
  } else {
    //close this direction for the next round
    lockEscargot[escargotPos_n -1] = 1 ;
  }
}

//by brightness
void brightnessCheck(int escargotPos_n, color cRef, Pixel pixelEscargotAnalyze, boolean whichPix) {
  //choice the ref color in pix Class a original color or the new one
  if( !whichPix ) wichColorCheck = pixelEscargotAnalyze.colour ; else wichColorCheck = pixelEscargotAnalyze.newColour ;
  if( pixelEscargotAnalyze.ID == 0 && brightness(wichColorCheck) == brightness(cRef) ) // check if the pixel is never analyze before and if the hue is good
    {
      // change the ID "ZERO" to "ONE" to indicate this that pixel has to be checked and have a good color.
    pixelEscargotAnalyze.changeID(1) ;
    //return the coordinate in the grid system rows and cols
    PVector posInTheGrid = gridPosition(getPixelEscargotAnalyze) ;
    
    listPixelTemp.add( new Pixel(getPixelEscargotAnalyze, posInTheGrid)) ;
    
    numberPixelAnalyze += 1 ; // count of pixel has be analyzing
  } else {
    //close this direction for the next round
    lockEscargot[escargotPos_n -1] = 1 ;
  }
}
//by hue and saturation
void hueSaturationCheck(int escargotPos_n, color cRef, Pixel pixelEscargotAnalyze, boolean whichPix) {
  //choice the ref color in pix Class a original color or the new one
  if( !whichPix ) wichColorCheck = pixelEscargotAnalyze.colour ; else wichColorCheck = pixelEscargotAnalyze.newColour ;
  if( pixelEscargotAnalyze.ID == 0 // check if the pixel is never analyze before
      && hue(wichColorCheck) == hue(cRef) // and if the hue is good
      && saturation(wichColorCheck) == saturation(cRef) ) // and if the saturation is good
      { 
    // change the ID "ZERO" to "ONE" to indicate this that pixel has to be checked and have a good color.
    pixelEscargotAnalyze.changeID(1) ;
    //return the coordinate in the grid system rows and cols
    PVector posInTheGrid = gridPosition(getPixelEscargotAnalyze) ;
    
    listPixelTemp.add( new Pixel(getPixelEscargotAnalyze, posInTheGrid)) ;
    
    numberPixelAnalyze += 1 ; // count of pixel has be analyzing
  } else {
    //close this direction for the next round
    lockEscargot[escargotPos_n -1] = 1 ;
  }
}

// by hue and brigthness
void hueBrightnessCheck(int escargotPos_n, color cRef, Pixel pixelEscargotAnalyze, boolean whichPix) {
  //choice the ref color in pix Class a original color or the new one
  if( !whichPix ) wichColorCheck = pixelEscargotAnalyze.colour ; else wichColorCheck = pixelEscargotAnalyze.newColour ;
  if( pixelEscargotAnalyze.ID == 0 // check if the pixel is never analyze before
      && hue(wichColorCheck) == hue(cRef) // and if the hue is good
      && brightness(wichColorCheck) == brightness(cRef) ) { // and if the brightness is good too 
    // change the ID "ZERO" to "ONE" to indicate this that pixel has to be checked and have a good color.
    pixelEscargotAnalyze.changeID(1) ;
    //return the coordinate in the grid system rows and cols
    PVector posInTheGrid = gridPosition(getPixelEscargotAnalyze) ;
    
    listPixelTemp.add( new Pixel(getPixelEscargotAnalyze, posInTheGrid)) ;
    
    numberPixelAnalyze += 1 ; // count of pixel has be analyzing
  } else {
    //close this direction for the next round
    lockEscargot[escargotPos_n -1] = 1 ;
  }
}

//by saturation and brightness
void saturationBrightnessCheck(int escargotPos_n, color cRef, Pixel pixelEscargotAnalyze, boolean whichPix) {
  //choice the ref color in pix Class a original color or the new one
  if( !whichPix ) wichColorCheck = pixelEscargotAnalyze.colour ; else wichColorCheck = pixelEscargotAnalyze.newColour ;
  if( pixelEscargotAnalyze.ID == 0 // check if the pixel is never analyze before
      && saturation(wichColorCheck) == saturation(cRef) // and if the saturation is good
      && brightness(wichColorCheck) == brightness(cRef) ) { // and if the brightness is good too 
    // change the ID "ZERO" to "ONE" to indicate this that pixel has to be checked and have a good color.
    pixelEscargotAnalyze.changeID(1) ;
    //return the coordinate in the grid system rows and cols
    PVector posInTheGrid = gridPosition(getPixelEscargotAnalyze) ;
    
    listPixelTemp.add( new Pixel(getPixelEscargotAnalyze, posInTheGrid)) ;
    
    numberPixelAnalyze += 1 ; // count of pixel has be analyzing
  } else {
    //close this direction for the next round
    lockEscargot[escargotPos_n -1] = 1 ;
  }
}

///////////////////


//////////////////
//MATRICE ESCARGOT
//escargot analyze algorythme return the position of pixel neightbor in the ordre of ArrayList
//strange the order int the arraylist is vertical, not like a pixel order who is horizontale, So we must use the rows, not cols to find a good neightbor pixel.
int escargot(int escargotPos_n, int start, int level, int numRows, int sizeList ) {
  //pivot
  matricePosPixel[1] = start + (0*level *numRows) + (0*level)  ; // neutre
  //autour du pivot
  ////////////////
  matricePosPixel[2] = start + (1*level *numRows) + (0*level)  ; // Est
  //special condition for the bottom boarder
  if (start%numRows + level >= numRows ) matricePosPixel[3] = -1 ; else matricePosPixel[3] = start + (1*level *numRows) + (1*level)  ; // Sud-Est
  if (start%numRows + level >= numRows ) matricePosPixel[4] = -1 ; else matricePosPixel[4] = start + (0*level *numRows) + (1*level)  ; // Sud
  if (start%numRows + level >= numRows ) matricePosPixel[5] = -1 ; else matricePosPixel[5] = start - (1*level *numRows) + (1*level)  ; // Sud-Ouest
  matricePosPixel[6] = start - (1*level *numRows) + (0*level)  ; // Ouest
  //special condition for the top boarder
  if (start%numRows < level ) matricePosPixel[7] = -1 ; else matricePosPixel[7] = start - (1*level *numRows) - (1*level)  ; // Nord-Ouest
  if (start%numRows < level ) matricePosPixel[8] = -1 ; else matricePosPixel[8] = start + (0*level *numRows) - (1*level)  ; // Nord
  if( start%numRows < level ) matricePosPixel[9] = -1 ; else matricePosPixel[9] = start + (1*level *numRows) - (1*level)  ; // Nord-Est
  
  if      ( escargotPos_n == 1 ) return matricePosPixel [1] ;
  else if ( escargotPos_n == 2 ) return matricePosPixel [2] ;
  else if ( escargotPos_n == 3 ) return matricePosPixel [3] ;
  else if ( escargotPos_n == 4 ) return matricePosPixel [4] ;
  else if ( escargotPos_n == 5 ) return matricePosPixel [5] ;
  else if ( escargotPos_n == 6 ) return matricePosPixel [6] ;
  else if ( escargotPos_n == 7 ) return matricePosPixel [7] ;
  else if ( escargotPos_n == 8 ) return matricePosPixel [8] ;
  else if ( escargotPos_n == 9 ) return matricePosPixel [9] ;
  else return matricePosPixel[0] ;
}














////////////////
//PIXEL ANALYZE
///////////////
ArrayList<Pixel> listPixelRaw = new ArrayList<Pixel>() ;
// Number of columns and rows in our system
int cols, rows ; 
float ratioCols, ratioRows;
//give the position in the order of displaying
int whereIsPixel ;
//security when you load an image, to start the displaying only if you've finish to analyze this one
boolean analyzeDone ;

//SETUP
//SETTING
void colorAnalyzeSetting(int pixSize, PImage imgAnalyze) {
  if (imgAnalyze != null ) {
    
    cols = imgAnalyze.width / pixSize;
    rows = imgAnalyze.height / pixSize;
    
    ratioCols = width / imgAnalyze.width ;
    ratioRows = height / imgAnalyze.height ;
  } 
}




//RECORD
//RAW RECORD without timer
void recordPixelRaw(int cellSize, PImage imgRecord, boolean mirror) {
  if (imgRecord != null && !analyzeDone  ) {
    imgRecord.loadPixels() ;
    //start analyze
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        
        int x = i*cellSize;
        int y = j*cellSize;
        //check if there is mirror effect or not
        if(!mirror) whereIsPixel =  y*imgRecord.width +x; else whereIsPixel = (imgRecord.width -x -1) + y*imgRecord.width; // Reversing x to mirror the image
        //analyze the color of the pixel in the HSB mode
        float h = hue       (imgRecord.pixels[whereIsPixel]);
        float s = saturation(imgRecord.pixels[whereIsPixel]);
        float b = brightness(imgRecord.pixels[whereIsPixel]);
        // Make a new color and position
        color c = color(h, s, b);
        PVector pos = new PVector(x+cellSize/2, y+cellSize/2 ) ;
        //add position and color of the pixel in the list
        listPixelRaw.add(new Pixel(pos, c)) ;
      }
    }
    analyzeDone = true ;
    escargotGOanalyze = true ;
  } 
}

//RAW RECORD with timer
int stepAnalyzeImg ;
//from image
void recordPixelRaw(int cellSize, PImage imgRecord, float time, boolean mirror) {
  int newStep = timer(time) ;
  //analyze each new step
  if (stepAnalyzeImg != newStep ) {
    //clear the list for new analyze
    listPixelRaw.clear() ;
    
    imgRecord.loadPixels() ;
    //start analyze
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        int x = i*cellSize;
        int y = j*cellSize;
        //check if there is mirror effect or not
        if(!mirror) whereIsPixel =  y*imgRecord.width +x; else whereIsPixel = (imgRecord.width - x - 1) + y*imgRecord.width; // Reversing x to mirror the image
        //analyze the color of the pixel in the HSB mode
        float h = hue       (imgRecord.pixels[whereIsPixel]);
        float s = saturation(imgRecord.pixels[whereIsPixel]);
        float b = brightness(imgRecord.pixels[whereIsPixel]);
        // Make a new color and position
        color c = color(h, s, b);
        PVector pos = new PVector(x+cellSize/2, y+cellSize/2 ) ;
        //add position and color of the pixel in the list
        listPixelRaw.add(new Pixel(pos, c)) ;
      }
    }
  }
  stepAnalyzeImg = newStep ;
}








////////////
//DRAW SVG
PShape shapeSVG ;
boolean drawVertexSVG ;
ArrayList<PVector> listPointsFromSVG = new ArrayList<PVector>();;
ArrayList <PVector> shapeInfo = new ArrayList<PVector>(); ;

//SETUP
void shapeSVGsetting(String p) {
  drawVertexSVG = false ;
  listPointsFromSVG.clear();
  shapeInfo.clear();
  shapeSVG = loadShape(p) ;
  startPoint = endPoint = 0 ;
  createListOfPoint(shapeSVG) ;
}


//Information about the shape
PShape[] childrenShape ; // to create a shape children from SVG
int IDshapeChildren ;
int startPoint, endPoint ;

void createListOfPoint (PShape s ) {
  
  int  numChildren, numPoint;
  PVector pos  ;
  //find the quantity object from SVG
  numChildren = s.getChildCount(); 
  
  //if there is children, separate the shape
  if ( numChildren > 0 ) {
    for ( int i = 0 ; i  < numChildren ; i++) {
      childrenShape = s.getChildren() ;
      createListOfPoint (childrenShape[i]) ;
    }
  //if there no children we can write the shape in the list
  } else {
    numPoint = s.getVertexCount() ;
    //to find the exit point in the list
    endPoint = startPoint + numPoint ;
    
    
    //add information ID, entry and exit point of each children shape for the future !
    shapeInfo.add(new PVector(IDshapeChildren, startPoint, endPoint )) ;
    //display information
    //to find the ID shape
    IDshapeChildren += 1 ;
    //to find the next entry point in the list
    
    //startPoint = endPoint +1 ;
    startPoint = endPoint  ;
    
    //startPoint = endPoint  ;
    //loop to put the point from SVG in the list
    for ( int j = 0 ; j < numPoint ; j++) {
      pos = new PVector (s.getVertexX(j), s.getVertexY(j), 0.0 ) ;
      listPointsFromSVG.add(new PVector(pos.x, pos.y, pos.z)) ;
    }
    drawVertexSVG = true ;
  }
}




//Draw shape bezier Vertex
void drawBezierVertex(ArrayList<PVector> list, ArrayList<PVector> shapes) {
    if (drawVertexSVG) {
      for ( int i = 0 ; i < shapes.size() ; i++) {
      int start = int(shapes.get(i).y) ;
      int end   = int(shapes.get(i).z) ;
      beginShape() ;
      for ( int j = start ; j < end ; j++) {
        if (j == start ) { 
          
          vertex(list.get(j).x, list.get(j).y) ;
        } else if (j > start && j < end -2 ) { 
          bezierVertex( list.get(j).x, list.get(j).y, list.get(j+1).x, list.get(j+1).y, list.get(j+2).x, list.get(j+2).y ) ;
        }
        //must be different of "0" for the starting point
        if( j != start ) j += 2 ; // +=2 for the switch to next point because the BezierVertex need the coordinate
      }
      endShape() ;
    }
  }
}
//Draw with scale
void drawBezierVertex(PVector pos, float scale, ArrayList<PVector> list, ArrayList<PVector> shapes) {
  if (drawVertexSVG) {
      for ( int i = 0 ; i < shapes.size() ; i++) {
      int start = int(shapes.get(i).y) ;
      int end   = int(shapes.get(i).z) ;
      beginShape() ;
      for ( int j = start ; j < end ; j++) {
        if (j == start ) { 
          
          vertex(list.get(j).x *scale +pos.x, list.get(j).y *scale +pos.y) ;
        } else if (j > start && j < end -2 ) { 
          bezierVertex( list.get(j).x   *scale +pos.x, list.get(j).y   *scale +pos.y, 
                        list.get(j+1).x *scale +pos.x, list.get(j+1).y *scale +pos.y, 
                        list.get(j+2).x *scale +pos.x, list.get(j+2).y *scale +pos.y ) ;
        }
        //must be different of "0" for the starting point
        if( j != start ) j += 2 ; // +=2 for the switch to next point because the BezierVertex need the coordinate
      }
      endShape() ;
    }
  }
}










//LOAD PATTERN
//SVG PATTERN
String pathSVGescargot ;

//load SVG
void choiceSVG(File selection) {
  if (selection == null) {
    println("no pattern selected");
  } else {
    pathSVGescargot  = selection.getAbsolutePath() ;
    shapeSVGsetting(pathSVGescargot) ;

  }
}
