class Projectile implements Cloneable {
   private float xPos, yPos;// cost, upCost, atkSpd, hp, dmg;
   private PImage sprite;
   private int dmg;
   private int speed;
   private Creep target;
   private float angle;
   
   Projectile (String imageIn, int dmg, int speed) {
     this.sprite = loadImage(imageIn);     
     this.dmg = dmg;
     this.speed = speed;
   }
   
   /**
   * Function to display the Projectile
   **/
   public void display() {
     image(sprite, xPos, yPos); 
   }
   
   /**
   * Function to update the logic
   **/
   public void update(){
      if(this.target.collide(this)){
       //If we hit the enemy
       this.target.takeDmg(this.dmg);
       currentMap.removeProjectile(this);
       }
     else{
      this.updatePos();
     }
   }
   
   /**
   * Move the bullet closer
   **/
   public void updatePos(){
     FloatDict creepPosition = this.target.getPos();
     float xToTarget = creepPosition.get("centerX") - this.getX();
     float yToTarget = creepPosition.get("centerY") - this.getY();
     float distToTarget = sqrt(xToTarget*xToTarget + yToTarget*yToTarget);
     
     if (distToTarget > this.speed){
       //This is the total if you can only go by right angles, it is to get the ratios
       float totalToTarget = abs(xToTarget) + abs(yToTarget);
       float ratioX = xToTarget / totalToTarget;
       float ratioY = yToTarget / totalToTarget;
       float moveX = this.speed * ratioX;
       float moveY = this.speed * ratioY;
       this.xPos += moveX;
       this.yPos += moveY;
     } else {
       //move creep so hitbox is centered on pathPoint
       this.xPos = creepPosition.get("centerX") - (this.sprite.width/2);
       this.yPos = creepPosition.get("centerY") - (this.sprite.height/2);
     }
   }
   
   
   protected Object shootProjectile(int x, int y, Creep target){
     this.target = target;
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
   
   public float getX(){
    return this.xPos;
  }
  
  public float getY(){
    return this.yPos;
  }
   
    protected Object clone() throws CloneNotSupportedException
    {
        return super.clone();
    }
    
   
}