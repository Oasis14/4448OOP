Log Logger; 
int background = 0;
Mouse mouse;
PImage testImage;

void setup() {
  size(1200, 800);
  surface.setResizable(true);
  
  frameRate(30);
  Logger = new Log();
  
  mouse = new Mouse(millis());
  testImage = loadImage("testImage.png");
  image(testImage, 400,400);
}

void draw() {
  int time = millis();
  background(background);
  image(testImage, 400,400);
  text(str(time), width-100, 10);
  
  mouse.update(time, mousePressed, true);
  
  Logger.update(time);
  Logger.display(time);
}




boolean over_rect (int x, int y, int rectWidth, int rectHeight) {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }  
}