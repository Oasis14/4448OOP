class GameMenu extends Menu {
  
  Button pause = new Button(1150,10,20,20,255,0,"images/pause.png","");
  Button basicTower1 = new Button(5, 745, 50, 50, 255,0, "images/basicTower.png", "");
  Button advancedTower = new Button(65, 745,50,50,255,0,"images/advancedTower2.png","");
  Button arrowTower = new Button(125, 745,50,50,255,0,"images/arrowTower.png","");
  Label basicTower1Lable = new Label(10, 735,25, 255,Integer.toString(currentMap.protoTowers.get("basicTower").cost));
  Label advancedTowerLable = new Label(70, 735,25, 255,Integer.toString(currentMap.protoTowers.get("advancedTower").cost));
  Label arrowTowerLable = new Label(130, 735,25, 255,Integer.toString(currentMap.protoTowers.get("arrowTower").cost));
  
  GameMenu(){
    super("gameMenu");
  }
  
  void update(int time) {
    paused = false;
    
    //Make sure every Button is being updated.
    pause.update();
    basicTower1.update();
    advancedTower.update();
    arrowTower.update();
    
    if(mouse.currentEvent == "click"){
     //check each button
     if(pause.pressed()){
       //Code here to react when game paused
       currentMenu = "mainMenu";
       paused = true;
     } else if(basicTower1.pressed()){
      placeTower = true;
      towerName = "basicTower";
     } else if(advancedTower.pressed()){
      placeTower = true;
      towerName = "advancedTower";
     } else if(arrowTower.pressed()){
      placeTower = true;
      towerName = "arrowTower";
     }
    }
  }
  
  void display(){
    pause.display();
    basicTower1.display();
    advancedTower.display();
    arrowTower.display();
    basicTower1Lable.display();
    advancedTowerLable.display();
    arrowTowerLable.display();
  }

}