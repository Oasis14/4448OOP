/*
 * 
 * 
 *
 */

class Label{
  int x, y, fontSize;
  color basecolor, highlightcolor, currentcolor;
  boolean over = false;
  boolean pressed = false;
  PImage img;
  String label;
  

  
 /**
 * Label constructor
 * @param int ix position for button to be created at
 * @param int iy position for button to be created at 
 * @param int ifontSize for the size of text
 * @param color icolor is the default color
 * @param String ilabel is the words to be displayed
 **/
  Label(int ix, int iy,int ifontSize, color icolor,String ilabel){
    x = ix;
    y = iy;
    fontSize = ifontSize;
    basecolor = icolor;
    label = ilabel;
  }
  
  void updateLabel(String newLabel){
    label = newLabel;
  }

  void updateLabel(char newChar){
    label = Character.toString(newChar);
  }
  
  //display the label   
  void display(){
    if(label.length() >= 1){
      textSize(fontSize);
      fill(highlightcolor);
      text(label, x, y); 
    }
  }
   
 }