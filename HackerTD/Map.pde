class Map {
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
    

    // Populate prototypes
    this.protoTowers.put("basicTower", new Tower(0,0,  "testTower", "testImage.png"));
    
    this.protoCreeps.put("basicCreep", new Creep("basicCreep.png"));
    this.protoCreeps.put("basicCreep2", new Creep("basicCreep2.png"));
  }
  
  /**
 * Function to add a tower to the map
 * @param String towerKey Name of the tower to be spawned from the proto list
 * @param int x position to spawn it at
 * @param int y position to spawn it at
 **/
  public void addTower(String towerKey, int x, int y){
    towerList.add( (Tower) protoTowers.get(towerKey).placeTower(x,y)) ;
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
  
  void update(int time) {
    
  }
  
  /**
  * Function to display all the elements in the map
  * Order determines that pathPoints are at the bottom and towers are at top
  **/
  void display () {
    background(background);
    
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
      tower.display();
    }

  }
}