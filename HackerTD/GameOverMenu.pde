public class GameOverMenu extends Menu{
  Button newGame = new Button(475,300,250, 35,255,0,"","New Game");
  Button submitScore = new Button(475,350,250, 35,255,0,"","Submit Score");
  Button exitGame = new Button(475,400,250, 35,255,0,"","Exit Game");
  
  
  GameOverMenu(){
    super("gameOverMenu");
   }

  void display(){
    text("Score is " + player.score, 600, 400);
    
    beginShape();
    fill(super.fill);
    rect(400,200,400,400);
    endShape();
    
    beginShape();
    fill(200, 102, 153);
    textSize(32);
    text("Game Over", 475, 220, 600, 500); 
    endShape();
    
    //new game button
    newGame.display();
    submitScore.display();
    exitGame.display();
    

  }
  
  void update(int time){
    newGame.update();
    exitGame.update();
    submitScore.update();
    if(locked == false){
      //update buttons here
      
    }else{
     locked = false; 
    }
    
    if(mousePressed){
     //check each button
     if(newGame.pressed()){
       //Code here to react when game paused
       paused = false;
       reset = true;
       currentMenu = "gameMenu"; 
     } else if (exitGame.pressed()){
      exit();
     } else if (submitScore.pressed()){
       db.query("INSERT OR IGNORE INTO SCORES ('name','score') VALUES(\"%s\",%d);",player.name,player.score);
       db.query("UPDATE SCORES SET score = %d WHERE name == \"%s\" AND score < %d;",player.score, player.name, player.score);
     }
    }
  }
}