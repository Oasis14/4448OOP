/*Found a Button Class on Processing tutorial
 * Code can be found here: http://processingjs.org/learning/topic/buttons/
 * I only needed square buttons for this project so I just used the square button class
 *
 */
boolean locked = false;

class Button{
  int x, y, size;
  color basecolor, highlightcolor, currentcolor;
  boolean over = false;
  boolean pressed = false;
  PImage img;
  

  
//Constuctor for the square button
  Button(int ix, int iy, int isize, color icolor, color ihighlight, String imgLocation){
    x = ix;
    y = iy;
    size = isize;
    basecolor = icolor;
    highlightcolor = ihighlight;
    currentcolor = basecolor;
    img = loadImage(imgLocation);
    
    
  }
  
//Detrmines if the cursor is over the button or not
  boolean over(){
   if(overRect(x,y,size,size)){
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
  void draw(){
    
  }
  //display the button   
  void display(){
    //beginShape();
    stroke(255);
    fill(currentcolor);
    texture(img);
    rect(x,y,size,size);
    //endShape();
    image(img,x,y, size, size);
  }
   
 }