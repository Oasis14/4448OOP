class Creep implements Cloneable {
  private int bounty;
  private float angle;
  private PathPoint pathPoint;
  private PImage sprite;
  private float xPos;
  private float yPos;
  private int speed;
  private int hp;
  private FloatDict hitbox;
  
  public int ID;
  
  
   Creep (int xIn, int yIn, String imageIn) {
     println(xIn);
      this.xPos = xIn;
      this.yPos = yIn;
      this.speed = 5;
      this.sprite = loadImage(imageIn);
      
      this.hitbox = new FloatDict();

   }
 
 /**
 * First checks collision to see if we're at pathpoint
 * Updates to new pathPoint if there's a collision
 * Moves in a direct line to the next pathPoint by this.speed amount
 **/
 public void path(){
   if(this.pathPoint.collide(this.hitbox)){
     //If we hit the base
     if(this.pathPoint.isBase()){
        //GetGlobalMap().takeAwayLife();
        this.die();
     }
     else{
       this.pathPoint = this.pathPoint.getNextPoint();
     }
 }
 
  float distToPoint = (this.pathPoint.getX() - this.xPos) / ( this.pathPoint.getY() - this.yPos);
  println(this.pathPoint.getX() - this.xPos);
  
  /** 
  * Use trig to get y += cos(theta) * speed
  * theta = arctan( (x_2 - x_1) / (y_2 - y_1) )
  * cos(arctan(x)) => 1 / sqrt(x^2 + 1^2)
  **/
  int yMult;
  if(this.pathPoint.getY() - this.yPos >= 0){
    yMult = 1;
  }else{
    yMult = -1;
  }
  float yFactor = yMult / ( sqrt(pow(distToPoint,2) + 1));
  float yTranslation = yFactor * this.speed;
  this.yPos += yTranslation;
  this.hitbox.set("y1", this.hitbox.get("y1") + yTranslation);
  this.hitbox.set("y2", this.hitbox.get("y2") + yTranslation);
   
  // Same but with sin(arctan(x) => x / sqrt(x^2 + 1^2)
  int xMult;
  if(this.pathPoint.getX() - this.xPos >= 0){
    xMult = 1;
  }else{
    xMult = -1;
  }
  float xFactor = xMult * distToPoint / ( sqrt(pow(distToPoint,2) + 1));
  float xTranslation = xFactor * this.speed;
  this.xPos += xTranslation;
  this.hitbox.set("x1", this.hitbox.get("x1") + xTranslation);
  this.hitbox.set("x2", this.hitbox.get("x2") + xTranslation);
  
 }
 
 
 /**
 * Kills this unit when it has been damaged sufficiently, or has 
 * reached the enemy base
 **/
 public void die(){
   player.addMoney(this.bounty);
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
 public void update(){
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
 
  protected Object placeCreep(int x, int y, PathPoint startPoint){
    this.xPos = x - this.sprite.width / 2;
    this.yPos = y - this.sprite.height / 2;
   
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