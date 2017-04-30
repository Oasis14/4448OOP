Log logger; 
int background;
Mouse mouse;
Map currentMap;
Player player;
Boolean paused, reset, playerName;
ArrayList projectilesToRemove;
ArrayList creepsToRemove;


//used for holding all the menus 
HashMap<String, Menu> menuList;
String currentMenu;

//Used For tower placing with buttons 
String towerName;
Boolean placeTower;

//database imports
import de.bezier.data.sql.*;
SQLite db;


void setup() {
  //Setting up dataBase stuff
  db = new SQLite(this,"HackerTD.db"); //open data base file
  if(db.connect()){
    println("Connected to the dataBase");
    String[] tableNames = db.getTableNames();
    println(tableNames[0]);
  }
  
  background=0;
  
  currentMenu = "mainMenu";
  // Setup window and game settings
  size(1200, 800);
  surface.setResizable(true);
  frameRate(30);

  // Initialize global objects
  
  logger = new Log();
  mouse = new Mouse(millis());
  
  // Initialize Map global objects
  currentMap = map1();
  paused=false;
  projectilesToRemove = new ArrayList();
  creepsToRemove = new ArrayList();
  
  menuList = new HashMap<String, Menu>();
  currentMenu = "playerNameMenu";
  menuList.put("gameMenu", new GameMenu());
  menuList.put("mainMenu", new MainMenu());
  menuList.put("gameOverMenu", new GameOverMenu());
  menuList.put("playerNameMenu", new PlayerNameMenu());
  menuList.put("highScores", new HighScore());
  player = new Player("");
  paused = true;
  reset = true;
  placeTower = false;
  
}

void draw() {
  int time = millis();
  mouse.update(time, mousePressed);
  mouseLogging(time);
  
  
  //if we reset the game or creat a new one clear the old map and start over
  if(reset){
    currentMap = map1();
    reset = false;
    player.reset();
  }
  

  //checks if you need to update the game state
  if(!paused){
    if(placeTower){
     if(mousePressed){
        if(mouseButton == LEFT){
          currentMap.addTower(towerName, mouseX, mouseY);
          placeTower = false;
        }
     }
    }
    currentMap.update(time);
    currentMap.display();
    //needed to do this after the map display to draw the new tower ontop
    if(placeTower){
     int xPos = mouseX - currentMap.protoTowers.get(towerName).sprite.width / 2;
     int yPos = mouseY - currentMap.protoTowers.get(towerName).sprite.height / 2;
     PImage towerImg = currentMap.protoTowers.get(towerName).sprite;
     tint(255,126);
     image(towerImg, xPos, yPos);
     noTint();
    }
  } else{
    currentMap.display();
  }
  menuList.get(currentMenu).update(time);

  menuList.get(currentMenu).display();
  fill(255);
  textSize(15);

  

  logger.update(time);
  logger.display(time);
}

void mouseLogging(int time) {
    /*if (mouse.currentEvent == "click") {
      if (mouseButton == LEFT){
        if (keyPressed && keyCode == CONTROL ){ 
          currentMap.addTower("basicTower", mouseX, mouseY);
        }
        else if(keyPressed && keyCode == SHIFT){
          currentMap.addTower("advancedTower", mouseX, mouseY); // This is Testing code
        }
        else if(keyPressed && keyCode == ALT){
          currentMap.addTower("arrowTower", mouseX, mouseY); // This is Testing code
        }
      }
      
      LogLine l = new LogLine("Mouse click at: " + str(time) + ": X " + str(mouseX) + ", Y " + str(mouseY), time, 5000);
      logger.add_line(l);
    }
    if (mouse.currentEvent == "hold") {
      LogLine l = new LogLine("Mouse hold at: " + str(time) + ": X " + str(mouseX) + ", Y " + str(mouseY), time, 5000);
      logger.add_line(l);
    }*/
}



boolean over_rect (int x, int y, int rectWidth, int rectHeight) {
  if (mouseX >= x && mouseX <= x+rectWidth && 
      mouseY >= y && mouseY <= y+rectHeight) {
    return true;
  } else {
    return false;
  }  
}

Map map1(){
  // Instantiate base map
  Map map = new Map(100, 100);
  
  //Add path points
  map.addPathPoint(900, 701);
  map.addPathPoint(550, 700);
  map.addPathPoint(550, 200);
  map.addPathPoint(300, 180);
  map.addPathPoint(350, 500);
  map.addPathPoint(50, 500);
  map.addPathPoint(50, 50);
  
  /*map.addPathPoint(50, 700);
  map.addPathPoint(60, 500);
  map.addPathPoint(100, 300);
  map.addPathPoint(180, 99);
  map.addPathPoint(320, 100);
  map.addPathPoint(400, 300);*/
  


  
  //Populate creeps
  map.addCreep("basicCreep",0); // Add creep at startPoint with 100 ms of delay
  map.addCreep("basicCreep",50); 
  map.addCreep("basicCreep",130); 
  map.addCreep("basicCreep",100); 
  map.addCreep("basicCreep2",150);
  map.addCreep("basicCreep",164);
  map.addCreep("basicCreep",180);
  map.addCreep("basicCreep2",195);
  map.addCreep("basicCreep2",210);
  map.addCreep("basicCreep2",200);

  map.addCreep("basicCreep2",250);
  map.addCreep("basicCreep",264);
  map.addCreep("basicCreep",280);
  map.addCreep("basicCreep2",295);
  map.addCreep("basicCreep2",310);
  map.addCreep("basicCreep2",260);
  map.addCreep("basicCreep",274);
  map.addCreep("basicCreep",280);
  map.addCreep("basicCreep2",300);
  map.addCreep("basicCreep2",310);
  map.addCreep("basicCreep2",315);
  map.addCreep("basicCreep",400);

  return map;
}