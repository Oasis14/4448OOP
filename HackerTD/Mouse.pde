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
        LogLine l = new LogLine("Mouse click at: " + str(time) + ": X " + str(mouseX) + ", Y " + str(mouseY), time, 5000);
        Logger.add_line(l);
      }
      if (currentEvent == "hold") {
        LogLine l = new LogLine("Mouse hold at: " + str(time) + ": X " + str(mouseX) + ", Y " + str(mouseY), time, 5000);
        Logger.add_line(l);
      }
    }
  }
  
}