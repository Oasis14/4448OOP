class Creep {
  private int bounty;
  private float angle;
  private PathPoint pathPoint;
  private PImage sprite;
  private float xPos;
  private float yPos;
  private int speed;
  private int hp;
  private PShape hitbox;
  
  public int ID;
  
  
 Creep(){
   this.sprite = loadImage("laDefense.jpg");
 }
 
 /**
 * First checks collision to see if we're at pathpoint
 * Updates to new pathPoint if there's a collision
 * Moves in a direct line to the next pathPoint by this.speed amount
 **/
 public void path() throws Exception{
   if(this.pathPoint.collide(this.hitbox)){
     //If we hit the base
     if(this.pathPoint.isBase()){
        //GetGlobalMap().takeAwayLife();
        this.die();
     }
     this.pathPoint = this.pathPoint.getNextPoint();
   }
   
  float distToPoint = this.pathPoint.getX() - this.xPos / ( this.pathPoint.getY() - this.yPos);
  
  /** 
  * Use trig to get y += cos(theta) * speed
  * theta = arctan( (x_2 - x_1) / (y_2 - y_1) )
  * cos(arctan(x)) => 1 / sqrt(x^2 + 1^2)
  **/
  float yFactor = 1 / ( sqrt(distToPoint) + 1);
  this.yPos += yFactor * this.speed;
   
  // Same but with sin(arctan(x) => x / sqrt(x^2 + 1^2)
  float xFactor = distToPoint / ( sqrt(distToPoint) + 1);
  this.xPos += xFactor * this.speed;
 }
 
 
 /**
 * Kills this unit when it has been damaged sufficiently, or has 
 * reached the enemy base
 **/
 public void die(){
   // How will this work? This needs to access Map to remove a creep from CreepList
   // Maybe a public method on map?
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
    if (this.hp <= 0){
      die();
      // GetGlobalMap.addMoney( this.bounty )
    }
 }
 
 /**
 * The function which when run will display the creep on screen
 **/
 public void display(){
   image(this.sprite, this.xPos, this.yPos);
   rotate(90); // Not sure how to rotate
 }
 /**
 * Public function so that external classes can determine if this has died
 **/
 public int getHP(){
  return this.hp;
 }
 
 /**
 * Update function called that changes the state of this creep on each frame
 **/
 public void update() throws Exception{
   path();
 }
 
 /**
 * Returns a FloatDict since there are no Tuple objects with x and y positions
 * @return FloatDict x and y positions
 **/
 public FloatDict getPos(){
  FloatDict position = new FloatDict();
  position.set("x", this.xPos);
  position.set("y", this.yPos);
  return position;
 }
 
 
  
}