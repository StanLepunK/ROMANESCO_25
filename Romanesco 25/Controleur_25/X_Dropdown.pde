//
boolean dropdownOpen ; // use to indicate to indicate at the other button, they cannot be used when the user are on the dropdown menu

// CLASS
public class Dropdown {
  //Slider dropdown
  Slider sliderDropdown ;
  // private PFont fontDropdown ;
  private PVector posSliderDropdown, sizeSliderDropdown, posMoletteDropdown, sizeMoletteDropdown, sizeBoxDropdownMenu ;
  //dropdown
  private int line = 0;
  private String listItem[] , title ;
  private boolean locked, slider ;
  private final color colorTitleIn, colorTitleOut, colorBG, colorTextBox ; 
  private final color boxIn, boxOut ;
  private PVector pos, size, posText;
  private float factorPos  ; // use to calculate the margin between the box
  int sizeBox ;
  private int startingDropdown = 0 ;
  private int endingDropdown = 1 ;
  private int updateDropdown = 0 ; //for the slider update
  private float missing ;

  //CONSTRUCTOR
  public Dropdown(String title, String [] listItem, PVector pos, PVector size, PVector posText, color colorBG, color colorTitleIn, color colorTitleOut, color boxIn, color boxOut, color colorTextBox, int sizeBox ) {
    //dropdown
    this.title = title ;
    this.listItem = listItem;
    this.pos = pos;
    this.posText = posText ;

    this.size = size; // header size
    this.sizeBox = sizeBox ;
    this.colorTitleIn = colorTitleIn ;
    this.colorTitleOut = colorTitleOut ;
    this.colorTextBox = colorTextBox ;
    this.colorBG = colorBG ;
    this.boxIn = boxIn ;
    this.boxOut = boxOut ;
    endingDropdown = int(size.z + 1) ;
    // security if the size of dropdown is superior of the item list
    if (endingDropdown > listItem.length ) endingDropdown = listItem.length ;
    // difference between the total list item and what is possible to display
    missing = listItem.length - endingDropdown  ;
   
    //size of the dropdow, for the bottom part
    sizeBoxDropdownMenu = new PVector (longestWord(listItem, 1, listItem.length) *sizeBox *.46, sizeBox) ; 
    
    
    //slider dropdown
    //condition to display the slider
    if (listItem.length > endingDropdown) slider = true ; else slider = false ;
    
    if (slider) {
      sizeSliderDropdown = new PVector (sizeBox *.5, ((endingDropdown ) *sizeBox ) -pos.z) ;
      posSliderDropdown = new PVector(pos.x -sizeSliderDropdown.x -(pos.z *2.0), pos.y +sizeBox +(1.8 *pos.z)) ;
      posMoletteDropdown = posSliderDropdown ;
      
      float factorSizeMolette = float(listItem.length) / float(endingDropdown -1 ) ;
      
      sizeMoletteDropdown =  new PVector (sizeSliderDropdown.x, sizeSliderDropdown.y /factorSizeMolette) ;
      
      sliderDropdown = new Slider(posSliderDropdown, posMoletteDropdown, sizeSliderDropdown, sizeMoletteDropdown, colorBG, boxIn, boxOut) ;
      sliderDropdown.sliderSetting() ;
    }
  }
  
  //DRAW
  void dropdownUpdate(PFont titleFont, PFont dropdownFont) {
    //to be sure of the position
    rectMode(CORNER);
    //Dropdown
    if (locked) {
      dropdownOpen = true ;
      titleWithoutBox(title, 1, size, titleFont);
      //give the position of dropdown
      int step = 2 ;
      //give the position in list of Item with the position from the slider's molette
      if (slider) updateDropdown = round(map (sliderDropdown.getValue(), 0,1, 0, missing)) ;
      //loop to display the item list
      for ( int i = startingDropdown + updateDropdown ; i < endingDropdown + updateDropdown ; i++) {
        //bottom rendering
        renderBox(listItem[i], step++, sizeBoxDropdownMenu, dropdownFont, colorTextBox);
        //Slider dropdown
        if (slider) {
          sliderDropdown.sliderUpdate() ;
          fill(colorBG) ;
        }
      }
    } else {
      //header rendering
      dropdownOpen = false ;
      titleWithoutBox(title, 1, size, titleFont);
    }
  }


  //DISPLAY
  public void titleWithoutBox(String title, int step, PVector size, PFont font) {
    //update
    factorPos = step + pos.z -1 ;
    float yLevel = step == 1 ? pos.y  : (pos.y + (size.y *(factorPos )));
    PVector newPosDropdown = new PVector (pos.x, yLevel) ;
    if (insideRect(newPosDropdown, size)) fill(colorTitleIn); else fill(colorTitleOut) ;
    textFont(font);
    text(title, pos.x +posText.x , yLevel +posText.y);
  }
  
  public void renderBox(String label, int step, PVector sizeBoxDropdown, PFont font, color textColor) {
    //update
    factorPos = step + pos.z -1 ;
    float yLevel = step == 1 ? pos.y  : (pos.y + (sizeBoxDropdown.y *(factorPos)));
    PVector newPosDropdown = new PVector (pos.x, yLevel) ;
    if (insideRect(newPosDropdown, sizeBoxDropdown)) fill(boxIn); else fill(boxOut) ;
    //display
    noStroke() ;
    if (insideRect(newPosDropdown, size)) fill(boxIn); else fill(boxOut) ;
    int sizeWidthMin = 60 ;
    int sizeWidthMax = 120 ;
    if (sizeBoxDropdown.x < sizeWidthMin ) sizeBoxDropdown.x = sizeWidthMin ; else if(sizeBoxDropdown.x > sizeWidthMax ) sizeBoxDropdown.x = sizeWidthMax ;
    rect(pos.x, yLevel, sizeBoxDropdown.x, sizeBoxDropdown.y);
    fill(textColor);
    textFont(font);
    text(label, pos.x +posText.x , yLevel +sizeBox -(ceil(sizeBox*.2)));
  }
  
  

  
  //RETURN
  //Check the dropdown when this one is open
  public int selectDropdownLine(float newWidth) {
    if(mouseX >= pos.x && mouseX <= pos.x +newWidth && mouseY >= pos.y && mouseY <= ((listItem.length+1) *size.y) +pos.y) {
      //choice the line
      int line = floor( (mouseY - (pos.y +size.y )) / size.y ) +updateDropdown;
      return line;
    } else {
      return -1; 
    }
  }
  //return which line is selected
  public void whichDropdownLine(int l ) {
    line = l ;
  }
  //return which line of dropdown is selected
  public int getSelection() {
    return line ;
  }
}
