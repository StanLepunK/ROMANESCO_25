//GLOBAL
//////////////////////////////MINIM///////////////////////////////////
//GLOBAL PARAMETER Minim
Minim minim;
AudioInput input; // music from outside
// spectrum
FFT fft; 
//beat
BeatDetect beatEnergy, beatFrequency;
BeatListener bl;

//Beat
float beatData, kickData, snareData, hatData ;
float minBeat = 1.0 ;
float maxBeat = 10.0  ;
//....................variable son
//volume
float gaucheBrute, droiteBrute, // son droite gauche
      mixBrute ;


//SETUP Minim
void minimSetup() {
  //Sound
  minim = new Minim(this);
  //sound from outside
  minim.debugOn();
  input = minim.getLineIn(Minim.STEREO, 512);
  
  spectrumSetup() ;
  beatSetup() ;
}
//SETUP
void beatSetup() {
  //Beat Frequency
  beatFrequency = new BeatDetect(input.bufferSize(), input.sampleRate());
  beatFrequency.setSensitivity(300);
  kickData = snareData = hatData = minBeat; 
  bl = new BeatListener(beatFrequency, input); 
  
  //Beat energy
  beatEnergy = new BeatDetect();
  beatData = 1.0 ;
}



//DRAW
void minimDraw() {
  //General Draw
  spectrum(input.mix) ;
  beatEnergy.detect(input.mix);
  initTempo() ;
  
  //DRAW specific to Romanesco
  int son = 1 ;
    
  float volumeControleurG = map(valueSliderGlobal[4], 0,100, 0, 1.3 ) ;
   gauche[0] = map(input.left.get(son),  -0.07,0.1,  0, volumeControleurG);
  
  float volumeControleurD = map(valueSliderGlobal[5], 0,100, 0, 1.3 ) ;
  droite[0] = map(input.right.get(son),  -0.07,0.1,  0, volumeControleurD);
  
  float volumeControleurM = map(( (valueSliderGlobal[4] + valueSliderGlobal[5]) *.5), 0,100, 0, 1.3 ) ;
  mix[0] = map(input.mix.get(son),  -0.07,0.1,  0, volumeControleurM);
  
  //volume
  if(gauche[0] < 0 ) gauche[0] = 0 ;
  if(gauche[0] > 1 ) gauche[0] = 1.0 ; 
  if(droite[0] < 0 ) droite[0] = 0 ;
  if(droite[0] > 1 ) droite[0] = 1.0 ; 
  if(mix[0] < 0 ) mix[0] = 0 ;
  if(mix[0] > 1 ) mix[0] = 1.0 ;
  
  //Beat
  beat[0] = getBeat() ;
  kick[0] = getKick() ;
  snare[0] = getSnare() ;
  hat[0] = getHat() ;
}
  



//////
//BEAT
//GLOBAL
int beatNum, kickNum, snareNum, hatNum ;
//RETURN
//BEAT QUANTITY
int getBeatNum() {
  if ( beatEnergy.isOnset() ) beatNum += 1 ; else if (  getTotalSpectrum() < 0.03 ) beatNum = 0 ;
  return beatNum ;
}
int getKickNum() {
  if ( beatFrequency.isKick()  ) kickNum += 1 ; else if (  getTotalSpectrum() < 0.03 ) kickNum = 0 ;
  return kickNum ;
}
int getSnareNum() {
  if ( beatFrequency.isSnare()  ) snareNum += 1 ; else if (  getTotalSpectrum() < 0.03 ) snareNum = 0 ;
  return snareNum ;
}
int getHatNum() {
  if ( beatFrequency.isHat()  ) hatNum += 1 ; else if (  getTotalSpectrum() < 0.03 ) hatNum = 0 ;
  return hatNum ;
}

//RESULT
float getBeat() {
  if (Ebeat == 1) {
    if ( beatEnergy.isOnset() ) beatData = maxBeat;
    beatData *= 0.95;
    if ( beatData < minBeat ) beatData = minBeat;
  } else beatData = 1.0 ;
  
  return beatData ;
}

float getKick() {
  if (Ekick == 1 ) {
    if ( beatFrequency.isKick() )  kickData = maxBeat;
    kickData = constrain(kickData * 0.95, minBeat, maxBeat);
  } else kickData = 1.0 ;
  //
  return kickData ;
}

float getSnare() {
  if (Esnare == 1 ) {
    if ( beatFrequency.isSnare() )  snareData = maxBeat;
    snareData = constrain(snareData * 0.95, minBeat, maxBeat);
  } else snareData = 1.0 ;
  //
  return snareData ;
}

float getHat() {
  if (Ehat == 1) {
    if ( beatFrequency.isHat() )  hatData = maxBeat;
    hatData = constrain(hatData * 0.95, minBeat, maxBeat);
  } else hatData = 1.0 ;
  //
  return hatData ;
}
//END BEAT
/////////







///////
//TEMPO
float tempoMin = 0.01 ;
float tempoMax = 1.0 ;
int maxSpecific = 1 ;

// float tempoBeat = 0.005 ;
float mesure ; 
boolean refresh = false ;

//Direct Specific Analyze
//GLOBAL

float tempoBeatRef = 1 ;
float tempoKickRef = 1 ; 
float tempoSnareRef = 1 ; 
float tempoHatRef = 1 ; // for Beat, Kick, Snare, Hat
float tempoB, tempoK,  tempoS,  tempoH  ;
float tempoBeatAdd  = 0.005 ;
float tempoKickAdd  = 0.005 ;
float tempoSnareAdd = 0.005 ;
float tempoHatAdd   = 0.005 ;
//RETURN



//INITIALIZATION

void initTempo() {
  float init = getTempoBeat() + getTempoKick()  + getTempoHat() + getTempoSnare() ;
}


//return global tempo
float getTempoRef() {
  // I remove the snare because is very bad information and slow down the the speed
  float tempoRef = 1 - (getTempoBeatRef() + getTempoKickRef()  + getTempoHatRef() ) *.33 ;
  return tempoRef ;
}
//get tempo
float getTempo() {
  // I remove the snare because is very bad information and slow down the the speed
  float tempo = (getTempoBeat() + getTempoKick()  + getTempoHat() ) *.33 ;
  return tempo ;
}
// return direct BEAT
float getTempoBeat() {
  if ( beatEnergy.isOnset()  ) {
    if( tempoB != 0 ) tempoBeatRef = tempoB ;
    tempoB = 0 ; 
  } else {
    tempoB += tempoBeatAdd  ;
  }
  return tempoB ;
}
float getTempoBeatRef() {
  if (tempoBeatRef > maxSpecific || getTotalSpectrum() < 0.03  ) tempoBeatRef = maxSpecific  ; 
  return  tempoBeatRef ;
}


// return direct KICK
float getTempoKick() {
  if ( beatFrequency.isKick()  ) {
    if( tempoK != 0 ) tempoKickRef = tempoK ;
    tempoK = 0 ; 
  } else {
    tempoK += tempoKickAdd  ;
  }
  return tempoK ;
}
float getTempoKickRef() {
  if (tempoKickRef > maxSpecific || getTotalSpectrum() < 0.03  ) tempoKickRef = maxSpecific  ; 
  return  tempoKickRef ;
}

// return direct SNARE
float getTempoSnare() {
  if ( beatFrequency.isSnare()  ) {
    if( tempoS != 0 ) tempoSnareRef = tempoS ;
    tempoS = 0 ; 
  } else {
    tempoS += tempoSnareAdd  ;
  }
  return tempoS ;
}
float getTempoSnareRef() {
  if (tempoSnareRef > maxSpecific || getTotalSpectrum() < 0.03  ) tempoSnareRef = maxSpecific  ; 
  return  tempoSnareRef ;
}

// return direct Hat
float getTempoHat() {
  if ( beatFrequency.isHat()  ) {
    if( tempoH != 0 ) tempoHatRef = tempoH ;
    tempoH = 0 ; 
  } else {
    tempoH += tempoHatAdd  ;
  }
  return tempoH ;
}
float getTempoHatRef() {
  if (tempoHatRef > maxSpecific || getTotalSpectrum() < 0.03  ) tempoHatRef = maxSpecific  ; 
  return  tempoHatRef ;
}




//Average Analyze
//GLOBAL
float tempoAverage, tempoAverageRef  ;
float tempoBeatAverage = 0.05 ;
//RETURN
float tempoAverageRef()
{
  //regulation du tempo
  if ( mesure == 0 && !refresh ) {
    tempoAverageRef = tempoAverage()  ;
    tempoAverage = 0.01 ;
    refresh = true ;
  }
  if ( mesure != 0 ) refresh = false ;
  
  return tempoAverageRef ;
}


float tempoAverage()
{
  mesure = second()%2 ;
  
  if ( beatEnergy.isOnset() || beatFrequency.isKick() || beatFrequency.isSnare() || beatFrequency.isHat()  )  tempoAverage += tempoBeatAverage  ;
  if ( tempoAverage > 1.0 ) tempoAverage = 1.0 ;
  
  //regulation du tempo
  if ( mesure == 0 && !refresh ) {
    tempoAverageRef = tempoAverage  ;
    tempoAverage = 0.01 ;
    refresh = true ;
  }
  
  if ( mesure != 0 ) refresh = false ;
  
  return tempoAverage ;
}

//END TEMPO
//////////


//TIME TRACK
////////////
//GLOBAL
int timeTrack  ;
//RETURN
float getTimeTrack()
{
  float t ; 
  timeTrack += millis() % 10 ;
  t = timeTrack *.01 ;
  if ( getTotalSpectrum() < 0.1 ) timeTrack = 0 ;
  return round( t * 10.0f ) / 10.0f; 
}
////////////////
//END TIME TRACK


//SPECTRUM
//////////
//SPECTRUM
//global
int spectrumBandNumber = 16; // quantity analysis
//info text band
float [] band = new float [16] ;


//SETUP
void spectrumSetup()
{
  //spectrum
  fft = new FFT(input.bufferSize(), input.sampleRate());
  fft.linAverages(spectrumBandNumber);
}

//DRAW
//just create spectrum
void spectrum(AudioBuffer fftData)
{
  fft.forward(fftData) ;
  for(int i = 0; i < spectrumBandNumber ; i++)
  {
    fft.scaleBand(i, 0.5 ) ;
    band[i] = fft.getBand(i) ;
  }
}

//ANNEXE VOID
float getTotalSpectrum() 
{
  float t = band[0] + band[1] + band[2] + band[3] + band[4] + band[5] + band[6] + band[7] + band[8] + band[9] + band[10] + band[11] + band[12] + band[13] + band[14] + band[15] ;
  return t ;
}
//END SPECTRUM
//////////////


//END MINIM
void stop()
{
  input.close() ;
  minim.stop() ;
  super.stop() ;
}
//////
//END


//CLASS to use the beat analyze
class BeatListener implements AudioListener
{
  private BeatDetect beatFrequency;
  private AudioInput source;
  
  BeatListener(BeatDetect beatFrequency, AudioInput source)
  {
    this.source = source;
    this.source.addListener(this);
    this.beatFrequency = beatFrequency;
  }
  
  void samples(float[] samps)
  {
    beatFrequency.detect(source.mix);
  }
  
  void samples(float[] sampsL, float[] sampsR)
  {
    beatFrequency.detect(source.mix);
  }
}
