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
      this.sprite = loadImage("pathPoint.png");

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
  
  /**
  * Currently returns whether the pathpoint is within the hitbox, might want to change it so that the center is within the hitbox
  * @return Boolean whether the pathpoint is contained within the hitbox
  **/
  public Boolean collide(FloatDict hitbox){

    
    /** Vertex indices of rectangle
    *         y1
    *    o -------- o
    * x1 |          | x2
    *    o -------- o
    *         y2
    **/
    // Checks x position
    
    if((int) this.getCenterX() >= hitbox.get("x1") && (int) this.getCenterX() <= hitbox.get("x2")){
      // if x position is correct, check Y position
      if((int) this.getCenterY() >= hitbox.get("y1") && (int) this.getCenterY() <= hitbox.get("y2")){
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