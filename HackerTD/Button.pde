/*Found a Button Class on Processing tutorial
 * Code can be found here: http://processingjs.org/learning/topic/buttons/
 * I only needed square buttons for this project so I just used the square button class
 *
 */
boolean locked = false;

class Button{
  int x, y, sizeX, sizeY;
  color basecolor, highlightcolor, currentcolor;
  boolean over = false;
  boolean pressed = false;
  PImage img;
  String label;
  

  
 /**
 * Button constructor
 * @param int ix position for button to be created at
 * @param int iy position for button to be created at 
 * @param int ixsize size you want the box to be in the x direction
 * @param int iysize size you want the box to be in the y direction
 * @param color icolor is the default color
 * @param color ihighlight is the hover color
 * @param String imgLocation is the location of an image used in the image
 * @param String ilabel is the words place on button
 **/
  Button(int ix, int iy, int ixsize, int iysize, color icolor, color ihighlight, String imgLocation, String ilabel){
    x = ix;
    y = iy;
    sizeX = ixsize;
    sizeY = iysize;
    basecolor = icolor;
    highlightcolor = ihighlight;
    currentcolor = basecolor;
    if(imgLocation != ""){
      img = loadImage(imgLocation);
    }
    label = ilabel;
    
    
  }
  
//Detrmines if the cursor is over the button or not
  boolean over(){
   if(overRect(x,y,sizeX,sizeY)){
     over = true; 
     return true;
   } else {
     over = false;
     return false;
   }
  }
  
// Check to make sure the cursor is over the box
  boolean overRect(int x, int y, int width, int height){
    if(mouseX >= x && mouseX <= x+width &&
        mouseY >= y && mouseY <= y+height){
          return true;
        } else {
         return false; 
        }
  }
  
//checked if button is pressed
  boolean pressed(){
    if(over){
     locked = true;
     return true;
    } else {
      locked = false;
      return false;
    }
     
   }
  // Update checks to see if there was any changes 
  void update(){
    if(over()){
      currentcolor = highlightcolor;
    }else{
      currentcolor = basecolor;
    }
  }

  //display the button   
  void display(){
    //beginShape();
    stroke(255);
    fill(currentcolor);
    //texture(img);
    rect(x,y,sizeX,sizeY);
    //endShape();
    if(img != null){
      image(img,x,y, sizeX, sizeY);
    }
    
    if(label.length() >= 1){
      textSize(32);
      fill(highlightcolor);
      text(label, x + 20, y + 30); 
    }
  }
   
 }