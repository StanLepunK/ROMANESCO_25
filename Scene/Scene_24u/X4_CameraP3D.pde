private PVector posSceneMouseRef, posEyeMouseRef ;
private PVector posSceneCameraRef, posEyeCameraRef ;
private PVector eyeCamera, sceneCamera ;
private PVector deltaScenePos, deltaEyePos ;
private PVector tempEyeCamera ;

private boolean newRefSceneMouse = true ;
private boolean newRefEyeMouse = true ;
//travelling
boolean gotoCameraPosition, gotoCameraEye, travellingPriority ;

//speed must be 1 or less
float speedMoveOfCamera = 0.1 ;
//CAMERA Stuff
private boolean moveScene, moveEye ;

PVector targetPosCam = new PVector(0, 0, 0) ;

//P3D STUFF
PVector speedDirectionOfObject  ;
PVector  P3DpositionMouseRef, deltaObjPos ;
PVector  P3DdirectionMouseRef, deltaObjDir, P3DtempObjDir ;


//SETUP
void P3DSetup() {
  if(modeP3D) {
    //CAMERA
    sceneCamera = new PVector (width/2 , height/2, 0) ;
    sceneCamera = new PVector (0 , 0, 0) ;
    eyeCamera = new PVector (0,0,0) ;
    //
    posSceneCameraRef = new PVector (0,0,0) ;
    posEyeCameraRef = new PVector (0,0,0) ;
    //
    deltaScenePos = new PVector (0,0,0) ;
    deltaEyePos = new PVector (0,0,0) ;
    //
    tempEyeCamera = new PVector(0,0,0) ;
    
    //P3D
    for ( int i = 0 ; i < numObj + 1 ; i ++ ) {
      P3Dposition [i] = new PVector(-width/2, -height/2, 0) ;
      P3Ddirection [i] = new PVector(0, 0, 0) ;
      P3DpositionObjRef[i] = new PVector(0,0,0) ; 
      P3DdirectionObjRef[i] = new PVector(0,0,0) ;
    }
    P3DpositionMouseRef = new PVector(0,0,0) ; deltaObjPos = new PVector(0,0,0) ;
    P3DdirectionMouseRef = new PVector(0,0,0) ; deltaObjDir = new PVector(0,0,0) ;
  }
}

//END SETUP




//OBJECT ORIENTATION AND POSITION
PVector P3Dposition(PVector pos, int ID) {
  
  //XY pos
  if (clickLongLeft[0] ) {
    if(P3DrefPos[ID]  ) {
      P3DpositionObjRef[ID] = pos ;
      P3DpositionMouseRef = new PVector(mouse[0].x, mouse[0].y) ;
    }
    //to create a only one ref position
    P3DrefPos[ID] = false ;
    //create the delta between the ref and the mouse position
    deltaObjPos.x = mouse[0].x -P3DpositionMouseRef.x ;
    deltaObjPos.y = mouse[0].y -P3DpositionMouseRef.y ;
    pos = PVector.add(deltaObjPos, P3DpositionObjRef[ID] ) ;
  }
  
  //Z pos
  //zoom
  zoom() ;
  
  //P3DpositionObjRef[ID].z -= getCountZoom ;
  // pos.z = P3DpositionObjRef[ID].z ;
  pos.z -= getCountZoom ;
  
  return pos ;
}


PVector P3Ddirection(PVector dir, int ID, PVector speed) {
  //XY pos
  if (clickLongRight[0] ) {
    if(P3DrefDir[ID]  ) {
      P3DdirectionObjRef[ID] = dir ;
      P3DdirectionMouseRef = new PVector(mouse[0].x, mouse[0].y) ;
    }
    //to create a only one ref position
    P3DrefDir[ID] = false ;
    //create the delta between the ref and the mouse position
    deltaObjDir.x = mouse[0].x -P3DdirectionMouseRef.x ;
    deltaObjDir.y = mouse[0].y -P3DdirectionMouseRef.y ;
    P3DtempObjDir = PVector.add(deltaObjDir, P3DdirectionObjRef[ID] ) ;
    //rotation of the camera
    //solution 2
    dir.x += (pmouse[0].y-mouse[0].y) * speed.y;
    dir.y += (pmouse[0].x-mouse[0].x) *-speed.x;
    if(dir.x > 360 ) dir.x = 0 ;
    if(dir.x < 0  ) dir.x = 360 ;
    if(dir.y > 360 ) dir.y = 0 ; 
    if(dir.y < 0   ) dir.y = 360 ; 
    
  }
  return dir ;
}

//final direction and oriention with object ID
void P3Dmanipulation(int ID) {
  if(modeP3D) {
    if(actionButton[ID] == 1 && vLongTouch ) {
      //speed rotation
      float speed = 150.0 ; // 150 is medium speed rotation
      speedDirectionOfObject = new PVector(speed /(float)width, speed /(float)height) ; 
       
      P3Dposition[ID] = P3Dposition(P3Dposition[ID], ID) ;
      P3Ddirection[ID] = P3Ddirection(P3Ddirection[ID], ID, speedDirectionOfObject) ; 
    }
    if (!clickLongLeft[0] ) P3DrefPos[ID] = true ;
    translate(P3Dposition[ID].x, P3Dposition[ID].y, P3Dposition[ID].z) ;
    rotateX(radians(P3Ddirection[ID].x)) ;
    rotateY(radians(P3Ddirection[ID].y)) ;
  }
}
//starting position
void startPosition(int ID, int x, int y, int z) {
  P3Dposition[ID] = new PVector(width/2 -x, height/2 -y, z) ;
  startingPos[ID] = new PVector(x,y,z) ;
  startingPosition[ID] = false ;
}


//END OF P3D OBJECT ORIENTATION AND DIRECTION





////////
//CAMERA
void cameraDraw() {
  if(modeP3D) {
    //camera order
    if(clickLongLeft[0] && cLongTouch) moveScene = true ;   else moveScene = false ;
    if(clickLongRight[0] && cLongTouch) moveEye = true ;   else moveEye = false ;
    
    //void with speed setting
    float speed = 150.0 ; // 150 is medium speed rotation
    PVector speedRotation = new PVector(speed /(float)width, speed /(float)height) ; 
    startCamera(moveScene, moveEye, speedRotation) ;
    //to change the scene position with a specific point
    if(gotoCameraPosition || gotoCameraEye ) updateCamera(sceneCamera, targetPosCam, speedMoveOfCamera) ;
    
    //back to the ref position in smooth mode
    if(cLongTouch) if(enterTouch) {
      //calculate the distance and few stuffes to move the camera
      travelling(posCamRef) ;
    }
    // back to origine raw style
    if(cLongTouch) if (touch0) {
      eyeCamera = new PVector(0,0) ;
      sceneCamera = new PVector(0,0,0) ;
      gotoCameraPosition = false ;
      gotoCameraEye = false ;
    }
      
  
    // println(catchCam + " / " + posCamRef + " / " + eyeCamRef) ;
    //catch ref camera
    catchCameraInfo() ;
  }
}
//END CAMERA DRAW


//CATCH a ref position and direction of the camera
PVector posCamRef = new PVector(0,0,0) ;
PVector eyeCamRef = new PVector(0,0) ;
//boolean security to catch the reference camera when you reset the position of this one
boolean catchCam = true ;

void catchCameraInfo() {
  if(catchCam) {
    posCamRef = getPosCamera() ;
    eyeCamRef = getEyeCamera() ;
  }
  catchCam = false ;
}
//END catch position





//startCamera with speed setting
void startCamera(boolean scene, boolean eye, PVector speed) {
  pushMatrix() ;
  //Move the Scene
  if(scene) {
    //create the ref to calcul the new position of the Scene
    if(newRefSceneMouse) {
      posSceneCameraRef = sceneCamera ;
      posSceneMouseRef = new PVector(mouse[0].x, mouse[0].y) ;
    }
    //to create a only one ref position
    newRefSceneMouse = false ;
    //create the delta between the ref and the mouse position
    deltaScenePos.x = mouse[0].x -posSceneMouseRef.x ;
    deltaScenePos.y = mouse[0].y -posSceneMouseRef.y ;
    sceneCamera = PVector.add(deltaScenePos, posSceneCameraRef ) ;
  } else {
    //change the boolean to true for the next mousepressed
    newRefSceneMouse = true ;
  }
    
  
  //move the eye camera
  if(eye) {
    //create the ref to calcul the new position of the Scene
    if(newRefEyeMouse) {
      posEyeCameraRef = tempEyeCamera ;
      posEyeMouseRef = new PVector(mouse[0].x, mouse[0].y) ;
    }
    //to create a only one ref position
    newRefEyeMouse = false ;
    //create the delta between the ref and the mouse position
    deltaEyePos.x = mouse[0].x -posEyeMouseRef.x ;
    deltaEyePos.y = mouse[0].y -posEyeMouseRef.y ;
    tempEyeCamera = PVector.add(deltaEyePos, posEyeCameraRef ) ;

    //rotation of the camera
    //solution 2
    eyeCamera.x += (pmouse[0].y-mouse[0].y) * speed.y;
    eyeCamera.y += (pmouse[0].x-mouse[0].x) *-speed.x;
    if(eyeCamera.x > 360 ) eyeCamera.x = 0 ;
    if( eyeCamera.x < 0  ) eyeCamera.x = 360 ;
    if(eyeCamera.y > 360 ) eyeCamera.y = 0 ; 
    if(eyeCamera.y < 0   ) eyeCamera.y = 360 ; 
  } else {
    //change the boolean to true for the next mousepressed
    newRefEyeMouse = true ;
  }
  //zoom
  //zoom
  if(cLongTouch) { 
    zoom() ;
    sceneCamera.z -= getCountZoom ;
  }

  
  camera() ;
  beginCamera() ;

  //scene position
  translate(sceneCamera.x +width/2, sceneCamera.y +height/2, sceneCamera.z) ;
  //eye direction
  rotateX(radians(eyeCamera.x)) ;
  rotateY(radians(eyeCamera.y)) ;

}
//end camera with speed setting
///////////////////////////////

//UPDATE CAMERA POSITION
void updateCamera(PVector origin, PVector target, float speed) {
  if(!moveScene) sceneCamera = (follow(origin, target, speed)) ;
  if(!moveEye && (gotoCameraPosition || gotoCameraEye)) eyeCamera = backEye()  ;
  //println("distance Ref" + distFollowRef) ;
  //println("distance Current" + currentDistToTarget) ;
}
//stop
void stopCamera() {
  if(modeP3D) {
    popMatrix() ;
    endCamera() ;
  }
}
//END of CAMERA move




//CHANGE the position of the CAMERA
///////////////////////////////////
//RAW
void cameraGoto(PVector newPos ) {
  sceneCamera = newPos ;
}


//END of change position of CAMERA
//////////////////////////////////


//GET
PVector getEyeCamera() { return eyeCamera ; }
PVector getPosCamera() { return sceneCamera ; }




//INIT FOLLOW
float distFollowRef = 0 ;
PVector eyeBackRef = new PVector(0,0,0 ) ;
//travelling with only camera position
void travelling(PVector target) {
  distFollowRef = PVector.dist(target, sceneCamera) ;
  
  targetPosCam = target ; 
  eyeBackRef = getEyeCamera() ;
  absPosition = new PVector(0,0,0) ;
  gotoCameraPosition = true ;
  gotoCameraEye = true ;
}


//END INIT FOLLOW

float speedX  ;
float speedY  ;
    
PVector backEye() {
  PVector eye = new PVector(0,0) ;

  if(gotoCameraEye) {
    if(currentDistToTarget > 2 ) {
      travellingPriority = true ;
      /*
      if(eye.x < 2 || eye.x > 358 ) if (eyeBackRef.x < 180 ) eye.x = map(currentDistToTarget,distFollowRef, 0,eyeBackRef.x, 0) ; else eye.x = map(currentDistToTarget,distFollowRef, 0,eyeBackRef.x, 360) ;
      if(eye.y < 2 || eye.y > 358 ) if (eyeBackRef.y < 180 ) eye.y = map(currentDistToTarget,distFollowRef, 0,eyeBackRef.y, 0) ; else eye.y = map(currentDistToTarget,distFollowRef, 0,eyeBackRef.y, 360) ;
      // to stop the calcul
      if((eye.x < 2 || eye.x > 358 ) && (eye.y < 2 || eye.y > 358 )) gotoCameraEye = false ;
      println("distance " + eye) ;
      */
      if (eyeBackRef.x < 180 ) eye.x = map(currentDistToTarget,distFollowRef, 0,eyeBackRef.x, 0) ; else eye.x = map(currentDistToTarget,distFollowRef, 0,eyeBackRef.x, 360) ;
      if (eyeBackRef.y < 180 ) eye.y = map(currentDistToTarget,distFollowRef, 0,eyeBackRef.y, 0) ; else eye.y = map(currentDistToTarget,distFollowRef, 0,eyeBackRef.y, 360) ;
      //stop the calcul
      if(eye.x < 2 || eye.x > 358 ) eye.x = 0 ;
      if(eye.y < 2 || eye.y > 358 ) eye.y = 0 ; 
      if(eye.x == 0  && eye.y == 0) {
        gotoCameraEye = false ;
        travellingPriority = false ;
      }
    } else {
      //speed of the eye to return to original position
      float speedBackEye = 0.2 ;
      float ratioX = eyeBackRef.x / frameRate *speedBackEye ;
      float ratioY = eyeBackRef.y / frameRate *speedBackEye ;
      speedX += ratioX ;
      speedY += ratioY ;
      //speedX += .5 ;
      //speedY += .5 ;
      if (eyeBackRef.x < 180 && !travellingPriority ) eye.x = eyeBackRef.x -speedX ; else eye.x  = eyeBackRef.x +speedX ;
      if (eyeBackRef.y < 180 && !travellingPriority ) eye.y = eyeBackRef.y -speedY ; else eye.y  = eyeBackRef.y +speedY ;
      // to stop the calcul
      if(eye.x < 2 || eye.x > 358 ) eye.x = 0 ;
      if(eye.y < 2 || eye.y > 358 ) eye.y = 0 ;  
      
      if(eye.x == 0  && eye.y == 0) {
        travellingPriority = false ;
        gotoCameraEye = false ;
        speedX = 0 ;
        speedY = 0 ;
      }
    }
  } 
  
  //reset the value and the boolean for a next move
  /*
  if(currentDistToTarget < 5 && (eye.x < 2 || eye.x > 358 )  && (eye.y < 2 || eye.y > 358 )) {
    gotoCameraEye = false ;
  */
  return eye ;
}


//MAIN VOID
PVector speedByAxes = new PVector(0,0,0) ;
//
/*
void cameraGoto(PVector newPos, float speed) {
  cameraSpeedMove = speed ;
  newDistanceToTarget = new PVector(0,0,0) ;
  distToCamera = PVector.sub(sceneCamera, newPos) ;
  speedByAxes = PVector.div(distToCamera, 1.0 / speed) ;
}
*/
//calculate new position to go at the new target camera
PVector distToTargetUpdated = new PVector (0,0,0) ;
float currentDistToTarget = 0 ;
PVector currentPosition = new PVector(0,0,0) ;
PVector absPosition = new PVector(0,0,0) ;
// PVector targetPoint ;

PVector follow(PVector origin, PVector target, float speed) {
  //very weird I must inverse the value to have the good result !
  //and change again at the end of the algorithm
  target.x = -target.x ;
  target.y = -target.y ;
  target.z = -target.z ;
  
  //updated the distance in realtime
  distToTargetUpdated = PVector.sub(currentPosition, target) ;
  currentDistToTarget = PVector.dist(currentPosition, target) ;
  
  
  //calculate the speed to go to target
  PVector absValueOfDist = new PVector (abs(distToTargetUpdated.x),abs(distToTargetUpdated.y),abs(distToTargetUpdated.z));
  absValueOfDist.normalize() ;
  //speedByAxes = PVector.div(absValueOfDist, 1.0 / speed) ; 
  speedByAxes = PVector.mult(absValueOfDist, speed) ;
  // PVector rangeStop = PVector.mult(speedByAxes,5000) ;
  PVector rangeStop = new PVector(5,5,5) ; 
  //calculate the new absolute position

  //XYZ
  if ( (distToTargetUpdated.x > rangeStop.x || distToTargetUpdated.x < -rangeStop.x) && 
        (distToTargetUpdated.y > rangeStop.y || distToTargetUpdated.y < -rangeStop.y) && 
        (distToTargetUpdated.y > rangeStop.z || distToTargetUpdated.y < -rangeStop.z))  {
    if (origin.x < target.x )  absPosition.x += speedByAxes.x ;  else absPosition.x -= speedByAxes.x ;
    if (origin.y < target.y )  absPosition.y += speedByAxes.y ;  else absPosition.y -= speedByAxes.y ;
    if (origin.z < target.z )  absPosition.z += speedByAxes.z ;  else absPosition.z -= speedByAxes.z ;
  //XY  
  } else if ( (distToTargetUpdated.x > rangeStop.x || distToTargetUpdated.x < -rangeStop.x) && 
              (distToTargetUpdated.y > rangeStop.y || distToTargetUpdated.y < -rangeStop.y)) {
    if (origin.x < target.x )  absPosition.x += speedByAxes.x ;  else absPosition.x -= speedByAxes.x ;
    if (origin.y < target.y )  absPosition.y += speedByAxes.y ;  else absPosition.y -= speedByAxes.y ;
    absPosition.z += 0 ;
  //XZ
  } else if ( (distToTargetUpdated.x > rangeStop.x || distToTargetUpdated.x < -rangeStop.x) && 
              (distToTargetUpdated.y > rangeStop.z || distToTargetUpdated.y < -rangeStop.z))  {
    if (origin.x < target.x )  absPosition.x += speedByAxes.x ;  else absPosition.x -= speedByAxes.x ;
    absPosition.y += 0 ;
    if (origin.z < target.z )  absPosition.z += speedByAxes.z ;  else absPosition.z -= speedByAxes.z ;
  //YZ
  } else if ( (distToTargetUpdated.y > rangeStop.y || distToTargetUpdated.y < -rangeStop.y) && 
              (distToTargetUpdated.y > rangeStop.z || distToTargetUpdated.y < -rangeStop.z))  {
    absPosition.x += 0 ;
    if (origin.y < target.y )  absPosition.y += speedByAxes.y ;  else absPosition.y -= speedByAxes.y ;
    if (origin.z < target.z )  absPosition.z += speedByAxes.z ;  else absPosition.z -= speedByAxes.z ;
  //X
  } else if ( (distToTargetUpdated.x > rangeStop.x || distToTargetUpdated.x < -rangeStop.x)) {
    if (origin.x < target.x )  absPosition.x += speedByAxes.x ;  else absPosition.x -= speedByAxes.x ;
    absPosition.y += 0 ;
    absPosition.z += 0 ;
  //Y  
  } else if ( (distToTargetUpdated.y > rangeStop.y || distToTargetUpdated.y < -rangeStop.y))  {
    absPosition.x += 0 ;
    if (origin.y < target.y )  absPosition.y += speedByAxes.y ;  else absPosition.y -= speedByAxes.y ;
    absPosition.z += 0 ;
  //Z
  } else if ( (distToTargetUpdated.y > rangeStop.z || distToTargetUpdated.y < -rangeStop.z))  {
    absPosition.x += 0 ;
    absPosition.y += 0 ;
    if (origin.z < target.z )  absPosition.z += speedByAxes.z ;  else absPosition.z -= speedByAxes.z ;
  //IT'S DONE, NOTHING TO DO NOW
  } else {  
    absPosition.x += 0 ;
    absPosition.y += 0 ;
    absPosition.z += 0 ;
    gotoCameraPosition = false ;
  }
  
  //very weird I must inverse the value to have the good result !
  target.x = -target.x ;
  target.y = -target.y ;
  target.z = -target.z ;


  //finalize the newposition of the point
  currentPosition = PVector.add(origin, absPosition) ;
  
  return currentPosition ;
}
