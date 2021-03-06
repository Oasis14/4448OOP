class Map {
  public  String gameState = "run";
  private ArrayList<PathPoint> pathPoints;
  private ArrayList<Creep> creepList;
  private ArrayList<Tower> towerList;
  private ArrayList<Projectile> projectileList;
  private HashMap<String, Tower> protoTowers;
  private HashMap<String, Creep> protoCreeps;
  private HashMap<String, Projectile> protoProjectiles;
  private PathPoint startPoint;
  private int baseHealth;
  private int background;
  
  Map (int bH, int backg) {
    this.baseHealth = bH;
    this.background = backg;
    this.protoTowers = new HashMap<String, Tower>();
    this.protoProjectiles = new HashMap<String, Projectile>();
    this.protoCreeps = new HashMap<String, Creep>();
    this.pathPoints = new ArrayList<PathPoint>();
    this.creepList = new ArrayList<Creep>();
    this.towerList = new ArrayList<Tower>();
    this.projectileList = new ArrayList<Projectile>();
    

    // Populate prototypes
    
    this.protoCreeps.put("basicCreep1", new Creep("images/basicCreep.png", 50, 5));
    this.protoCreeps.put("basicCreep2", new Creep("images/basicCreep2.png", 100, 3));

    this.protoCreeps.put("basicCreep3", new Creep("images/basicCreep.png", 100, 6));
    this.protoCreeps.put("basicCreep4", new Creep("images/basicCreep2.png", 200, 4));
    this.protoCreeps.put("basicCreep5", new Creep("images/basicCreep5.png", 150, 7));
    this.protoCreeps.put("basicCreep6", new Creep("images/basicCreep6.png", 300, 4));
    this.protoCreeps.put("basicCreep7", new Creep("images/basicCreep.png", 200, 8));
    this.protoCreeps.put("basicCreep8", new Creep("images/basicCreep6.png", 400, 4));
    this.protoCreeps.put("basicCreep9", new Creep("images/basicCreep4.png", 250, 9));
    this.protoCreeps.put("basicCreep10", new Creep("images/basicCreep2.png", 500, 4));
    this.protoCreeps.put("basicCreep11", new Creep("images/basicCreep4.png", 300, 10));
    this.protoCreeps.put("basicCreep12", new Creep("images/basicCreep8.png", 600, 4));
    this.protoCreeps.put("basicCreep13", new Creep("images/basicCreep8.png", 500, 10));
    this.protoCreeps.put("basicCreep14", new Creep("images/basicCreep7.png", 1000, 4));
    this.protoCreeps.put("boss", new Creep("images/basicCreep3.png", 20000, 2));
    
    this.protoProjectiles.put("bullet", new Projectile("images/projectile.png", 30, 7));
    this.protoProjectiles.put("laser", new Projectile("images/laserProjectile.png", 50, 20));
    
    this.protoTowers.put("basicTower", new Tower("testTower", "images/basicTower.png", 50, 350, this.protoProjectiles.get("bullet"), 25)); // Tower Type, image, fire rate, range, cost
    this.protoTowers.put("advancedTower", new Tower("advancedTower", "images/advancedTower2.png", 30, 350, this.protoProjectiles.get("laser"), 50)); // Tower Type, image, fire rate, range, cost
    this.protoTowers.put("arrowTower", new Tower("advancedTower", "images/arrowTower.png", 10, 250, this.protoProjectiles.get("bullet"), 70)); // Tower Type, image, fire rate, range, cost


  }
  
  /**
 * Function to add a tower to the map
 * @param String towerKey Name of the tower to be spawned from the proto list
 * @param int x position to spawn it at
 * @param int y position to spawn it at
 **/
  public void addTower(String towerKey, int x, int y){
    Tower towerToAdd = (Tower) protoTowers.get(towerKey);
    if(player.money >= towerToAdd.cost){
      towerList.add((Tower) towerToAdd.placeTower(x,y - (towerToAdd.getHeight() / 4)));
      player.removeMoney(towerToAdd.cost);
    }else{
      fill(255,255,255);
      text("You don't have enough money", 600, 400);
    }  
}
  
  /**
  * Function to remove a tower from the map if it is destroyed or refunded
  * @param int ID of tower to be removed
  **/
  public void removeTower(int ID){
    for (Tower tower : towerList){
      /** Need to implement ID on towers
      if( tower.ID == ID){
        towerList.remove(tower);
      }
      **/
    }
  }
  
  /**
  * Add a creep to the map
  * @param String creepKey Key of creep to be cloned from proto list
  * @param int x position to spawn at
  * @param int y position to spawn at
  * @param int delay How many milliseconds to delay pathing
  **/
  public void addCreep(String creepKey, int delay){
    //println(creepKey);
    creepList.add( (Creep) protoCreeps.get(creepKey).placeCreep(this.startPoint.getCenterX(),this.startPoint.getCenterY(), this.startPoint, delay)) ;
  }
  

  /**
  * Return creepList
  * @return ArraList<Creep>
  **/
  public ArrayList<Creep> getCreepList(){
    return this.creepList;
  }
  
  /**
  * Add a path point to the map at given location and link it to any previously placed PathPoints
  * @param int x position for path point to spawn
  * @param int y position for path point to spawn
  **/
  public void addPathPoint(int x, int y){
    PathPoint nextPoint;
    if (pathPoints.isEmpty()){
      nextPoint = null;
    }
    else{
      nextPoint = pathPoints.get(pathPoints.size()-1);
    }
    PathPoint newPoint = new PathPoint(x, y, nextPoint);
    pathPoints.add(newPoint);
    this.startPoint = newPoint;
  }
  
    /**
  * Add a projectile to the map with a target
  * @param String projectileKey Key of projectile to be cloned from proto list
  * @param int x position to spawn at
  * @param int y position to spawn at
  * @param Creep target what it's shooting at
  **/
  public void addProjectile(Projectile projectileProto, int x, int y, Creep target){
    projectileList.add( (Projectile) projectileProto.shootProjectile(x,y, target)) ;
  }
  
  /**
  * Remove this projectile from the map
  * @param projectile the projectile to remove from the arrayList
  **/
  public void removeProjectile(Projectile projectile){
    projectilesToRemove.add(projectile);
  }
  
  public void takeDamage(int damage){
    this.baseHealth -= damage;
    if(this.baseHealth <= 0){
      currentMenu = "gameOverMenu";
      paused = true;
    }
  }
  
  void update(int time) {
    projectilesToRemove = new ArrayList();
    creepsToRemove = new ArrayList();
    
    for (Creep creep : creepList) {
      if (creep.getActive()){
        creep.update();
      }
    }
    
    for (Tower tower : towerList) {
      tower.update();
    }

    for (Projectile projectile : projectileList) {
      projectile.update();
    } 
    projectileList.removeAll(projectilesToRemove);
    creepList.removeAll(creepsToRemove);
    
  }
  
  /**
  * Function to display all the elements in the map
  * Order determines that pathPoints are at the bottom and towers are at top
  **/
  void display () {
    background(background);
    
    projectilesToRemove = new ArrayList();
    creepsToRemove = new ArrayList();
    

    for (PathPoint point : pathPoints) {
      point.display();
    }
    
    for (Creep creep : creepList) {
      if (creep.getActive()){
        creep.display();
      }
    }
    
    for (Tower tower : towerList) {
      tower.display();
    }
    
    for (Projectile projectile : projectileList) {
      projectile.display();
    }
    
    fill(255,255,255);
    text(player.name, 900, 30);
    text("Base Health : " + this.baseHealth, 900, 50);
    text("Money : " + player.money, 900, 70);
    text("Score : " + player.score, 900, 90);
  }
}