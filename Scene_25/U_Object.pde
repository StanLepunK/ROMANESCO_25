/////////////
//CLASS PIXEL
/////////////
class Pixel {
  color colour, newColour ;
  PVector newC = new PVector (0,0,0) ; ;
  PVector pos ;
  PVector newPos = new PVector(0,0,0) ; // absolute pos in the display size : horizontal sytem of pixel system
  PVector gridPos ; // position with cols and rows system : vertical system of ArrayList
  PVector size = new PVector (1,1,1) ;
  float field = 1.0 ;
  PVector wind ; // the wind force who can change the position of the pixel
  float life = 1.0 ;
  int rank = -1 ;
  int ID = 0 ;
  
  //DIFFERENT CONSTRUCTOR
  
  //classic pixel
  Pixel(PVector pos) {
    this.pos = new PVector(pos.x, pos.y, pos.z) ;
  }
  
  Pixel(PVector pos, color colour) {
    this.pos = new PVector(pos.x, pos.y, pos.z) ;
    this.colour = colour ;
  }
  
  Pixel(PVector pos, PVector size) {
    this.pos = new PVector(pos.x, pos.y, pos.z) ;
    this.size = new PVector(size.x, size.y, size.z) ;
  }
  
  //pixel with size
  Pixel(PVector pos, PVector size, color colour) {
    this.pos = new PVector(pos.x, pos.y, pos.z) ;
    this.size = new PVector(size.x, size.y, size.z) ;
    this.colour = colour ;
  }
  
  //INK CONSTRUCTOR
  Pixel(PVector pos, float field, color colour) {
    this.pos = new PVector(pos.x, pos.y, pos.z) ;
    this.field = field ;
    this.colour = colour ;
  }
  Pixel(PVector pos, float field) {
    this.pos = new PVector(pos.x, pos.y, pos.z) ;
    this.field = field ;
  }
  
  //RANK PIXEL CONSTRUCTOR
  Pixel(int rank, PVector gridPos) {
    this.rank = rank ;
    this.gridPos = gridPos ;
  }
  Pixel(int rank) {
    this.rank = rank ;
  }
  
  
  
  
  //DISPLAY
    //without effect
  void displayPixel(int diam) {
    strokeWeight(diam) ;
    stroke(this.colour) ;
    if (newPos.x == 0 && newPos.y == 0 && newPos.z == 0) newPos = pos ; // else newPos = newPos ;
    //test display with ID
    if (ID == 1 ) point(newPos.x, newPos.y) ;
  }
  //with effect
  void displayPixel(int diam, PVector effectColor) {
    strokeWeight(diam) ;
    
    stroke(hue(newColour), effectColor.x *saturation(newColour), effectColor.y *brightness(newColour), effectColor.z) ;
    if (newPos.x == 0 && newPos.y == 0 && newPos.z == 0) newPos = pos ; // else newPos = newPos ;
    point(newPos.x, newPos.y) ;
  }

  //change ID after analyze if this one is good
  void changeID(int newID) {  ID = newID ; }
  
  // END DISPLAY
  
  
  
  // UPDATE
  //drying is like jitter but with time effect, it's very subtil so we use a float timer.
    // classic
  void drying(float timePast) {
    if (field > 0 ) { 
      field -= timePast ;
      float rad;
      float angle;
      rad = random(-1,1) *field;
      angle = random(-1,1) * TAU;
      pos.x += rad * cos(angle);
      pos.y += rad * sin(angle);
    }
  }
  // with external var
  void drying(float var, float timePast) {
    if (field > 0 ) { 
      field -= timePast ;
      float rad;
      float angle;
      rad = random(-1,1) *field *var;
      angle = random(-1,1) * TAU;
      pos.x += rad * cos(angle);
      pos.y += rad * sin(angle);
    }
  }
  
  
  
  
  
  //CHANGE COLOR 
  // hue from Range
  void changeHue(PVector HSBinfo, int[] newHue,  int[] start, int[] end) {
    float h = hue(this.colour) ;
    
    for( int i = 0 ; i < newHue.length ; i++) {
      if (start[i] < end[i] ) {
        if( h >= start[i] && h <= end[i] ) h = newHue[i] ; 
      } else if ( start[i] > end[i] ) {
        if( (h >= start[i] && h <= HSBinfo.x) || h <= end[i] ) { 
          if( h >= newHue[newHue.length -1] ) h = newHue[newHue.length -1] ; 
          else h = newHue[i] ; 
        }
      }        
    }
    newC.x = h ;
  }
  
  // saturation from Range
  void changeSat(PVector HSBinfo, int[] newSat,  int[] start, int[] end) {
    float s = saturation(this.colour) ;
    
    for( int i = 0 ; i < newSat.length ; i++) {
      if (start[i] < end[i] ) {
        if( s >= start[i] && s <= end[i] ) s = newSat[i] ; 
      } else if ( start[i] > end[i] ) {
        if( (s >= start[i] && s <= HSBinfo.y) || s <= end[i] ) { 
          if( s >= newSat[newSat.length -1] ) s = newSat[newSat.length -1] ;
          else s = newSat[i] ;
        }
      }        
    }
    newC.y = s ;
  }
  
  // saturation from Range
  void changeBright(PVector HSBinfo, int[] newBright,  int[] start, int[] end) {
    float b = brightness(this.colour) ;

    
    for( int i = 0 ; i < newBright.length ; i++) {
      if (start[i] < end[i] ) {
        if( b >= start[i] && b <= end[i] ) b = newBright[i] ; 
      } else if ( start[i] > end[i] ) {
        if( (b >= start[i] && b <= HSBinfo.z) || b <= end[i] ) { 
          if( b >= newBright[newBright.length -1] ) b = newBright[newBright.length -1] ;
          else b = newBright[i] ;
        }
      }        
    }
    newC.z = b ;
  }
  
  
  
  //change color of pixel for single color
  // void changeColor(color nc) { color c = nc ; }
  
  void updatePalette() { 
    int h = (int)newC.x ;
    int s = (int)newC.y ;
    int b = (int)newC.z ;

    newColour = color(h,s,b) ;
  }
  
  
  //UPDATE POSITION with the wind
  void updatePosPixel(PVector effectPosition, PImage pic) {
    PVector dir = normalDir((int)effectPosition.x) ;
    
    wind = new PVector (1.0 *dir.x *effectPosition.y  + random(-effectPosition.z, effectPosition.z) ,   1.0 *dir.y *effectPosition.y  + random(-effectPosition.z, effectPosition.z))   ;
    pos.add(wind) ;
    //keep the pixel in the scene
    if (pos.x< 0)          pos.x= pic.width;
    if (pos.x> pic.width)  pos.x=0;
    if (pos.y< 0)          pos.y= pic.height;
    if (pos.y> pic.height) pos.y=0;
  }
  
  
  
  //return position with display size
  PVector posPixel(PVector effectPosition, PImage pic) {
    PVector dir = normalDir((int)effectPosition.x) ;

    newPos = pos ;
    
    wind = new PVector (1.0 *dir.x *effectPosition.y  + random(-effectPosition.z, effectPosition.z) ,   1.0 *dir.y *effectPosition.y  + random(-effectPosition.z, effectPosition.z))   ;
    newPos.add(wind) ;
    //keep the pixel in the scene
    if (newPos.x< 0)          newPos.x= pic.width;
    if (newPos.x> pic.width)  newPos.x=0;
    if (newPos.y< 0)          newPos.y= pic.height;
    if (newPos.y> pic.height) newPos.y=0;
    
    return new PVector (newPos.x, newPos.y) ;
  }
}
// END CLASS PIXEL
/////////////////






//CLASS ROTATION
////////////////
class Rotation {
  float rotation ;
  float angle  ;
  
  Rotation () {}
  
  void actualisation (PVector pos, float speed) {
    rotation += speed ;
    if ( rotation > 360 ) rotation = 0 ; else if (rotation < 0 ) rotation = 360 ;
    float angle = rotation ;
    translate (pos.x, pos.y) ;
    rotate (radians(angle) ) ;
  }
} 
// END CLASS ROTATION
