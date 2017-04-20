class GameMenu extends Menu {
  
  Button pause = new Button(1150,10,20,20,255,0,"images/pause.png");
  GameMenu(){
    super("GameMenu");
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

       print("Paused pressed \n");

       super.name = "pausedMenu";
       
     }
    }
  }
  
  void display(){
    pause.display();
  }

}