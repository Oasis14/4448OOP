class Tower implements Cloneable {
   private int xPos, yPos;// cost, upCost, atkSpd, hp, dmg;
   private PImage sprite;
   private String name;
   private Projectile projectile;
   private Tower upgradeTower;
   
   private int lastFired;
   private int fireRate;
   private int range;
   
   Tower (String nameIn, String imageIn, int fireRate, int range) {
     this.name = nameIn;
     this.sprite = loadImage(imageIn);
     
     this.fireRate = fireRate;
     this.range=range;
   }
   
   /**
   * Function to display the tower
   **/
   public void display() {
     image(sprite, xPos, yPos); 
   }
   
   /**
   * Function to update the logic
   **/
   public void update(){
      if (frameCount - this.lastFired >= fireRate){
        this.shoot();
        lastFired = frameCount;
      }
   }
   
   
   protected Object placeTower(int x, int y){
     this.xPos = x - this.sprite.width / 2;
     this.yPos = y - this.sprite.height / 2;
     try{
       return this.clone();
     }
     catch(CloneNotSupportedException e)
     {
       return null;
     }
   }
   
    protected Object clone() throws CloneNotSupportedException
    {
        return super.clone();
    }
    
   public void shoot () {
     ArrayList<Creep> currentCreepList = currentMap.getCreepList();
     
     /// Determine which creep is closest
     Creep closestCreep = null;
     float oldDistance = 9999;
     float newDistance;
     FloatDict creepPosition;
     for (Creep creep : currentCreepList) {
       creepPosition = creep.getPos();
       newDistance = dist(this.xPos, this.yPos, creepPosition.get("x"), creepPosition.get("y"));
       if (newDistance < oldDistance && newDistance <= this.range){
         text("New Target Acquired " + closestCreep, 900, 50);
         closestCreep = creep;
         oldDistance = newDistance;
       }
     }
     
     // Spawn Projectile and shoot that target
     if (closestCreep != null)
     {
       currentMap.addProjectile("bullet", this.xPos, this.yPos, closestCreep);
     }
   }
   
   public void upgrade () {
     
   }
   public void destroy () {
     
   }
   public void refund () {
     
   }
   public void damage (int dmg) {
     
   }
}