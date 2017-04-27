class GameMenu extends Menu {
  
  Button pause = new Button(1150,10,20,20,255,0,"images/pause.png","");
  GameMenu(){
    super("gameMenu");
  }
  
  void update(int time) {
    paused = false;
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
       currentMenu = "mainMenu";
       paused = true;
     }
    }
  }
  
  void display(){
    pause.display();
  }

}