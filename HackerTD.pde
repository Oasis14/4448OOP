Log Logger; 
int background = 0;
Tower testTower;
Mouse mouse;
PImage testImage;

void setup() {
  size(1200, 800);
  surface.setResizable(true);
  
  //frameRate(15);
  Logger = new Log();
  
  testTower = new Tower(100,100,100,100, loadImage("testImage.png"));
  mouse = new Mouse(millis());
  testImage = loadImage("testImage.png");
  image(testImage, 400,400);
}

void draw() {
  int time = millis();
  background(background);
  image(testImage, 400,400);
  text(str(time), width-100, 10);
  
  mouse.update(time, mousePressed, false);
  
  Logger.update(time);
  Logger.display(time);
}

class Mouse {
  String currentEvent;
  int lastChangeTime;
  int clickTime;
  boolean lastMousePressed;
  
  Mouse(int time) {
    currentEvent = "";
    lastChangeTime = time; 
    clickTime = 300;
    lastMousePressed = false;
  }
  
  void update(int time, boolean pressed, boolean logging) {
    //TODO: be able to differentiate between clicks, holds, and such
    if (pressed) {
      if (lastMousePressed) {
        if ((time - lastChangeTime) > clickTime) {
          currentEvent = "hold";
        } else {
          currentEvent = ""; 
        }
      } else {
        lastChangeTime = time;
        currentEvent = "";
      }
    } else {
      if (lastMousePressed) {
        if ((time - lastChangeTime) < clickTime) {
          currentEvent = "click";
        } else {
          currentEvent = ""; 
        }
        lastChangeTime = time;
      } else {
        currentEvent = "";
      }
    }
    lastMousePressed = pressed;
    if (logging) {
      if (currentEvent == "click") {
        LogLine l = new LogLine("Mouse click at: " + str(time), time, 5000);
        Logger.addLine(l);
      }
      if (currentEvent == "hold") {
        LogLine l = new LogLine("Mouse hold at: " + str(time), time, 5000);
        Logger.addLine(l);
      }
    }
  }
  
}


class Tower {
   int x, y, towerWidth, towerHeight, damage;
   PImage icon;
   
   Tower (int newX, int newY, int tw, int th, PImage newIcon) {
     x = newX;
     y = newY;
     icon = newIcon;
     towerHeight = th;
     towerWidth = tw;
   }
   
   void move(int newX, int newY) {
     x = newX;
     y = newY;
   }
   
   void draw() {
     image(icon, x, y, towerWidth, towerHeight);
   }
}


boolean overRect (int x, int y, int rectWidth, int rectHeight) {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }  
}

class LogLine {
  int timeCreated, end, duration;
  String text;
  
  LogLine (String t, int tC, int d) {
    text = t;
    timeCreated = tC;
    duration = d;
    end = timeCreated + duration;
  }
}

class Log {
  ArrayList<LogLine> logLines;
  Log () {
    logLines = new ArrayList<LogLine>(); 
  }
  void update (int time) {
    for (int i = logLines.size()-1; i >= 0; i--){
      LogLine l = logLines.get(i);
      if (l.end < time) {
        logLines.remove(i);
      }
    }
  }
  void display (int time) {
    int ypos = 10;
    float textColor;
    
    for (int i = logLines.size()-1; i >= 0; i--){
      LogLine l = logLines.get(i);
      textColor = 55 + 200 * (1 - ((time - l.timeCreated)/float(l.duration)));
      fill(textColor);
      text(l.text, 0, ypos);
      ypos += 10;
    }
  }
  void addLine (LogLine l) {
    logLines.add(l);
  } 
}