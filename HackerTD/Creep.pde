class Creep implements Cloneable {
  private int bounty;
  private float angle;
  private PathPoint pathPoint;
  private PImage sprite;
  private float xPos, yPos;
  private int speed;
  private int hp;
  private FloatDict hitbox;
  private int spawnFrame, delay;
  public int ID;
  private int totalDelay;
  private String state;
  
  
  Creep (String imageIn, int health) {
      this.speed = 3;
      this.hp = health;
      this.sprite = loadImage(imageIn);
      this.bounty = 10;
      this.state = "alive";
   }
 
 /**
 * First checks collision to see if we're at pathpoint
 * Updates to new pathPoint if there's a collision
 * Moves in a direct line to the next pathPoint by this.speed amount
 **/
 public void path(){
   if(this.pathPoint.collide(this)){
     //If we hit the base
     if(this.pathPoint.isBase()){
         currentMap.takeDamage(5); // subtract 5 hp
        this.die();
     }
     else{
       this.pathPoint = this.pathPoint.getNextPoint();
     }
   }
   
   FloatDict creepPosition = this.getPos();
   float xToTarget = this.pathPoint.getCenterX() - creepPosition.get("centerX");
   float yToTarget = this.pathPoint.getCenterY() - creepPosition.get("centerY");
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
     this.xPos = this.pathPoint.getCenterX() - (this.sprite.width/2);
     this.yPos = this.pathPoint.getCenterY() - (this.sprite.height/2);
   }
   
   this.updateHitbox();
   

 }
 
 private void updateHitbox() {
    this.hitbox.set("x1", this.xPos);
    this.hitbox.set("x2", this.xPos+this.sprite.width);
    this.hitbox.set("y1", this.yPos);
    this.hitbox.set("y2", this.yPos+this.sprite.height);
 }
 
 
 /**
 * Kills this unit when it has been damaged sufficiently, or has 
 * reached the enemy base
 **/
 public void die(){
   creepsToRemove.add(this);
   player.addMoney(this.bounty);
   // How will this work? This needs to access Map to remove a creep from CreepList
   // Maybe a public method on map?
 }
 
 
   public Boolean collide(Projectile projectile){    
    /** Vertex indices of rectangle
    *         y
    *   o -------- o
    * x |          | x + sprite.height
    *   o -------- o
    *         y + sprite.height
    **/
    // Checks x position
    
    if( this.xPos + this.sprite.width >= projectile.getX()  &&  this.xPos <= projectile.getX()){
      if(this.yPos + this.sprite.height >= projectile.getY() &&  this.yPos <= projectile.getY()){
         return true;
      }
    }
    return false;
  }
 
 
 /**
 * Deal damage to surrounding towers
 **/
 public void dealDmg(){
   // TODO
 }
 
 /**
 * Method for external classes to deal damage to a creep
 * @param health The amount to damage this tower by
 **/
 public void takeDmg(int health){
    this.hp -= health;
    if (this.hp <= 0 && this.state != "dead"){
      die();
      player.addScore( this.bounty );
      this.state = "dead";
    }
 }
 
 /**
 * The function which when run will display the creep on screen
 **/
 public void display(){
   // Display Sprite
   image(this.sprite, this.xPos, this.yPos);
   
   // Display health bar
   noStroke();
   rectMode(CORNER);
   fill( 255, 100-this.hp , 100-this.hp * 0.5 );
   rect(this.xPos,this.yPos-10, this.hp * 0.5, 5); 
 }
 /**
 * Public function so that external classes can determine if this has died
 **/
 public int getHP(){
  return this.hp;
 }
 
 /** 
  * This function adds to the delay if game is paused
  **/
 public void addDelay(){
   if(paused){
    this.totalDelay += 1;
   }
 }
 
 /**
 * Return whether the creep has spawned yet 
 * @return Boolean
 **/
 public Boolean getActive(){
     addDelay();
     return frameCount >= this.totalDelay;
 }
 
 /**
 * Update function called that changes the state of this creep on each frame
 **/
 public void update(){
   path();
 }
 
 /**
 * Returns a FloatDict since there are no Tuple objects with x and y positions
 * @return FloatDict x and y positions
 **/
 public FloatDict getPos(){
  FloatDict position = new FloatDict();
  position.set("x", this.xPos );
  position.set("y", this.yPos);
  position.set("centerX", this.xPos + this.sprite.width/2);
  position.set("centerY", this.yPos + this.sprite.height/2);

  return position;
 }
 
 
 /**
 * PlaceCreep returns a clone of the protoType it is called on
 * @param int x position for clone to be created at
 * @param int y position for clone to be created at 
 * @param PathPoint startPoint the starting point the creep will path to
 * @param int delay how many milliseconds until movement starts
 * @return Object clone of creep to later be casted to Creep type
 **/
 protected Object placeCreep(float x, float y, PathPoint startPoint, int delay){
    this.xPos = x - this.sprite.width / 2;
    this.yPos = y - this.sprite.height / 2;
    
    this.spawnFrame = frameCount;
    this.delay = delay;
    this.totalDelay = this.spawnFrame + this.delay;
    
    this.hitbox = new FloatDict(); // clone() makes a shallow copy. Need to instantiate all objects again
    this.hitbox.add("x1", this.xPos);
    this.hitbox.add("x2", this.xPos+this.sprite.width);
    this.hitbox.add("y1", this.yPos);
    this.hitbox.add("y2", this.yPos+this.sprite.height);
    this.pathPoint = startPoint;
    
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
 
 
  
}