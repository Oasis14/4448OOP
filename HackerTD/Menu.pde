class Menu {
  String name;
  
  Menu(String n) {
    name = n;
  }
  
 Button button = new Button(300,300,100,255,0);
  
  void update(int time) {
    /*LogLine l = new LogLine("Menu updated", time, 5000);
    logger.add_line(l);*/
    button.update();
    
  }
  
  void display() {
    /*LogLine l = new LogLine("Menu displayed", millis(), 5000);
    logger.add_line(l);*/
    button.display();
  }
}