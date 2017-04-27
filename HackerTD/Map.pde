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
    
    this.protoCreeps.put("basicCreep", new Creep("basicCreep.png", 50));
    this.protoCreeps.put("basicCreep2", new Creep("basicCreep2.png", 100));
    
    this.protoProjectiles.put("bullet", new Projectile("images/projectile.png", 30, 7));
    this.protoProjectiles.put("laser", new Projectile("images/laserProjectile.png", 30, 7));
    
    this.protoTowers.put("basicTower", new Tower("testTower", "images/basicTower.png", 50, 150, this.protoProjectiles.get("bullet"))); // Tower Type, image, fire rate, range
    this.protoTowers.put("advancedTower", new Tower("advancedTower", "images/advancedTower2.png", 30, 250, this.protoProjectiles.get("laser"))); // Tower Type, image, fire rate, range
    this.protoTowers.put("arrowTower", new Tower("advancedTower", "images/arrowTower.png", 10, 250, this.protoProjectiles.get("bullet"))); // Tower Type, image, fire rate, range


  }
  
  /**
 * Function to add a tower to the map
 * @param String towerKey Name of the tower to be spawned from the proto list
 * @param int x position to spawn it at
 * @param int y position to spawn it at
 **/
  public void addTower(String towerKey, int x, int y){
    Tower towerToAdd = (Tower) protoTowers.get(towerKey);
    towerList.add((Tower) towerToAdd.placeTower(x,y - (towerToAdd.getHeight() / 4))) ;
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
  public void addCreep(String creepKey, int x, int y, int delay){
    creepList.add( (Creep) protoCreeps.get(creepKey).placeCreep(x,y, this.startPoint, delay)) ;
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
      
    }
  }
  
  void update(int time) {
    
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
        creep.update();
        creep.display();
      }
    }
    
    for (Tower tower : towerList) {
      tower.update();
      tower.display();
    }

    for (Projectile projectile : projectileList) {
      projectile.update();
      projectile.display();
    }
    
    projectileList.removeAll(projectilesToRemove);
    creepList.removeAll(creepsToRemove);

    text("Base Health : " + this.baseHealth, 900, 50);
  }
}