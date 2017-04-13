class Map {
  private ArrayList<PathPoint> pathPoints;
  private ArrayList<Creep> creepList;
  private ArrayList<Tower> towerList;
  private ArrayList<Projectile> projectileList;
  private HashMap protoTowers;
  private HashMap protoCreeps;
  private HashMap protoProjectiles;
  private PathPoint startPoint;
  private int baseHealth;
  private int background;
  
  Map (int bH, int backg) {
    baseHealth = bH;
    background = backg;
  }
  
  boolean addTower(String towerKey, int x, int y) {
    if (towerKey == "testTower") {
      towerList.add(new Tower(x,y,"testTower", "testImage.png"));
      return true;
    }
    return false;
  }
  
  void display () {
    background(background);
    for (Tower tower : towerList) {
      tower.display();
    }
  }
}