class MainMenu extends Menu{
  
 Button newGame = new Button(475,300,250, 35,255,0,"");
   
 MainMenu(){
  super("MainMenu"); 
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
    
  }
  
  void update(int time){
    newGame.update();
    if(locked == false){
      //update buttons here
      
    }else{
     locked = false; 
    }
    
    if(mousePressed){
     //check each button
     if(newGame.pressed()){
       //Code here to react when game paused
       print("Play Pressed\n");
       super.name = "gameMenu";
       
     }
    }
  }
  
}