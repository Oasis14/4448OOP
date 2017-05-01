class HighScore extends Menu{
  
  Score[] highScore = new Score[5];
  Button back = new Button(475,560,250, 35,255,0,"","     Back");
  Label leaderBoard = new Label(450, 250,50, 255,"Leader Board");
  Label categories = new Label(470, 300,32, 255,"Name      Score");
  
  HighScore(){
   super("highScore"); 
  }
  
  private void getScores(){
  
    int i = 0;
    db.query( "SELECT * FROM SCORES ORDER BY SCORE DESC, NAME LIMIT 5;");
        while (db.next())
        {
            Score t = new Score();
            db.setFromRow( t );
            highScore[i] = t;
            i ++;
            
        }
  }
  
  public void display(){
    beginShape();
    fill(super.fill);
    rect(400,200,400,400);
    endShape();
    
    back.display();
    leaderBoard.display();
    categories.display();
    
    this.getScores();
    for(int i = 0; i < 5; i++){
     if(highScore[i] != null){
      highScore[i].display(470, 350 + 50*i);
     }
    }
  }
  
  public void update(int time){
    back.update();
    
    if(mousePressed){
     if(back.pressed()){
       paused = true;
       reset = false;
       currentMenu = "gameOverMenu"; 
     } 
    }
  }
  
  
}