Log logger; 
int background = 0;
Mouse mouse;
Map currentMap;
Player player;
Boolean paused, reset;
ArrayList projectilesToRemove;
ArrayList creepsToRemove;

//used for holding all the menus 
HashMap<String, Menu> menuList;
String currentMenu;


void setup() {
  currentMenu = "mainMenu";
  // Setup window and game settings
  size(1200, 800);
  surface.setResizable(true);
  frameRate(30);

  // Initialize global objects
  player = new Player();
  logger = new Log();
  mouse = new Mouse(millis());
  
  // Initialize Map global objects
  currentMap = map1();
  paused=false;
  projectilesToRemove = new ArrayList();
  creepsToRemove = new ArrayList();
  
  menuList = new HashMap<String, Menu>();
  currentMenu = "mainMenu";
  menuList.put("gameMenu", new GameMenu());
  menuList.put("mainMenu", new MainMenu());
  paused = true;
  reset = true;
  
}

void draw() {
  int time = millis();  
  mouse.update(time, mousePressed);
  mouseLogging(time);
  
  menuList.get(currentMenu).update(time);
  
  //if we reset the game or creat a new one clear the old map and start over
  if(reset){
    currentMap = map1();
    reset = false;
  }
  

  //checks if you need to update the game state
  if(!paused){
    currentMap.update(time);
    currentMap.display();
  } else{
    currentMap.display();
  }
  
  menuList.get(currentMenu).display();
  fill(255);
  textSize(15);
  text(str(time), width-100, 10);

  

  text(frameRate,30,30);
  logger.update(time);
  logger.display(time);
}

void mouseLogging(int time) {
    if (mouse.currentEvent == "click") {
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
    }
}

/**
* THIS IS TEMPORARY FUNCTION WILL BE REMOVED
**/
void keyPressed(){
  if(keyCode == CONTROL){
    print("HE");
  }
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


  
  //Populate creeps
  map.addCreep("basicCreep", 400, 400, 0); // Add creep at (400, 400) with 100 ms of delay
  map.addCreep("basicCreep", 400, 400, 50); // Add creep at (400, 400) with 100 ms of delay
  map.addCreep("basicCreep", 400, 400, 130); // Add creep at (400, 400) with 100 ms of delay
  map.addCreep("basicCreep", 400, 400, 100); // Add creep at (400, 400) with 100 ms of delay
  map.addCreep("basicCreep2", 400, 400, 150);
  map.addCreep("basicCreep", 400, 400, 164);
  map.addCreep("basicCreep", 400, 400, 180);
  map.addCreep("basicCreep2", 400, 400, 195);
  map.addCreep("basicCreep2", 400, 400, 210);
  map.addCreep("basicCreep2", 400, 400, 200);

  map.addCreep("basicCreep2", 400, 400, 250);
  map.addCreep("basicCreep", 400, 400, 264);
  map.addCreep("basicCreep", 400, 400, 280);
  map.addCreep("basicCreep2", 400, 400, 295);
  map.addCreep("basicCreep2", 400, 400, 310);
  map.addCreep("basicCreep2", 400, 400, 260);
  map.addCreep("basicCreep", 400, 400, 274);
  map.addCreep("basicCreep", 400, 400, 280);
  map.addCreep("basicCreep2", 400, 400, 300);
  map.addCreep("basicCreep2", 400, 400, 310);
  map.addCreep("basicCreep2", 400, 400, 315);


  return map;
}