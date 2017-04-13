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
  
  void update(int time, boolean pressed) {
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
  }
  
}