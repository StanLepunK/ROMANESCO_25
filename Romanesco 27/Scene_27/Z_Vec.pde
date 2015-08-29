// CLASS VEC 0.1.11
///////////////////
// inspireted by GLSL code and PVector

// VEC 2
////////////////
class Vec2 {
  float ref_x, ref_y = 0 ;
  float x,y = 0;
  float s,t = 0;
  float u,v = 0;
  
  Vec2() {}
  
  Vec2(float value) {
    this.ref_x = this.ref_y = this.x = this.y = this.s = this.t = this.u = this.v = value ;
  }
  
  Vec2(float x, float y) {
    this.ref_x = this.x = this.s = this.u = x ;
    this.ref_y = this.y = this.t = this.v = y ;
  }
  
  
  // multiplication
  /* multiply Vector by a same float value */
  Vec2 mult(float mult) {
    x *= mult ; 
    y *= mult ;
    // update value
    s = u = x ;
    t = v = y ;
    return new Vec2(x,y) ;
  }
  
  /* multiply Vector by different float value */
  Vec2 mult(float mult_x, float mult_y) {
    x *= mult_x ; 
    y *= mult_y ;
    // update value
    s = u = x ;
    t = v = y ;
    return new Vec2(x,y) ;
  }
  
  // mult by vector
  Vec2 mult(Vec2 v_a) {
    x *= v_a.x ; 
    y *= v_a.y ; 
    // update value
    s = u = x ;
    t = v = y ;
    return new Vec2(x,y) ;
  }
  
  
    // division
  ///////////
  /*
  divide Vector by a float value */
  Vec2 div(float div) {
    x /= div ; y /= div ; 
    // update value
    s = u = x ;
    t = v = y ;
    return new Vec2(x,y) ;
    
  }
  
  // divide by vector
  Vec2 div(Vec2 v_a) {
    x /= v_a.x ; y /= v_a.y ;  
    // update value
    s = u = x ;
    t = v = y ;
    return new Vec2(x,y) ;
  }
  
  
  /* Addition
  @return Vec2
  */
  /* add float value */
  Vec2 add(float value) {
    x += value ;
    y += value ;
    // update value
    s = u = x ;
    t = v = y ;
    return new Vec2(x,y)  ;
  }
  /* add Vector */
  Vec2 add(Vec2 v_a) {
    x += v_a.x ;
    y += v_a.y ;
    // update value
    s = u = x ;
    t = v = y ;
    return new Vec2(x,y)  ;
  }
  /* add two Vector together */
  Vec2 add(Vec2 v_a, Vec2 v_b) {
    x = v_a.x + v_b.x ;
    y = v_a.y + v_b.y ;
    // update value
    s = u = x ;
    t = v = y ;
    return new Vec2(x,y)  ;
  }
  
  
  
  
  /* mapping
  return mapping vector
  @return Vec2
  */
  Vec2 mapVec(float minIn, float maxIn, float minOut, float maxOut) {
    x = map(x,minIn, maxIn, minOut, maxOut) ;
    y = map(y,minIn, maxIn, minOut, maxOut) ;
    // update value
    s = u = x ;
    t = v = y ;
    return new Vec2(x,y) ;
  }
  
  /* magnitude or length of Vec2
  @ return float
  */
  /////////////////////
  float mag() {
    x *= x ;
    y *= y ; 
    return sqrt(x+y) ;
  }

  float mag(Vec2 v_target) {
    float new_x = (v_target.x -x) *(v_target.x -x) ;
    float new_y = (v_target.y -y) *(v_target.y -y) ;
    return sqrt(new_x +new_y) ;
  }
  
  
  // Distance
  ////////////
  /*
  @ return float
  distance between himself and an other vector
  */
  float dist(Vec2 v_target) {
    float dx = x - v_target.x;
    float dy = y - v_target.y;
    return (float) Math.sqrt(dx*dx + dy*dy);
  }
  
  
  // Jitter
  ////////////
  /* create jitter effect around the vector position */
  /* with global range */
  Vec2 jitter(int range) {
    x = ref_x ;
    y = ref_y ;
    x += random(-range, range) ;
    y += random(-range, range) ;
    // update value
    s = u = x ;
    t = v = y ;
    return new Vec2(x,y) ;
  }
  /* with specific range */
  Vec2 jitter(int range_x,int range_y) {
    x = ref_x ;
    y = ref_y ;
    x += random(-range_x, range_x) ;
    y += random(-range_y, range_y) ;
    // update value
    s = u = x ;
    t = v = y ;
    return new Vec2(x,y) ;
  }
  
  
  
  /*catch info
  /////////////
  return all the componant of Vec
  @return Vec2
  */
  Vec2 copy() {
    return new Vec2(x,y) ;
  }
  /*
  return all the componant of Vec in type PVector
  @return PVector
  */
  PVector copyVecToPVector() {
    return new PVector(x,y) ;
  }
  

}
// END VEC 2
////////////









// VEC 3
////////////////
class Vec3 {
  float ref_x, ref_y, ref_z = 0 ;
  float x,y,z  = 0 ;
  float r, g, b = 0 ;
  float s, t, p = 0 ;
  
  Vec3() {}
  
  Vec3(float value) {
    this.ref_x = this.ref_y = this.ref_z = this.x = this.y = this.z  = this.r = this.g = this.b =this.s = this.t = this.p = value ;
  }
  
  Vec3(float x, float y, float z) {
    this.ref_x = this.x = this.r =this.s = x ;
    this.ref_y = this.y = this.g =this.t = y ;
    this.ref_z = this.z = this.b = this.p =z ;
  }
  
  // multiplication
  /* multiply Vector by a same float value */
  Vec3 mult(float mult) {
    x *= mult ; y *= mult ; z *= mult ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    return new Vec3(x,y,z) ;
  }
  
  /* multiply Vector by a different float value */
  Vec3 mult(float mult_x, float mult_y, float mult_z) {
    x *= mult_x ; y *= mult_y ; z *= mult_z ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    return new Vec3(x,y,z) ;
  }
  
  // mult by vector
  Vec3 mult(Vec3 v_a) {
    x *= v_a.x ; y *= v_a.y ; z *= v_a.z ; 
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    return new Vec3(x,y,z) ;
  }
  
  
  
  // division
  ///////////
  /*
  @ return Vec
  divide Vector by a float value */
  Vec3 div(float div) {
    x /= div ; y /= div ; z /= div ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    return new Vec3(x,y,z) ;
  }
  
  // divide by vector
  Vec3 div(Vec3 v_a) {
    x /= v_a.x ; y /= v_a.y ; z /= v_a.z ; 
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    return new Vec3(x,y,z) ;
  }
  
  
  
  // addition
    /* add float value */
  Vec3 add(float value) {
    x += value ;
    y += value ;
    z += value ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    return new Vec3(x,y,z)  ;
  }
  /* add one Vector */
  Vec3 add(Vec3 v_a) {
    x += v_a.x ;
    y += v_a.y ;
    z += v_a.z ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    return new Vec3(x,y,z)  ;
  }
  
  /* add two Vector together */
  Vec3 add(Vec3 v_a, Vec3 v_b) {
    x = v_a.x + v_b.x ;
    y = v_a.y + v_b.y ;
    z = v_a.z + v_b.z ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    return new Vec3(x,y,z)  ;
  }
  
  
  
  /*
  mapping
  return mapping vector
  @return Vec3
  */
  Vec3 mapVec(float minIn, float maxIn, float minOut, float maxOut) {
    x = map(x, minIn, maxIn, minOut, maxOut) ;
    y = map(y, minIn, maxIn, minOut, maxOut) ;
    z = map(z, minIn, maxIn, minOut, maxOut) ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    return new Vec3(x,y,z) ;
  }
  
  
  
  // Magnitude
  ////////////
  /* Magnitude or length of Vec3
  @ return float
  */
  /////////////////////
  float mag() {
    x *= x ;
    y *= y ; 
    z *= z ;
    return sqrt(x+y+z) ;
  }

  float mag(Vec3 v_target) {
    float new_x = (v_target.x -x) *(v_target.x -x) ;
    float new_y = (v_target.y -y) *(v_target.y -y) ;
    float new_z = (v_target.z -z) *(v_target.z -z) ;
    return sqrt(new_x +new_y +new_z) ;
  }
  
  // Distance
  ////////////
  /*
  @ return float
  distance himself and an other vector
  */
  float dist(Vec3 v_target) {
    float dx = x - v_target.x;
    float dy = y - v_target.y;
    float dz = z - v_target.z;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz);
  }
  
  // Jitter
  ////////////
  /* create jitter effect around the vector position */
  /* with global range */
  Vec3 jitter(int range) {
    x = ref_x ;
    y = ref_y ;
    z = ref_z ;
    x += random(-range, range) ;
    y += random(-range, range) ;
    z += random(-range, range) ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    return new Vec3(x,y,z) ;
  }
  /* with specific range */
  Vec3 jitter(int range_x,int range_y,int range_z) {
    x = ref_x ;
    y = ref_y ;
    z = ref_z ;
    x += random(-range_x, range_x) ;
    y += random(-range_y, range_y) ;
    z += random(-range_z, range_z) ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    return new Vec3(x,y,z) ;
  }
  
  
  
  // catch info
  /////////////
  /*
  return all the component of Vec
  @return Vec3
  */
  Vec3 copy() {
    return new Vec3(x,y,z) ;
  }
  /*
  return all the component of Vec in type PVector
  @return PVector
  */
  PVector copyVecToPVector() {
    return new PVector(x,y,z) ;
  }
  
  
}
// END VEC 3
////////////






// VEC 4
////////
class Vec4 {
  float ref_x, ref_y, ref_z, ref_w = 0 ;
  float x,y,z,w = 0 ;
  float r, g, b, a = 0 ;
  float s, t, p, q = 0 ;
  
  Vec4 () {}
  
  Vec4(float value) {
    this.ref_x = this.ref_y = this.ref_z = this.ref_w = this.x = this.y = this.z = this.w = this.r = this.g = this.b = this.a =this.s = this.t = this.p = this.q = value ;
  }
  
  Vec4(float x, float y, float z, float w) {
    this.ref_x = this.x = this.r = this.s = x ;
    this.ref_y = this.y = this.g = this.t =y ;
    this.ref_z = this.z = this.b = this.p =z ;
    this.ref_w = this.w = this.a = this.q = w ;
  }
  
  
  // multiplication
  // mult by a same float
  Vec4 mult(float mult) {
    x *= mult ; y *= mult ; z *= mult ; w *= mult ;
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
    return new Vec4(x,y,z,w) ;
  }
  
    // mult by a different float
  Vec4 mult(float mult_x, float mult_y, float mult_z, float mult_w) {
    x *= mult_x ; y *= mult_y ; z *= mult_z ; w *= mult_w ;
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
    return new Vec4(x,y,z,w) ;
  }
  
  // mult by vector
  Vec4 mult(Vec4 v_a) {
    x *= v_a.x ; y *= v_a.y ; z *= v_a.z ; w *= v_a.w ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
    return new Vec4(x,y,z,w) ;
  }
  
  
    // division
  ///////////
  /*
  @ return Vec
  divide Vector by a float value */
  Vec4 div(float div) {
    x /= div ; y /= div ; z /= div ; w /= div ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
    return new Vec4(x,y,z,w) ;
  }
  
  // divide by vector
  Vec4 div(Vec4 v_a) {
    x /= v_a.x ; y /= v_a.y ; z /= v_a.z ; w /= v_a.w ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
    return new Vec4(x,y,z,w) ;
  }
  
  
  // addition
    /* add float value */
  Vec4 add(float value) {
    x += value ;
    y += value ;
    z += value ;
    w += value ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
    return new Vec4(x,y,z,w)  ;
  }
  /* add vec */
  Vec4 add(Vec4 v_a) {
    x += v_a.x ;
    y += v_a.y ;
    z += v_a.z ;
    w += v_a.w ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
    return new Vec4(x,y,z,w)  ;
  }
  /* add two Vector together */
  Vec4 add(Vec4 v_a, Vec4 v_b) {
    x = v_a.x + v_b.x ;
    y = v_a.y + v_b.y ;
    z = v_a.z + v_b.z ;
    w = v_a.w + v_b.w ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
    return new Vec4(x,y,z,w)  ;
  }
  
  /* mapping
  return mapping vector
  @return Vec4
  */
  Vec4 mapVec(float minIn, float maxIn, float minOut, float maxOut) {
    x = map(x, minIn, maxIn, minOut, maxOut) ;
    y = map(y, minIn, maxIn, minOut, maxOut) ;
    z = map(z, minIn, maxIn, minOut, maxOut) ;
    w = map(w, minIn, maxIn, minOut, maxOut) ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
    return new Vec4(x,y,z,w) ;
  }
  
  // magnitude or length
  /////////////////////
  float mag() {
    x *= x ;
    y *= y ; 
    z *= z ;
    w *= w ;  ;
    return sqrt(x+y+z+w) ;
  }

  float mag(Vec4 v_target) {
    float new_x = (v_target.x -x) *(v_target.x -x) ;
    float new_y = (v_target.y -y) *(v_target.y -y) ;
    float new_z = (v_target.z -z) *(v_target.z -z) ;
    float new_w = (v_target.w -w) *(v_target.w -w) ;
    return sqrt(new_x +new_y +new_z +new_w) ;
  }
  
  // Distance
  ////////////
  // distance himself and an other vector
  float dist(Vec4 v_target) {
    float dx = x - v_target.x;
    float dy = y - v_target.y;
    float dz = z - v_target.z;
    float dw = w - v_target.w;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz + dw*dw);
  }
  
  
    // Jitter
  ////////////
  /* create jitter effect around the vector position */
  /* with global range */
  Vec4 jitter(int range) {
    x = ref_x ;
    y = ref_y ;
    z = ref_z ;
    w = ref_w ;
    x += random(-range, range) ;
    y += random(-range, range) ;
    z += random(-range, range) ;
    w += random(-range, range) ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
    return new Vec4(x,y,z,w) ;
  }
  /* with specific range */
  Vec4 jitter(int range_x,int range_y,int range_z,int range_w) {
    x = ref_x ;
    y = ref_y ;
    z = ref_z ;
    w = ref_w ;
    x += random(-range_x, range_x) ;
    y += random(-range_y, range_y) ;
    z += random(-range_z, range_z) ;
    w += random(-range_z, range_z) ;
    // update value
    r = s = x ;
    g = t = y ;
    b = p = z ;
    a = q = w ;
    return new Vec4(x,y,z,w) ;
  }
    
  // catch info
  /////////////
  Vec4 copy() {
    return new Vec4(x,y,z,w) ;
  }
}
// END VEC 4
////////////



// CLASS Vec5
/////////////

class Vec5 {
  float a,b,c,d,e = 0 ;

  
  Vec5 () {}
  
  Vec5(float value) {
    this.a = this.b = this.c = this.d = this.e = value ;
  }
  
  Vec5(float a, float b, float c, float d, float e) {
    this.a = a ;
    this.b = b ;
    this.c = c ;
    this.d = d ;
    this.e = e ;
  }
  // catch info
  /////////////
  Vec5 copy() {
    return new Vec5(a,b,c,d,e) ;
  }
}

// END VEC 5
////////////












// External Methods VEC
///////////////////////



// Addition
// return the resultat of vector addition
Vec2 add(Vec2 v_a, Vec2 v_b) {
    float x = v_a.x + v_b.x ;
    float y = v_a.y + v_b.y ;
    return new Vec2(x,y) ;
}
Vec3 add(Vec3 v_a, Vec3 v_b) {
    float x = v_a.x + v_b.x ;
    float y = v_a.y + v_b.y ;
    float z = v_a.z + v_b.z ;
    return new Vec3(x,y,z)  ;
}
Vec4 add(Vec4 v_a, Vec4 v_b) {
    float x = v_a.x * v_b.x ;
    float y = v_a.y * v_b.y ;
    float z = v_a.z * v_b.z ;
    float w = v_a.w * v_b.w ;
    return new Vec4(x,y,z, w)  ;
}


// Multiplication
// return the resultat of vector multiplication
Vec2 mult(Vec2 v_a, Vec2 v_b) {
    float x = v_a.x * v_b.x ;
    float y = v_a.y * v_b.y ;
    return new Vec2(x,y) ;
}
Vec3 mult(Vec3 v1, Vec3 v_b) {
    float x = v1.x * v_b.x ;
    float y = v1.y * v_b.y ;
    float z = v1.z * v_b.z ;
    return new Vec3(x,y,z)  ;
}
Vec4 mult(Vec4 v_a, Vec4 v_b) {
    float x = v_a.x * v_b.x ;
    float y = v_a.y * v_b.y ;
    float z = v_a.z * v_b.z ;
    float w = v_a.w * v_b.w ;
    return new Vec4(x,y,z, w)  ;
}


// Division
// return the resultat of vector addition
Vec2 div(Vec2 v_a, Vec2 v_b) {
    float x = v_a.x / v_b.x ;
    float y = v_a.y / v_b.y ;
    return new Vec2(x,y) ;
}
Vec3 div(Vec3 v1, Vec3 v_b) {
    float x = v1.x / v_b.x ;
    float y = v1.y / v_b.y ;
    float z = v1.z / v_b.z ;
    return new Vec3(x,y,z)  ;
}
Vec4 div(Vec4 v_a, Vec4 v_b) {
    float x = v_a.x / v_b.x ;
    float y = v_a.y / v_b.y ;
    float z = v_a.z / v_b.z ;
    float w = v_a.w / v_b.w ;
    return new Vec4(x,y,z, w)  ;
}


// compare two vectors Vec
/*
@ return boolean
*/
// Vec method
// Vec2 compare
boolean compare(Vec2 v_a, Vec2 v_b) {
  if( v_a != null && v_b != null ) {
    if((v_a.x == v_b.x) && (v_a.y == v_b.y)) {
      return true ; 
    } else return false ;
  } else return false ;
}
// Vec3 compare
boolean compare(Vec3 v_a, Vec3 v_b) {
  if( v_a != null && v_b != null ) {
    if((v_a.x == v_b.x) && (v_a.y == v_b.y) && (v_a.z == v_b.z)) {
            return true ; 
    } else return false ;
  } else return false ;
}
// Vec4 compare
boolean compare(Vec4 v_a, Vec4 v_b) {
  if( v_a != null && v_b != null ) {
    if((v_a.x == v_b.x) && (v_a.y == v_b.y) && (v_a.z == v_b.z) && (v_a.w == v_b.w)) {
            return true ; 
    } else return false ;
  } else return false ;
}



/* Map
return mapping vector
@return Vec2, Vec3 or Vec4
*/
Vec2 mapVec(Vec2 v,float minIn, float maxIn, float minOut, float maxOut) {
  float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
  float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
  return new Vec2(x,y) ;
}
Vec3 mapVec(Vec3 v,float minIn, float maxIn, float minOut, float maxOut) {
  float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
  float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
  float z = map(v.z, minIn, maxIn, minOut, maxOut) ;
  return new Vec3(x,y,z) ;
}
Vec4 mapVec(Vec4 v,float minIn, float maxIn, float minOut, float maxOut) {
  float x = map(v.x, minIn, maxIn, minOut, maxOut) ;
  float y = map(v.y, minIn, maxIn, minOut, maxOut) ;
  float z = map(v.z, minIn, maxIn, minOut, maxOut) ;
  float w = map(v.w, minIn, maxIn, minOut, maxOut) ;
  return new Vec4(x,y,z,w) ;
}


// Magnitude or Length Vector
/*
@return float
*/
// mag Vec2
float mag(Vec2 v_a) {
  float x = v_a.x*v_a.x ;
  float y = v_a.y *v_a.y ;
  return sqrt(x+y) ;
}

float mag(Vec2 v_a, Vec2 v_b) {
  // same result than dist
  float x = (v_b.x -v_a.x)*(v_b.x -v_a.x) ;
  float y = (v_b.y -v_a.y)*(v_b.y -v_a.y) ;
  return sqrt(x+y) ;
}
// mag Vec3
float mag(Vec3 v_a) {
  float x = v_a.x*v_a.x ;
  float y = v_a.y *v_a.y ;
  float z = v_a.z *v_a.z ;
  return sqrt(x+y+z) ;
}

float mag(Vec3 v_a, Vec3 v_b) {
  // same result than dist
  float x = (v_b.x -v_a.x)*(v_b.x -v_a.x) ;
  float y = (v_b.y -v_a.y)*(v_b.y -v_a.y) ;
  float z = (v_b.z -v_a.z)*(v_b.z -v_a.z) ;
  return sqrt(x+y+z) ;
}
// mag Vec4
float mag(Vec4 v_a) {
  float x = v_a.x*v_a.x ;
  float y = v_a.y *v_a.y ;
  float z = v_a.z *v_a.z ;
  float w = v_a.w *v_a.w ;
  return sqrt(x+y+z+w) ;
}

float mag(Vec4 v_a, Vec4 v_b) {
  // same result than dist
  float x = (v_b.x -v_a.x)*(v_b.x -v_a.x) ;
  float y = (v_b.y -v_a.y)*(v_b.y -v_a.y) ;
  float z = (v_b.z -v_a.z)*(v_b.z -v_a.z) ;
  float w = (v_b.w -v_a.w)*(v_b.w -v_a.w) ;
  return sqrt(x+y+z+w) ;
}



// Distance
/*
return float
return the distance beatwen two vectors
*/
float dist(Vec2 v_a, Vec2 v_b) {
    float dx = v_a.x - v_b.x;
    float dy = v_a.y - v_b.y;
    return (float) Math.sqrt(dx*dx + dy*dy);
}
float dist(Vec3 v_a, Vec3 v_b) {
    float dx = v_a.x - v_b.x;
    float dy = v_a.y - v_b.y;
    float dz = v_a.z - v_b.z;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz);
}
float dist(Vec4 v_a, Vec4 v_b) {
    float dx = v_a.x - v_b.x;
    float dy = v_a.y - v_b.y;
    float dz = v_a.z - v_b.z;
    float dw = v_a.w - v_b.w;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz + dw*dw);
}


// Middle
////////
/*
@ return Vec2, Vec3 or Vec4
return the middle between two Vector
*/
Vec4 middle(Vec4 p1, Vec4 p2)  {
  Vec4 middle ;
  middle = add(p1, p2);
  middle.div(2) ;
  return middle ;
}

Vec3 middle(Vec3 p1, Vec3 p2)  {
  Vec3 middle ;
  middle = add(p1, p2);
  middle.div(2) ;
  return middle ;
}

Vec2 middle(Vec2 p1, Vec2 p2)  {
  Vec2 middle ;
  middle = add(p1, p2);
  middle.div(2) ;
  return middle ;
}


// Copy 
/*
@ return Vec3
Transform PVector in Vec
*/
Vec3 copyPVectorToVec(PVector p) {
  return new Vec3(p.x,p.y,p.z) ;
}



// JITTER
/////////
// Vec2
Vec2 jitterVec2(int range) {
  Vec2 jitter = Vec2() ;
  jitter.x = random(-range, range) ;
  jitter.y = random(-range, range) ;
  return jitter ;
}
Vec2 jitterVec2(int range_x, int range_y) {
  Vec2 jitter = Vec2() ;
  jitter.x = random(-range_x, range_x) ;
  jitter.y = random(-range_y, range_y) ;
  return jitter ;
}
// Vec3
Vec3 jitterVec3(int range) {
  Vec3 jitter = Vec3() ;
  jitter.x = random(-range, range) ;
  jitter.y = random(-range, range) ;
  jitter.z = random(-range, range) ;
  return jitter ;
}
Vec3 jitterVec3(int range_x, int range_y, int range_z) {
  Vec3 jitter = Vec3() ;
  jitter.x = random(-range_x, range_x) ;
  jitter.y = random(-range_y, range_y) ;
  jitter.z = random(-range_z, range_z) ;
  return jitter ;
}
// Vec4
Vec4 jitterVec4(int range) {
  Vec4 jitter = Vec4() ;
  jitter.x = random(-range, range) ;
  jitter.y = random(-range, range) ;
  jitter.z = random(-range, range) ;
  return jitter ;
}
Vec4 jitterVec4(int range_x, int range_y, int range_z, int range_w) {
  Vec4 jitter = Vec4() ;
  jitter.x = random(-range_x, range_x) ;
  jitter.y = random(-range_y, range_y) ;
  jitter.z = random(-range_z, range_z) ;
  jitter.w = random(-range_w, range_w) ;
  return jitter ;
}
// END JITTER
/////////////









// return a Vec value
// Vec 5
////////
Vec5 Vec5(float a, float b, float c, float d, float e) {
  return new Vec5(a,b,c,d,e) ;
}

Vec5 Vec5(float v) {
  return new Vec5(v) ;
}

Vec5 Vec5() {
  return new Vec5(0.) ;
}

// Vec 4
////////
Vec4 Vec4(float x, float y, float z, float w) {
  return new Vec4(x,y,z,w) ;
}

Vec4 Vec4(float v) {
  return new Vec4(v) ;
}

Vec4 Vec4() {
  return new Vec4(0.) ;
}

// Vec 3
////////
Vec3 Vec3(float x, float y, float z) {
  return new Vec3(x,y,z) ;
}

Vec3 Vec3(float v) {
  return new Vec3(v) ;
}

Vec3 Vec3(PVector p) {
  return new Vec3(p.x, p.y, p.z) ;
}

Vec3 Vec3() {
  return new Vec3(0.) ;
}

// Vec 2
////////
Vec2 Vec2(float x, float y) { 
  return new Vec2(x,y) ;
}

Vec2 Vec2(float v) {
  return new Vec2(v) ;
}

Vec2 Vec2(PVector p) {
  return new Vec2(p.x, p.y) ;
}

Vec2 Vec2() {
  return new Vec2(0.) ;
}
// END CLASS VEC
///////////////