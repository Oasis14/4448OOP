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

    
    this.protoTowers.put("basicTower", new Tower(0,0,  "testTower", "testImage.png"));
  }
  
  boolean addTower(String towerKey, int x, int y){
    towerList.add( (Tower) protoTowers.get(towerKey).placeTower(x,y)) ;
    return true;
    }
  
  void update(int time) {
    
  }
  
  void display () {
    background(background);
    for (Tower tower : towerList) {
      tower.display();
    }
  }
}