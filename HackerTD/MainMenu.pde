class MainMenu extends Menu{
  
 Button newGame = new Button(475,300,250, 35,255,0,"","New Game");
 Button resumeGame = new Button(475,350,250, 35,255,0,"","Resume Game");
 Button exitGame = new Button(475,400,250, 35,255,0,"","Exit Game");

 MainMenu(){
  super("mainMenu");
 }

 
 void display(){
    beginShape();
    fill(super.fill);
    rect(400,200,400,400);
    endShape();
    
    beginShape();
    fill(200, 102, 153);
    textSize(32);
    text("Hacker Defense", 475, 220, 600, 500); 
    endShape();
    
    //new game button
    newGame.display();
    resumeGame.display();
    exitGame.display();   
  }
  
  void update(int time){
    newGame.update();
    resumeGame.update();
    exitGame.update();
    
    if(mousePressed){
     //check each button
     if(newGame.pressed()){
       //Code here to react when game paused
       paused = false;
       reset = true;
       currentMenu = "gameMenu"; 
     } else if (resumeGame.pressed()){
      paused = false;
      currentMenu = "gameMenu";
     }else if (exitGame.pressed()){
      exit();
    }
  }
  }
}