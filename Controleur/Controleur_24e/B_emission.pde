//GLOBAL
import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress targetPreScene ;
// local
String IPadress = ("127.0.0.1") ;
// Message to préScène
String toPreScene [] = new String [8] ;



void sendOSCsetup() {
  
 osc = new OscP5(this, 10000);
 //To Préscène
 targetPreScene = new NetAddress(IPadress,10000);

  
}

void sendOSCdraw()
{
  OscMessage RomanescoControleur = new OscMessage("ROMANESCO contrôleur");
  
  //int value join in one String 
  translateDataToSend() ;
  
  //BUTTON to String
  toPreScene[0] = joinIntToString(valueButtonGlobal) ; 
  toPreScene[1] = joinIntToString(valueButtonObj) ;
  toPreScene[2] = joinIntToString(valueButtonTex) ;
  toPreScene[3] = joinIntToString(valueButtonTypo) ;
  
  //SLIDER to String
  int[] dataIntGlobal = new int[10] ;
  for ( int i = 1   ; i < 11 ; i++) { dataIntGlobal[i-1] = floor(valueSlider[i]) ; }
  toPreScene[4] = joinIntToString(dataIntGlobal) ;
  //float value slider obj
  int[] dataIntObj = new int[30] ;
  for ( int i = 11   ; i < 41 ; i++) { dataIntObj[i-11] = floor(valueSlider[i]) ; }
  toPreScene[5] = joinIntToString(dataIntObj);
  //float value slider tex
  int[] dataIntTex = new int[30] ;
  for ( int i = 111   ; i < 141 ; i++) { dataIntTex[i-111] = floor(valueSlider[i]) ; }
  toPreScene[6] = joinIntToString(dataIntTex) ;
  //float value slider typo
  int[] dataIntTypo = new int[30] ;
  for ( int i = 211   ; i < 241 ; i++) { dataIntTypo[i-211] = floor(valueSlider[i]) ; }
  toPreScene[7] = joinIntToString(dataIntTypo) ;
  
  //add to OSC
  for ( int i = 0 ; i < toPreScene.length ; i++) {
    RomanescoControleur.add(toPreScene[i]);
  }
  
  //send
  osc.send(RomanescoControleur, targetPreScene ); 
}



  
  
  
void translateDataToSend()
{
  //BUTTON GLOBAL
  //sound
  valueButtonGlobal[1] = EtatBbeat ;
  valueButtonGlobal[2] = EtatBkick ;
  valueButtonGlobal[3] = EtatBsnare ;
  valueButtonGlobal[4] = EtatBhat ;
  //meteo
  valueButtonGlobal[5] = EtatButtonMeteo ;
  //dropdown typo
  valueButtonGlobal[7] = dropdown[99].getSelection() +1 ; ;
  //rideau
  valueButtonGlobal[10] = EtatBOrideau ;
  
  //BUTTON OBJ
  int numObj = 9 ;
  for ( int i = 0 ; i < numObj ; i ++) {
    valueButtonObj[i *10 +1] = EtatBOf[i *10 +11] ;
    valueButtonObj[i *10 +2] = EtatBOf[i *10 +12] ;
    valueButtonObj[i *10 +3] = EtatBOf[i *10 +13] ;
    valueButtonObj[i *10 +4] = EtatBOf[i *10 +14] ;
    valueButtonObj[i *10 +5] = EtatBOf[i *10 +15] ;
    
    valueButtonObj[i *10 +9] = dropdown[i +1].getSelection() ;
  }
  //BUTTON TEX
  int numTex = 7 ;
  for ( int i = 0 ; i < numTex ; i ++) {
    valueButtonTex[i *10 +1] = EtatBTf[i *10 +11] ;
    valueButtonTex[i *10 +2] = EtatBTf[i *10 +12] ;
    valueButtonTex[i *10 +3] = EtatBTf[i *10 +13] ;
    valueButtonTex[i *10 +4] = EtatBTf[i *10 +14] ;
    valueButtonTex[i *10 +5] = EtatBTf[i *10 +15] ;
    valueButtonTex[i *10 +9] = dropdown[i +21].getSelection() ;
  }
  //BUTTON TYPO
  int numTypo = 5 ;
  for ( int i = 0 ; i < numTypo ; i ++) {
    valueButtonTypo[i *10 +1] = EtatBTYf[i *10 +11] ;
    valueButtonTypo[i *10 +2] = EtatBTYf[i *10 +12] ;
    valueButtonTypo[i *10 +3] = EtatBTYf[i *10 +13] ;
    valueButtonTypo[i *10 +4] = EtatBTYf[i *10 +14] ;
    valueButtonTypo[i *10 +5] = EtatBTYf[i *10 +15] ;
    
    valueButtonTypo[i *10 +9] = dropdown[i +41].getSelection() ;
  }

}
  





  
