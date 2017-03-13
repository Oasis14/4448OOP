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