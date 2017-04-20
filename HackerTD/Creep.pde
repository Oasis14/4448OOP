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
  private int spawnFrame;
  private int delay;
  
  
  public int ID;
  
  
   Creep (String imageIn) {
      this.speed = 3;
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
 
 if(frameCount < this.spawnFrame+this.delay){
   return;
 }
 
  float slopeGrade = (this.pathPoint.getX() - this.xPos) / ( this.pathPoint.getY() - this.yPos);
  
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
  float yFactor = yMult / ( sqrt(pow(slopeGrade, 2) + 1));
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
  float xFactor = xMult * abs(slopeGrade) / ( sqrt(pow(slopeGrade, 2) + 1));
  float xTranslation = xFactor * this.speed;
  this.xPos += xTranslation;
  this.hitbox.set("x1", this.hitbox.get("x1") + xTranslation);
  this.hitbox.set("x2", this.hitbox.get("x2") + xTranslation);
  
  text("XMult: " + xMult + " YMult: " + yMult, 10, 700);
  text("Angle: " + atan(slopeGrade), 10, 720);
  text("Creep X1: " + (int) hitbox.get("x1") + " Creep X2: " + (int) hitbox.get("x2"), 10, 740);
  text("Creep Y1: " + (int) hitbox.get("y1") + " Creep Y2: " + (int) hitbox.get("y2"), 10, 760);
  text("PathPoint x: " + this.pathPoint.getX() + " PathPoint y: " + this.pathPoint.getY(), 10, 780);


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
 
 
 /**
 * PlaceCreep returns a clone of the protoType it is called on
 * @param int x position for clone to be created at
 * @param int y position for clone to be created at 
 * @param PathPoint startPoint the starting point the creep will path to
 * @param int delay how many milliseconds until movement starts
 * @return Object clone of creep to later be casted to Creep type
 **/
protected Object placeCreep(int x, int y, PathPoint startPoint, int delay){
    this.xPos = x - this.sprite.width / 2;
    this.yPos = y - this.sprite.height / 2;
    
    this.spawnFrame = frameCount;
    this.delay = delay;
    
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