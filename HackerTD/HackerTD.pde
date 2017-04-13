Log logger; 
int background = 0;
Mouse mouse;
Map testMap;

void setup() {
  size(1200, 800);
  surface.setResizable(true);
  
  frameRate(30);
  
  logger = new Log();
  mouse = new Mouse(millis());
  testMap = new Map(100, 0);
  testMap.addTower("basicTower", 400, 400);
}

void draw() {
  int time = millis();  
  mouse.update(time, mousePressed);
  mouseLogging(time);
  
  testMap.display();
  text(str(time), width-100, 10);
  
  
  logger.update(time);
  logger.display(time);
}

void mouseLogging(int time) {
    if (mouse.currentEvent == "click") {
      LogLine l = new LogLine("Mouse click at: " + str(time) + ": X " + str(mouseX) + ", Y " + str(mouseY), time, 5000);
      logger.add_line(l);
    }
    if (mouse.currentEvent == "hold") {
      LogLine l = new LogLine("Mouse hold at: " + str(time) + ": X " + str(mouseX) + ", Y " + str(mouseY), time, 5000);
      logger.add_line(l);
    }
}


boolean over_rect (int x, int y, int rectWidth, int rectHeight) {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }  
}