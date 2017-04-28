class PathPoint {
  private float xPos;
  private float yPos;
  private PathPoint nextPath;
  public PImage sprite;
  private Boolean isBase;
  private PShape hitbox;

  // Path Points will need to be created at the end and go back to beginning
  PathPoint(float xIn, float yIn, PathPoint nextPath){
    this.xPos = xIn;
    this.yPos = yIn;

    
    // The only PathPoint without a nextPath is the base
    if (nextPath == null){
      isBase = true;
      this.sprite = loadImage("pathPointBase.png");

    }
    else{
      isBase = false;
      this.nextPath = nextPath;
      this.sprite = loadImage("pathPoint.png");
    }

    hitbox = createShape();
    hitbox.beginShape();
    hitbox.vertex(xIn, yIn);
    hitbox.vertex(xIn + this.sprite.width, yIn);
    hitbox.vertex(xIn, yIn + this.sprite.height);
    hitbox.vertex(xIn + this.sprite.width, yIn+this.sprite.height);
    hitbox.endShape(CLOSE);

  }
  
   /**
   * The function which when run will display the point on screen
   **/
   public void display(){
     image(this.sprite, this.xPos, this.yPos);
   }
  
  /**
  * Function that returns the next pathPoint after this one
  * @return PathPoint next path point stored as instance variable
  **/
  public PathPoint getNextPoint(){
    return this.nextPath;
  }
  
  public Boolean collide(Creep creep){
    /**
    *  Checks to see if the center of the creep is within 3 pixels of the center of the pathPoint
    **/
    
    FloatDict creepPosition = creep.getPos();
    if(this.getCenterX()+3 >= creepPosition.get("centerX") && this.getCenterX()-3 <= creepPosition.get("centerX")){
      // if x position is correct, check Y position
      if(this.getCenterY()+3 >= creepPosition.get("centerY") && this.getCenterY()-3 <= creepPosition.get("centerY")){
          return true;
      }
    }
    return false;
  }
  
  public float getX(){
    return this.xPos;
  }
  
  public float getY(){
    return this.yPos;
  }
  
  public float getCenterX(){
    return this.xPos + this.sprite.width/2;
  }
  
  public float getCenterY(){
    return this.yPos + this.sprite.height/2;
  }
  
  public Boolean isBase(){
    return this.isBase;
  }
  

  
}