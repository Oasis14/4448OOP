class Tower implements Cloneable {
   private int xPos, yPos;// cost, upCost, atkSpd, hp, dmg;
   private PImage sprite;
   private String name;
   private Projectile projectile;
   private Tower upgradeTower;
   
   private int lastFired;
   private int fireRate;
   private int range;
   
   Tower (String nameIn, String imageIn, int fireRate, int range, Projectile projectile) {
     this.name = nameIn;
     this.sprite = loadImage(imageIn);
     
     this.fireRate = fireRate;
     this.range=range;
     
     this.projectile = projectile;
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
     
     int centerX = this.xPos + this.sprite.width/2;
     int centerY = this.yPos + this.sprite.height/2;
     
     /// Determine which creep is closest
     Creep closestCreep = null;
     float oldDistance = 9999;
     float newDistance;
     FloatDict creepPosition;
     for (Creep creep : currentCreepList) {
       creepPosition = creep.getPos();
       newDistance = dist(centerX, centerY, creepPosition.get("centerX"), creepPosition.get("centerY"));
       if (newDistance < oldDistance && newDistance <= this.range && creep.getActive()){
         text("New Target Acquired " + closestCreep, 900, 50);
         closestCreep = creep;
         oldDistance = newDistance;
       }
     }
     
     // Spawn Projectile and shoot that target
     if (closestCreep != null)
     {

       currentMap.addProjectile(this.projectile, centerX, centerY, closestCreep);
     }
   }
   
   public int getWidth(){
     return this.sprite.width;
   }
   public int getHeight(){
     return this.sprite.height;
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