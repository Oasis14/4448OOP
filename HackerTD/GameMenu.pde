class GameMenu extends Menu {
  
  Button pause = new Button(1150,10,20,255,0,"images/pause.png");
  GameMenu(String n){
    super(n);
  }
  
  void update(int time) {
    /*LogLine l = new LogLine("Menu updated", time, 5000);
    logger.add_line(l);*/
    pause.update();
    if(locked == false){
      //update buttons here
      
    }else{
     locked = false; 
    }
    
    if(mousePressed){
     //check each button
     if(pause.pressed()){
       //Code here to react when game paused
        paused=!paused;
        text("Game Paused", 100, 100);
     }
    }
  }
  
  void display(){
    pause.display();
  }

}